//
//  NSLayoutConstraint+TATConstraintFactory.m
//  TATLayout
//

#import "NSLayoutConstraint+TATConstraintFactory.h"

static NSString * const TATConstraintFactoryAttributeNames = @"left, right, top, bottom, leading, trailing, width, height, centerX, centerY or baseline.";
static NSString * const TATConstraintFactoryErrorEmptyString = @" It's an empty string.";
static NSString * const TATConstraintFactoryErrorExpectedARelation = @"Expected a relation. Relation must be one of <=, == or >=.";
static NSString * const TATConstraintFactoryErrorExpectedAView = @"Expected a view. View names must start with a letter or an underscore, then contain letters, numbers, and underscores.";
static NSString * const TATConstraintFactoryErrorExpectedAViewOrConstant = @"Expected a view or constant.";
static NSString * const TATConstraintFactoryErrorExpectedEndOfEquation = @"Expected the end of the format string.";
static NSString * const TATConstraintFactoryErrorPrefix = @"Unable to parse constraint format:";
static NSString * const TATConstraintFactoryVisualErrorLocationMarker = @"^";
static NSString * const TATConstraintFactoryVisualErrorLocationPrefix = @"\n(whitespace stripped)\n";

static NSString *TATConstraintFactoryErrorNotAKeyInViews(NSString *viewName) {
    return [viewName stringByAppendingString:@" is not a key in the views dictionary."];
}

static NSString *TATConstraintFactoryErrorNotAKeyInMetrics(NSString *metricName) {
    return [metricName stringByAppendingString:@" is not a key in the metrics dictionary."];
}

static NSString *TATConstraintFactoryErrorExpectedAnAttribute() {
    return [@"Expected an attribute. Attribute names must start with a dot and be one of " stringByAppendingString:TATConstraintFactoryAttributeNames];
}

static NSString *TATConstraintFactoryErrorNotAnAttribute(NSString *attributeName) {
    return [attributeName stringByAppendingFormat:@" is not a valid attribute name. Attribute names must be one of %@",
            TATConstraintFactoryAttributeNames];
}

static NSString *TATConstraintFactoryErrorDoesNotHaveASuperview(NSString *viewName) {
    return [viewName stringByAppendingString:@" doesn't have a superview. When using superview as second item, the first view must be added to its superview before creating the constraint."];
}

static NSString *TATConstraintFactoryVisualErrorLocation(NSString *equation, NSRange matchRange) {
    return [NSString stringWithFormat:@"%@%@\n%*s%@",
            TATConstraintFactoryVisualErrorLocationPrefix,
            equation,
            (int)NSMaxRange(matchRange), "",
            TATConstraintFactoryVisualErrorLocationMarker];
}

