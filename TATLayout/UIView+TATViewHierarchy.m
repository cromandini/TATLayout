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

#pragma mark - Private

/**
 Enumerates the receiver's superviews using the given block, starting with `self.superview` and continuing upwards in the hierarchy.
 @param block The block to apply to superviews. The block takes two arguments, `superview`: The superview enumerated. `stop`: A reference to a boolean value that the block can set to YES to stop further enumeration.
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

@end
