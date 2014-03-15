//
//  UIView+TATViewConstraints.m
//  TATLayout
//

#import "UIView+TATViewConstraints.h"
#import "NSLayoutConstraint+TATConstraintFactory.h"

static NSString * TATViewConstraintsEquationFormatPrefix = @"tatView.";

@implementation UIView (TATViewConstraints)

#pragma mark - Constraining Layout Attributes

- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    // prepend view in format
    NSString *equation = [TATViewConstraintsEquationFormatPrefix stringByAppendingString:format];
    // create constraint
    NSLayoutConstraint *c = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:nil views:nil];
    // install constraint
    NSLog(@"%@", c);
    // return constraint
    return nil;
}

- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format
{
    return [self tat_constrainLayoutAttributeWithEquationFormat:format metrics:nil views:nil];
}

- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics
{
    return [self tat_constrainLayoutAttributeWithEquationFormat:format metrics:metrics views:nil];
}

- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format views:(NSDictionary *)views
{
    return [self tat_constrainLayoutAttributeWithEquationFormat:format metrics:nil views:views];
}

- (NSArray *)tat_constrainLayoutAttributesWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSMutableArray *mutableConstraints = [NSMutableArray new];
    for (id item in formats) {
        NSAssert([item isKindOfClass:[NSString class]], @"%@ is not a format string.", item);
        NSString *format = (NSString *)item;
        [mutableConstraints addObject:[self tat_constrainLayoutAttributeWithEquationFormat:format metrics:metrics views:views]];
    }
    return [mutableConstraints copy];
}

@end
