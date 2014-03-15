//
//  UIView+TATViewHierarchy.m
//  TATLayout
//

#import "UIView+TATViewHierarchy.h"

@implementation UIView (TATViewHierarchy)

#pragma mark - Inspecting the View Hierarchy

- (BOOL)tat_isAncestorOfView:(UIView *)view
{
    if (!view) {
        return NO;
    }
    if (view == self) {
        return YES;
    }
    __block BOOL isAncestor = NO;
    [view tat_enumerateSuperviewsUsingBlock:^(UIView *superview, BOOL *stop) {
        if (superview == self) {
            isAncestor = YES;
            *stop = YES;
        }
    }];
    return isAncestor;
}

- (UIView *)tat_closestAncestorSharedWithView:(UIView *)view
{
    if (!view) {
        return nil;
    }
    if ([self tat_isAncestorOfView:view]) {
        return self;
    }
    __block UIView *ancestor = nil;
    [self tat_enumerateSuperviewsUsingBlock:^(UIView *superview, BOOL *stop) {
        if ([superview tat_isAncestorOfView:view]) {
            ancestor = superview;
            *stop = YES;
        }
    }];
    return ancestor;
}

/**
 Enumerates the receiver's superviews using the given block, starting with `self.superview` and continuing upwards in the hierarchy.
 @param block The block to apply to superviews. The block takes two arguments, `superview`: The superview enumerated. `stop`: A reference to a Boolean value that the block can set to YES to stop further enumeration.
 */
- (void)tat_enumerateSuperviewsUsingBlock:(void (^)(UIView *superview, BOOL *stop))block
{
    BOOL stop = NO;
    UIView *superview = self.superview;
    while (superview) {
        block(superview, &stop);
        if (stop) {
            return;
        }
        superview = superview.superview;
    }
}

/**
 Enumerates the receiver's related constraints (ie:constraits with the receiver as the first item) using the given block, starting with `self.constraints` and continuing with `superview.constraints` and upwards in the hierarchy.
 @param block The block to apply to related constraints. The block takes one argument, `constraint`: The related constraint enumerated.
 */
- (void)tat_enumerateRelatedConstraintsUsingBlock:(void (^)(NSLayoutConstraint *constraint))block // TODO: is this needed?
{
    void (^enumerateConstraints)(NSArray *constraints) = ^(NSArray *constraints) {
        for (NSLayoutConstraint *constraint in constraints) {
            if (constraint.firstItem == self) {
                block(constraint);
            }
        }
    };
    enumerateConstraints(self.constraints);
    [self tat_enumerateSuperviewsUsingBlock:^(UIView *superview, BOOL *stop) {
        enumerateConstraints(superview.constraints);
    }];
}

@end
