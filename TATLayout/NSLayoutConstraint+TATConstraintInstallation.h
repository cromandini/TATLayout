//
//  NSLayoutConstraint+TATConstraintInstallation.h
//  TATLayout
//

@import UIKit;

/**
 This category in `NSLayoutConstraint` adds support for installation (ie: adding itself to the view which is the closest ancestor shared by the views participating in the constraint) as well as uninstallation.
*/
@interface NSLayoutConstraint (TATConstraintInstallation)

///-----------------------------
/// @name Installing Constraints
///-----------------------------

/**
 Adds the constraint to the closest ancestor shared by the views participating, being it the first item if there's only one view.
 @warning If the constraint has two views participating, both of them must be part of the view hierarchy before installation. This is because the view hierarchy is inspected in order to find the closest ancestor shared by the views participating in the constraint.
 */
- (void)tat_install;

///-------------------------------
/// @name Uninstalling Constraints
///-------------------------------

/**
 Removes the constraint.
 */
- (void)tat_uninstall;

@end