static NSException *TATConstraintFactoryException(NSString *description, NSString *equation, NSRange matchRange) {
    NSString *reason = [NSString stringWithFormat:@"%@%@%@%@",
                        TATConstraintFactoryErrorPrefix,
                        equation ? @"\n" : @"",
                        description,
                        equation ? TATConstraintFactoryVisualErrorLocation(equation, matchRange) : @""];
    return [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
}

@implementation NSLayoutConstraint (TATConstraintFactory)

#pragma mark - Creating Constraints with the Equation Format

+ (NSLayoutConstraint *)tat_constraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    if (!format.length) {
        @throw TATConstraintFactoryException(TATConstraintFactoryErrorEmptyString, nil, NSMakeRange(0, 0));
    }
    
    id firstItem;
    NSLayoutAttribute firstAttribute;
	NSLayoutRelation relation;
    id secondItem;
    NSLayoutAttribute secondAttribute = NSLayoutAttributeNotAnAttribute;
    CGFloat multiplier = 1;
    CGFloat constant = 0;
	CGFloat priority = 1000;
    
    static NSDictionary *attributes;
    if (!attributes) {
        attributes = @{@"left": @(NSLayoutAttributeLeft),
                       @"right": @(NSLayoutAttributeRight),
                       @"top": @(NSLayoutAttributeTop),
                       @"bottom": @(NSLayoutAttributeBottom),
                       @"leading": @(NSLayoutAttributeLeading),
                       @"trailing": @(NSLayoutAttributeTrailing),
                       @"width": @(NSLayoutAttributeWidth),
                       @"height": @(NSLayoutAttributeHeight),
                       @"centerX": @(NSLayoutAttributeCenterX),
                       @"centerY": @(NSLayoutAttributeCenterY),
                       @"baseline": @(NSLayoutAttributeBaseline)};
    }
    
    static NSDictionary *relations;
    if (!relations) {
        relations = @{@"<=": @(NSLayoutRelationLessThanOrEqual),
                      @"==": @(NSLayoutRelationEqual),
                      @">=": @(NSLayoutRelationGreaterThanOrEqual)};
    }
    
    static NSRegularExpression *regex;
    if (!regex) {
        NSString *pattern = @"^([a-z_]\\w*)?(?:\\.)?([a-z]+)?([=><]=)?(?>([a-z_]\\w*)\\.([a-z]+)(?:\\*(?:(\\d*\\.*\\d+)|([a-z_]\\w*)))?(?:([+\\-])(?:(\\d*\\.*\\d+)|([a-z_]\\w*)))?|(?:(\\d*\\.*\\d+)|([a-z_]\\w*)))?(?:@(?:(\\d*\\.*\\d+)|([a-z_]\\w*)))?";
        NSError *error;
        regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    }
    
    NSString *equation = [format stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSTextCheckingResult *match = [regex firstMatchInString:equation options:0 range:NSMakeRange(0, equation.length)];
    
    // First item
    NSRange firstItemRange = [match rangeAtIndex:1];
    if (firstItemRange.location == NSNotFound) {
        @throw TATConstraintFactoryException(TATConstraintFactoryErrorExpectedAView, equation, NSMakeRange(0, 0));
    }
    NSString *firstItemName = [equation substringWithRange:firstItemRange];
	firstItem = views[firstItemName];
    if (!firstItem) {
        @throw TATConstraintFactoryException(TATConstraintFactoryErrorNotAKeyInViews(firstItemName), equation, firstItemRange);
    }
    
    // First attribute
    NSRange firstAttributeRange = [match rangeAtIndex:2];
    if (firstAttributeRange.location == NSNotFound) {
        @throw TATConstraintFactoryException(TATConstraintFactoryErrorExpectedAnAttribute(), equation, [match range]);
    }
    NSString *firstAttributeName = [equation substringWithRange:firstAttributeRange];
    firstAttribute = [attributes[firstAttributeName] intValue];
    if (!firstAttribute) {
        @throw TATConstraintFactoryException(TATConstraintFactoryErrorNotAnAttribute(firstAttributeName), equation, firstAttributeRange);
    }
    
    // Relation
    NSRange relationRange = [match rangeAtIndex:3];
    if (relationRange.location == NSNotFound) {
        @throw TATConstraintFactoryException(TATConstraintFactoryErrorExpectedARelation, equation, firstAttributeRange);
    }
    NSString *relationName = [equation substringWithRange:relationRange];
	relation = [relations[relationName] intValue];
    
    // Second item
    NSRange secondItemRange = [match rangeAtIndex:4];
    if (secondItemRange.location != NSNotFound) {
        NSString *secondItemName = [equation substringWithRange:secondItemRange];
        if ([secondItemName isEqualToString:@"superview"]) {
            if ([firstItem isKindOfClass:[UIView class]]) {
                secondItem = ((UIView *)firstItem).superview;
                if (!secondItem) {
                    @throw TATConstraintFactoryException(TATConstraintFactoryErrorDoesNotHaveASuperview(firstItemName), equation, secondItemRange);
                }
            }
        } else {
            secondItem = views[secondItemName];
            if (!secondItem) {
                @throw TATConstraintFactoryException(TATConstraintFactoryErrorNotAKeyInViews(secondItemName), equation, secondItemRange);
            }
        }
        
        // Second attribute
        NSRange secondAttributeRange = [match rangeAtIndex:5];
        NSString *secondAttributeName = [equation substringWithRange:secondAttributeRange];
        secondAttribute = [attributes[secondAttributeName] intValue];
        if (!secondAttribute) {
            @throw TATConstraintFactoryException(TATConstraintFactoryErrorNotAnAttribute(secondAttributeName), equation, secondAttributeRange);
        }
        
        // Multiplier
        NSRange multiplierNumberRange = [match rangeAtIndex:6];
        if (multiplierNumberRange.location != NSNotFound) {
            NSString *multiplierString = [equation substringWithRange:multiplierNumberRange];
            multiplier = [multiplierString doubleValue];
        } else {
            NSRange multiplierNameRange = [match rangeAtIndex:7];
            if (multiplierNameRange.location != NSNotFound) {
                NSString *multiplierName = [equation substringWithRange:multiplierNameRange];
                if (!metrics[multiplierName]) {
                    @throw TATConstraintFactoryException(TATConstraintFactoryErrorNotAKeyInMetrics(multiplierName), equation, [match range]);
                }
                multiplier = [metrics[multiplierName] doubleValue];
            }
        }
        
        // Constant
        NSRange signRange = [match rangeAtIndex:8];
        if (signRange.location != NSNotFound) {
            NSRange constantNumberRange = [match rangeAtIndex:9];
            if (constantNumberRange.location != NSNotFound) {
                NSString *constantString = [equation substringWithRange:constantNumberRange];
                constant = [constantString doubleValue];
            } else {
                NSRange constantNameRange = [match rangeAtIndex:10];
                NSString *constantName = [equation substringWithRange:constantNameRange];
                if (!metrics[constantName]) {
                    @throw TATConstraintFactoryException(TATConstraintFactoryErrorNotAKeyInMetrics(constantName), equation, [match range]);
                }
                constant = [metrics[constantName] doubleValue];
            }
            NSString *signString = [equation substringWithRange:signRange];
            if ([signString isEqualToString:@"-"]) {
                constant = -constant;
            }
        }
    } else {
        // Unary constraint constant
        NSRange constantNumberRange = [match rangeAtIndex:11];
        if (constantNumberRange.location != NSNotFound) {
            NSString *constantNumber = [equation substringWithRange:constantNumberRange];
            constant = [constantNumber doubleValue];
        } else {
            NSRange constantNameRange = [match rangeAtIndex:12];
            if (constantNameRange.location == NSNotFound) {
                @throw TATConstraintFactoryException(TATConstraintFactoryErrorExpectedAViewOrConstant, equation, [match range]);
            }
            NSString *constantName = [equation substringWithRange:constantNameRange];
            if (!metrics[constantName]) {
                @throw TATConstraintFactoryException(TATConstraintFactoryErrorNotAKeyInMetrics(constantName), equation, [match range]);
            }
            constant = [metrics[constantName] doubleValue];
        }
    }
    
    // Priority
    NSRange priorityNumberRange = [match rangeAtIndex:13];
	if (priorityNumberRange.location != NSNotFound) {
        NSString *priorityString = [equation substringWithRange:priorityNumberRange];
		priority = [priorityString doubleValue];
    } else {
        NSRange priorityNameRange = [match rangeAtIndex:14];
        if (priorityNameRange.location != NSNotFound) {
            NSString *priorityName = [equation substringWithRange:priorityNameRange];
            if (!metrics[priorityName]) {
                @throw TATConstraintFactoryException(TATConstraintFactoryErrorNotAKeyInMetrics(priorityName), equation, [match range]);
            }
            priority = [metrics[priorityName] doubleValue];
        }
    }
    
    // Checking for extra characters at the end of the equation because the regex is intentionally permissive to provide diagnostic messages (like the following).
    if ([match range].length < equation.length) {
        @throw TATConstraintFactoryException(TATConstraintFactoryErrorExpectedEndOfEquation, equation, [match range]);
    }

    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:firstItem
                                                                  attribute:firstAttribute
                                                                  relatedBy:relation
                                                                     toItem:secondItem
                                                                  attribute:secondAttribute
                                                                 multiplier:multiplier
                                                                   constant:constant];
    constraint.priority = priority;
    return constraint;
}

@end
