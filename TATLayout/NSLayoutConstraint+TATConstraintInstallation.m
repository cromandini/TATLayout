//
//  NSLayoutConstraint+TATConstraintInstallation.m
//  TATLayout
//

#import "NSLayoutConstraint+TATConstraintInstallation.h"
#import "UIView+TATViewHierarchy.h"

static NSString * const TATConstraintInstallationErrorClosestAncestorSharedByItemsNotFound = @"Unable to install constraint: %@\nCannot find the closest ancestor shared by the views participating. Please ensure the following views are part of the same view hierarchy before attempting to install the constraint:\n%@\n%@";

@implementation NSLayoutConstraint (TATConstraintInstallation)

#pragma mark - Installing Constraints

- (void)tat_install
{
    UIView *closestAncestorSharedByItems = [self tat_closestAncestorSharedByItems];
    if (!closestAncestorSharedByItems) {
        NSString *reason = [NSString stringWithFormat:TATConstraintInstallationErrorClosestAncestorSharedByItemsNotFound,
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
    if (!self.secondItem) {
        return [self tat_firstView];
    }
    return [self.tat_firstView tat_closestAncestorSharedWithView:self.tat_secondView];
}

@end