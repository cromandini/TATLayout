//
//  UIView+TATViewConstraints.m
//  TATLayout
//

#import "UIView+TATViewConstraints.h"
#import "NSLayoutConstraint+TATConstraintFactory.h"
#import "NSLayoutConstraint+TATConstraintInstallation.h"

static NSString * TATViewConstraintsReceiverKeyword = @"self";

@implementation UIView (TATViewConstraints)

#pragma mark - Constraining Layout Attributes

- (NSLayoutConstraint *)tat_constrainLayoutAttributeUsingEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSString *theFormat = [NSString stringWithFormat:@"%@.%@", TATViewConstraintsReceiverKeyword, format];
    NSDictionary *theViews;
    if (!views) {
        theViews = @{TATViewConstraintsReceiverKeyword: self};
    } else {
        NSMutableDictionary *mutableViews = [views mutableCopy];
        mutableViews[TATViewConstraintsReceiverKeyword] = self;
        theViews = mutableViews;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:theFormat metrics:metrics views:theViews];
    [constraint tat_install];
    return constraint;
}

- (NSLayoutConstraint *)tat_constrainLayoutAttributeUsingEquationFormat:(NSString *)format
{
    return [self tat_constrainLayoutAttributeUsingEquationFormat:format metrics:nil views:nil];
}

- (NSArray *)tat_constrainLayoutAttributesUsingEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSMutableArray *mutableConstraints = [NSMutableArray new];
    for (id format in formats) {
        NSParameterAssert([format isKindOfClass:[NSString class]]);
        [mutableConstraints addObject:[self tat_constrainLayoutAttributeUsingEquationFormat:format metrics:metrics views:views]];
    }
    return [mutableConstraints copy];
}

- (NSArray *)tat_constrainLayoutAttributesUsingEquationFormats:(NSArray *)formats
{
    return [self tat_constrainLayoutAttributesUsingEquationFormats:formats metrics:nil views:nil];
}

@end
