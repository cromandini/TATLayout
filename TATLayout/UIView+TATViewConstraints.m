//
//  UIView+TATViewConstraints.m
//  TATLayout
//

#import "UIView+TATViewConstraints.h"
#import "NSLayoutConstraint+TATConstraintFactory.h"
#import "NSLayoutConstraint+TATConstraintInstall.h"

static NSString * TATViewConstraintsReceiverKeyword = @"self";
static NSString * const TATViewConstraintsErrorNotAString = @"%@ is not a format string.";

@implementation UIView (TATViewConstraints)

#pragma mark - Constraining Layout Attributes

- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSString *equation = [NSString stringWithFormat:@"%@.%@", TATViewConstraintsReceiverKeyword, format];
    NSDictionary *viewsIncludingSelf;
    if (!views) {
        viewsIncludingSelf = @{TATViewConstraintsReceiverKeyword: self};
    } else {
        NSMutableDictionary *mutableViews = [views mutableCopy];
        mutableViews[TATViewConstraintsReceiverKeyword] = self;
        viewsIncludingSelf = mutableViews;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:viewsIncludingSelf];
    [constraint tat_install];
    return constraint;
}

- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format
{
    return [self tat_constrainLayoutAttributeWithEquationFormat:format metrics:nil views:nil];
}

- (NSArray *)tat_constrainLayoutAttributesWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSMutableArray *mutableConstraints = [NSMutableArray new];
    for (id item in formats) {
        NSAssert([item isKindOfClass:[NSString class]], TATViewConstraintsErrorNotAString, item);
        NSString *format = (NSString *)item;
        [mutableConstraints addObject:[self tat_constrainLayoutAttributeWithEquationFormat:format metrics:metrics views:views]];
    }
    return [mutableConstraints copy];
}

- (NSArray *)tat_constrainLayoutAttributesWithEquationFormats:(NSArray *)formats
{
    return [self tat_constrainLayoutAttributesWithEquationFormats:formats metrics:nil views:nil];
}

@end
