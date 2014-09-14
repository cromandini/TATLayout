//
//  NSLayoutConstraint+TATInstallation.h
//  TATLayout
//

@import UIKit;

/**
 This category in `NSLayoutConstraint` adds support for installation and uninstallation (ie: adding/removing the constraint to/from the closest ancestor shared by the views participating). It also provides a few convenience methods to create and install constraints in the same opertaion, making the process a bit faster in some cases.
 
 Notice that in order to find the closest ancestor the view hierarchy must be inspected. Because of that, referenced views must be part of the view hierarchy before attempting to install constraints. Also notice that a view is considered ancestor of itself, so the closest ancestor in a constraint with only one view participating is the only view.
 
 @warning All the methods in this category are deprecated. The same functionality is available in NSLayoutConstraint+TATActivation.h, which uses iOS 8 activation methods when available. This whole file will be removed in a future release.
*/
@interface NSLayoutConstraint (TATInstallation)

///----------------------------------------------
/// @name Installing and Uninstalling Constraints
///----------------------------------------------

/**
 Adds the constraint into the closest ancestor shared by the views participating.
 @throws An Exception if the closest ancestor cannot be found.
 @warning This method is deprecated, use tat_active=YES instead. This whole file will be removed in a future release.
 */
- (void)tat_install DEPRECATED_ATTRIBUTE;

/**
 Installs the given constraints.
 @param constraints The constraints to be installed.
 @warning This method is deprecated, use tat_activateConstraints: instead. This whole file will be removed in a future release.
 */
+ (void)tat_installConstraints:(NSArray *)constraints DEPRECATED_ATTRIBUTE;

/**
 Removes the constraint from the closest ancestor shared by the views participating.
 @discussion Uninstalling a constraint not held by the closest ancestor has no effect.
 @warning This method is deprecated, use tat_active=NO instead. This whole file will be removed in a future release.
 */
- (void)tat_uninstall DEPRECATED_ATTRIBUTE;

/**
 Uninstalls the given constraints.
 @param constraints The constraints to be uninstalled.
 @warning This method is deprecated, use tat_deactivateConstraints: instead. This whole file will be removed in a future release.
 */
+ (void)tat_uninstallConstraints:(NSArray *)constraints DEPRECATED_ATTRIBUTE;

///----------------------------------------------------------------
/// @name Creating and Installing Constraints in the Same Operation
///----------------------------------------------------------------

/**
 Creates and installs a constraint described by the equation format.
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return The newly created and installed constraint.
 @warning This method is deprecated, use tat_activateConstraintWithEquationFormat:metrics:views: instead. This whole file will be removed in a future release.
 */
+ (NSLayoutConstraint *)tat_installConstraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views DEPRECATED_ATTRIBUTE;

/**
 Creates and installs constraints described by the equation format.
 @param formats The format specifications for the constraints.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return The newly created and installed constraints.
 @warning This method is deprecated, use tat_activateConstraintsWithEquationFormats:metrics:views: instead. This whole file will be removed in a future release.
 */
+ (NSArray *)tat_installConstraintsWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views DEPRECATED_ATTRIBUTE;

/**
 Creates and installs constraints described by the visual format.
 @param format The format specification for the constraints.
 @param options Options describing the attribute and the direction of layout for all objects in the visual format string.
 @param metrics A dictionary of constants that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects.
 @return The newly created and installed constraints.
 @warning This method is deprecated, use tat_activateConstraintsWithVisualFormat:options:views: instead. This whole file will be removed in a future release.
 */
+ (NSArray *)tat_installConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views DEPRECATED_ATTRIBUTE;

@end
