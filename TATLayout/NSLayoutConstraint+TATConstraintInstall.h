//
//  NSLayoutConstraint+TATConstraintInstall.h
//  TATLayout
//

@import UIKit;

/**
 This category in `NSLayoutConstraint` provides support for auto installation and un-installation.
*/
@interface NSLayoutConstraint (TATConstraintInstall)

///-----------------------------
/// @name Installing Constraints
///-----------------------------

/**
 Add the constraint to the closest ancestor shared by the views the constraint involves, being it the first item if there's only one view participating.
 
 @warning If the constraint has two views participating, both of them must be part of the view hierarchy before installation. This is because the view hierarchy is inspected in order to find the closest ancestor shared by the views the constraint involves.
 */
- (void)tat_install;

///-------------------------------
/// @name Uninstalling Constraints
///-------------------------------

/**
 Remove the constraint.
 */
- (void)tat_uninstall;

@end
