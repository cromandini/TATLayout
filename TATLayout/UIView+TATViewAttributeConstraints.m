//
//  UIView+TATViewAttributeConstraints.m
//  TATLayout
//

#import "UIView+TATViewAttributeConstraints.h"
#import "NSLayoutConstraint+TATConstraintFactory.h"
#import "NSLayoutConstraint+TATConstraintInstallation.h"

static NSString * TATViewAttributeConstraintsReceiverKeyword = @"self";

@implementation UIView (TATViewAttributeConstraints)

#pragma mark - Constraining Layout Attributes

- (NSLayoutConstraint *)tat_constrainLayoutAttributeUsingEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSString *theFormat = [NSString stringWithFormat:@"%@.%@", TATViewAttributeConstraintsReceiverKeyword, format];
    NSDictionary *theViews;
    if (!views) {
        theViews = @{TATViewAttributeConstraintsReceiverKeyword: self};
    } else {
        NSMutableDictionary *mutableViews = [views mutableCopy];
        mutableViews[TATViewAttributeConstraintsReceiverKeyword] = self;
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
