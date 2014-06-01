//
//  NSLayoutConstraint+TATInstallation.h
//  TATLayout
//

@import UIKit;

/**
 This category in `NSLayoutConstraint` adds support for installation and uninstallation (ie: adding/removing the constraint to/from the closest ancestor shared by the views participating). Notice that in order to find the closest ancestor the view hierarchy must be inspected, because of that, referenced views must be part of the view hierarchy before attempting to install constraints. Also notice that a view is ancestor of itself, then the closest ancestor in a constraint with only one view participating is the only view.
*/
@interface NSLayoutConstraint (TATInstallation)

///-----------------------------
/// @name Installing Constraints
///-----------------------------

/**
 Adds the constraint into the closest ancestor shared by the views participating.
 @throws An Exception if the closest ancestor cannot be found.
 */
- (void)tat_install;

/**
 Installs the given constraints.
 @param constraints The constraints to be installed.
 */
+ (void)tat_installConstraints:(NSArray *)constraints;

///----------------------------------------------------------------
/// @name Creating and Installing Constraints in the Same Operation
///----------------------------------------------------------------

/**
 Creates and installs a constraint described by the equation format.
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return The newly created and installed constraint.
 */
+ (NSLayoutConstraint *)tat_installConstraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Creates and installs constraints described by the equation format.
 @param formats The format specifications for the constraints.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return The newly created and installed constraints.
 */
+ (NSArray *)tat_installConstraintsWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Creates and installs constraints described by the visual format.
 @param format The format specification for the constraints.
 @param options Options describing the attribute and the direction of layout for all objects in the visual format string.
 @param metrics A dictionary of constants that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects.
 @return The newly created and installed constraints.
 */
+ (NSArray *)tat_installConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

///-------------------------------
/// @name Uninstalling Constraints
///-------------------------------

/**
 Removes the constraint from the closest ancestor shared by the views participating.
 @discussion Uninstalling a constraint not held by the closest ancestor has no effect.
 */
- (void)tat_uninstall;

/**
 Uninstalls the given constraints.
 @param constraints The constraints to be uninstalled.
 */
+ (void)tat_uninstallConstraints:(NSArray *)constraints;

@end
