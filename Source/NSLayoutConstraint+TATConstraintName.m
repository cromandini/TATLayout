//
//  NSLayoutConstraint+TATConstraintName.m
//  TATLayout
//

@import ObjectiveC;
#import "NSLayoutConstraint+TATConstraintName.h"

@implementation NSLayoutConstraint (TATConstraintName)

#pragma mark - Naming Constraints

- (NSString *)tat_name
{
    return objc_getAssociatedObject(self, @selector(tat_name));
}

- (void)setTat_name:(NSString *)tat_name
{
    objc_setAssociatedObject(self, @selector(tat_name), tat_name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
