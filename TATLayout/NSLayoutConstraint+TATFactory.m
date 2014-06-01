//
//  NSLayoutConstraint+TATFactory.m
//  TATLayout
//

#import "NSLayoutConstraint+TATFactory.h"

static NSString * const TATFactoryAttributes = @"left, right, top, bottom, leading, trailing, width, height, centerX, centerY or baseline.";
static NSString * const TATFactoryErrorEmptyString = @" It's an empty string.";
static NSString * const TATFactoryErrorExpectedARelation = @"Expected a relation. Relation must be one of <=, == or >=.";
static NSString * const TATFactoryErrorExpectedAView = @"Expected a view. View names must start with a letter or an underscore, then contain letters, numbers, and underscores.";
static NSString * const TATFactoryErrorExpectedAViewOrConstant = @"Expected a view or constant.";
static NSString * const TATFactoryErrorExpectedEndOfEquation = @"Expected the end of the format string.";
static NSString * const TATFactoryErrorPrefix = @"Unable to parse constraint format:";
static NSString * const TATFactoryVisualErrorLocationMarker = @"^";
static NSString * const TATFactoryVisualErrorLocationPrefix = @"\n(whitespace stripped)\n";

static NSString *TATFactoryErrorNotAKeyInViews(NSString *viewName) {
    return [viewName stringByAppendingString:@" is not a key in the views dictionary."];
}

static NSString *TATFactoryErrorNotAKeyInMetrics(NSString *metricName) {
    return [metricName stringByAppendingString:@" is not a key in the metrics dictionary."];
}

static NSString *TATFactoryErrorExpectedAnAttribute() {
    return [@"Expected an attribute. Attribute names must start with a dot and be one of " stringByAppendingString:TATFactoryAttributes];
}

static NSString *TATFactoryErrorNotAnAttribute(NSString *attributeName) {
    return [attributeName stringByAppendingFormat:@" is not a valid attribute name. Attribute names must be one of %@", TATFactoryAttributes];
}

static NSString *TATFactoryErrorDoesNotHaveASuperview(NSString *viewName) {
    return [viewName stringByAppendingString:@" doesn't have a superview. When using superview as second item, the first view must be added to its superview before creating the constraint."];
}

static NSString *TATFactoryVisualErrorLocation(NSString *equation, NSRange matchRange) {
    return [NSString stringWithFormat:@"%@%@\n%*s%@",
            TATFactoryVisualErrorLocationPrefix,
            equation,
            (int)NSMaxRange(matchRange), "",
            TATFactoryVisualErrorLocationMarker];
}

static NSException *TATFactoryException(NSString *description, NSString *equation, NSRange matchRange) {
    NSString *reason = [NSString stringWithFormat:@"%@%@%@%@",
                        TATFactoryErrorPrefix,
                        equation ? @"\n" : @"",
                        description,
                        equation ? TATFactoryVisualErrorLocation(equation, matchRange) : @""];
    return [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
}

@implementation NSLayoutConstraint (TATFactory)

#pragma mark - Creating Constraints with the Equation Format

+ (NSLayoutConstraint *)tat_constraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    if (!format.length) {
        @throw TATFactoryException(TATFactoryErrorEmptyString, nil, NSMakeRange(0, 0));
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
        @throw TATFactoryException(TATFactoryErrorExpectedAView, equation, NSMakeRange(0, 0));
    }
    NSString *firstItemName = [equation substringWithRange:firstItemRange];
	firstItem = views[firstItemName];
    if (!firstItem) {
        @throw TATFactoryException(TATFactoryErrorNotAKeyInViews(firstItemName), equation, firstItemRange);
    }
    
    // First attribute
    NSRange firstAttributeRange = [match rangeAtIndex:2];
    if (firstAttributeRange.location == NSNotFound) {
        @throw TATFactoryException(TATFactoryErrorExpectedAnAttribute(), equation, [match range]);
    }
    NSString *firstAttributeName = [equation substringWithRange:firstAttributeRange];
    firstAttribute = [attributes[firstAttributeName] intValue];
    if (!firstAttribute) {
        @throw TATFactoryException(TATFactoryErrorNotAnAttribute(firstAttributeName), equation, firstAttributeRange);
    }
    
    // Relation
    NSRange relationRange = [match rangeAtIndex:3];
    if (relationRange.location == NSNotFound) {
        @throw TATFactoryException(TATFactoryErrorExpectedARelation, equation, firstAttributeRange);
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
                    @throw TATFactoryException(TATFactoryErrorDoesNotHaveASuperview(firstItemName), equation, secondItemRange);
                }
            }
        } else {
            secondItem = views[secondItemName];
            if (!secondItem) {
                @throw TATFactoryException(TATFactoryErrorNotAKeyInViews(secondItemName), equation, secondItemRange);
            }
        }
        
        // Second attribute
        NSRange secondAttributeRange = [match rangeAtIndex:5];
        NSString *secondAttributeName = [equation substringWithRange:secondAttributeRange];
        secondAttribute = [attributes[secondAttributeName] intValue];
        if (!secondAttribute) {
            @throw TATFactoryException(TATFactoryErrorNotAnAttribute(secondAttributeName), equation, secondAttributeRange);
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
                    @throw TATFactoryException(TATFactoryErrorNotAKeyInMetrics(multiplierName), equation, [match range]);
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
                    @throw TATFactoryException(TATFactoryErrorNotAKeyInMetrics(constantName), equation, [match range]);
                }
                constant = [metrics[constantName] doubleValue];
            }
            NSString *signString = [equation substringWithRange:signRange];
            if ([signString isEqualToString:@"-"]) {
                constant = -constant;
            }
        }
    } else {
        // Constant when there is only one item
        NSRange constantNumberRange = [match rangeAtIndex:11];
        if (constantNumberRange.location != NSNotFound) {
            NSString *constantNumber = [equation substringWithRange:constantNumberRange];
            constant = [constantNumber doubleValue];
        } else {
            NSRange constantNameRange = [match rangeAtIndex:12];
            if (constantNameRange.location == NSNotFound) {
                @throw TATFactoryException(TATFactoryErrorExpectedAViewOrConstant, equation, [match range]);
            }
            NSString *constantName = [equation substringWithRange:constantNameRange];
            if (!metrics[constantName]) {
                @throw TATFactoryException(TATFactoryErrorNotAKeyInMetrics(constantName), equation, [match range]);
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
                @throw TATFactoryException(TATFactoryErrorNotAKeyInMetrics(priorityName), equation, [match range]);
            }
            priority = [metrics[priorityName] doubleValue];
        }
    }
    
    // Checking for extra characters at the end of the equation string because the regular expression is intentionally permissive in order to provide diagnostic messages (like the following).
    if ([match range].length < equation.length) {
        @throw TATFactoryException(TATFactoryErrorExpectedEndOfEquation, equation, [match range]);
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

+ (NSArray *)tat_constraintsWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:[formats count]];
    for (id format in formats) {
        NSParameterAssert([format isKindOfClass:[NSString class]]);
        [constraints addObject:[self tat_constraintWithEquationFormat:format metrics:metrics views:views]];
    }
    return [constraints copy];
}

@end
