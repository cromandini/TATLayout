//
//  NSLayoutConstraint+TATActivation.h
//  TATLayout
//

@import UIKit;

/**
 This category in `NSLayoutConstraint` adds support for activation and deactivation, relying on iOS 8 native methods when available. It also provides a few convenience methods to create and activate constraints in the same operation, making the process more efficient in some cases. Notice that in order to find the container the view hierarchy must be inspected. Because of that, referenced views must be part of the view hierarchy before attempting to activate constraints.
 */
@interface NSLayoutConstraint (TATActivation)

///----------------------------------------------
/// @name Activating and Deactivating Constraints
///----------------------------------------------

/**
 The receiver may be activated or deactivated by manipulating this property. Only active constraints affect the calculated layout. Attempting to activate a constraint whose items have no common ancestor will cause an exception to be thrown. Defaults to NO for newly created constraints.
 @discussion Uses active/isActive property when available.
 */
@property (nonatomic, getter=tat_isActive) BOOL tat_active;

/**
 Convenience method that activates each constraint in the contained array, in the same manner as setting active=YES. This is often more efficient than activating each constraint individually.
 @param constraints The constraints to be activated.
 @discussion Uses activateConstraints: method when available.
 */
+ (void)tat_activateConstraints:(NSArray *)constraints;

/**
 Convenience method that deactivates each constraint in the contained array, in the same manner as setting active=NO. This is often more efficient than deactivating each constraint individually.
 @param constraints The constraints to be deactivated.
 @discussion Uses deactivateConstraints: method when available.
 */
+ (void)tat_deactivateConstraints:(NSArray *)constraints;

///----------------------------------------------------------------
/// @name Creating and Activating Constraints in the Same Operation
///----------------------------------------------------------------

/**
 Convenience method that creates a constraint described by the equation format, and makes it active in the same operation.
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return The newly created and active constraint.
 */
+ (NSLayoutConstraint *)tat_activateConstraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Convenience method that creates constraints described by the equation format, and activates them in the same operation.
 @param formats The format specifications for the constraints.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return The newly created and active constraints.
 */
+ (NSArray *)tat_activateConstraintsWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Convenience method that creates constraints described by the visual format, and activates them in the same operation.
 @param format The format specification for the constraints.
 @param options Options describing the attribute and the direction of layout for all objects in the visual format string.
 @param metrics A dictionary of constants that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects.
 @return The newly created and active constraints.
 */
+ (NSArray *)tat_activateConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

@end
