//
//  UIView+TATViewConstraints.m
//  TATLayout
//

#import "UIView+TATViewConstraints.h"
#import "NSLayoutConstraint+TATConstraintFactory.h"

static NSString * TATViewConstraintsReceiverKey = @"self";

@implementation UIView (TATViewConstraints)

#pragma mark - Constraining Layout Attributes

- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSString *equation = [NSString stringWithFormat:@"%@.%@", TATViewConstraintsReceiverKey, format];
    NSDictionary *viewsWithSelf;
    if (!views) {
        viewsWithSelf = @{TATViewConstraintsReceiverKey: self};
    } else {
        NSMutableDictionary *mutableViews = [views mutableCopy];
        mutableViews[TATViewConstraintsReceiverKey] = self;
        viewsWithSelf = mutableViews;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:viewsWithSelf];
    // install constraint
    return constraint;
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
