//
//  NSLayoutConstraint+TATInstallation.h
//  TATLayout
//

@import UIKit;

/**
 This category in `NSLayoutConstraint` adds support for installation and uninstallation (ie: adding/removing the constraint to/from the closest ancestor shared by the views participating). Notice that in order to find the closest shared ancestor the view hierarchy must be inspected, because of that, referenced views must be part of the view hierarchy before attempting to install constraints. Also notice that a view is ancestor of itself, then the closest shared ancestor in a constraint with only one view participating is the only view.
*/
@interface NSLayoutConstraint (TATInstallation)

///-----------------------------
/// @name Installing Constraints
///-----------------------------

/**
 Adds the constraint into the closest ancestor shared by the views participating.
 @throws An Exception if the container cannot be found.
 */
- (void)tat_install;

/**
 Installs the given constraints.
 @param constraints The constraints to be installed.
 */
+ (void)tat_installConstraints:(NSArray *)constraints;

/**
 Installs a constraint described by the equation format.
 @param format
 @param metrics
 @param views
 @return The constraint installed.
 */
+ (NSLayoutConstraint *)tat_installConstraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Installs constraints described by the equation format.
 @param formats
 @param metrics
 @param views
 @return The constraints installed.
 */
+ (NSArray *)tat_installConstraintsWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Installs constraints described by the visual format.
 @param format
 @param options
 @param metrics
 @param views
 @return The constraints installed.
 */
+ (NSArray *)tat_installConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

///-------------------------------
/// @name Uninstalling Constraints
///-------------------------------

/**
 Removes the constraint from the closest ancestor shared by the views participating.
 @discussion If the constraint is not held by the closest shared ancestor this method has no effect.
 */
- (void)tat_uninstall;

/**
 Uninstalls the given constraints.
 @param constraints The constraints to be uninstalled.
 */
+ (void)tat_uninstallConstraints:(NSArray *)constraints;

@end
