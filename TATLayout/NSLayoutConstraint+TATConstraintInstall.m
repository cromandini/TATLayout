//
//  NSLayoutConstraint+TATConstraintInstall.m
//  TATLayout
//

#import "NSLayoutConstraint+TATConstraintInstall.h"
#import "UIView+TATViewHierarchy.h"

static NSString * const TATConstraintInstallErrorClosestAncestorSharedByItemsNotFound = @"Unable to install constraint: %@\nCannot find the closest ancestor shared by the views participating. Please ensure the following views are part of the view hierarchy before attempting to install the constraint:\n%@\n%@";

@implementation NSLayoutConstraint (TATConstraintInstall)

#pragma mark - Installing Constraints

- (void)tat_install
{
    UIView *closestAncestorSharedByItems = [self tat_closestAncestorSharedByItems];
    if (!closestAncestorSharedByItems) {
        NSString *reason = [NSString stringWithFormat:TATConstraintInstallErrorClosestAncestorSharedByItemsNotFound,
                            self, self.firstItem, self.secondItem];
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
    }
    [closestAncestorSharedByItems addConstraint:self];
}

#pragma mark - Uninstalling Constraints

- (void)tat_uninstall
{
    
}

#pragma mark - Private

/**
 The receiver's first view.
 
 @return The first object participating in the constraint casted to `UIView`.
 */
- (UIView *)tat_firstView
{
    return self.firstItem;
}

/**
 The receiver's second view.
 
 @return The second object participating in the constraint casted to `UIView` or `nil` if there’s no such object.
 */
- (UIView *)tat_secondView
{
    return self.secondItem;
}

/**
 The closest ancestor shared by the views the constraint involves.
 
 @return The closest shared ancestor or `nil` if there’s no such object. Returns the first view if there's only one view participating.
 */
- (UIView *)tat_closestAncestorSharedByItems
{
    return !self.secondItem ? self.tat_firstView : [self.tat_firstView tat_closestAncestorSharedWithView:self.tat_secondView];
}

@end
