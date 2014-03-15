//
//  UIView+TATViewConstraints.h
//  TATLayout
//

@import UIKit;

/**
 This category in `UIView` provides support for constraining the receiver's layout attributes specifying the constraints with the equation format.
 */
@interface UIView (TATViewConstraints)

///-------------------------------------
/// @name Constraining Layout Attributes
///-------------------------------------

/**
 Constrain a layout attribute by creating a constraint specified with the equation format and installing it in the closest ancestor shared by the receiver and any view related.
 
 The first item is set to be the receiver so the equation must start from the first attribute. For example `width == superview.width` translates to `receiver.width == superview.width`.
 
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return The constraint created.
 @see NSLayoutConstraint(TATConstraintFactory) for a description of the language used in the equation format string.
 */
- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Convenience method to send tat_constrainLayoutAttributeWithEquationFormat:metrics:views: to the receiver with `nil` `metrics` and `views`.
 @param format The format specification for the constraint.
 @return The constraint created.
 @warning If there is any metric or view specified in the equation string an error will be thrown.
 */
- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format;

/**
 Convenience method to send tat_constrainLayoutAttributeWithEquationFormat:metrics:views: to the receiver with `nil` `views`.
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @return The constraint created.
 @warning If there is any view specified in the equation string an error will be thrown.
 */
- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics;

/**
 Convenience method to send tat_constrainLayoutAttributeWithEquationFormat:metrics:views: to the receiver with `nil` `metrics`.
 @param format The format specification for the constraint.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return The constraint created.
 @warning If there is any view specified in the equation string an error will be thrown.
 */
- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format views:(NSDictionary *)views;


/**
 Constrain layout attributes by applying the given equation formats.
 @param formats An array of format strings specifying for the constraints to be created. The first item is implicitly the receiver so the equation starts from the first attribute.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return An array of constraint objects relating the receiver and optionally other views with the specified relation, attributes, multiplier, constant and priority.
 @see NSLayoutConstraint(TATConstraintFactory) for a description of the language used for the equation format string.
 */
- (NSArray *)tat_constrainLayoutAttributesWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

//- (NSArray *)tat_constrainLayoutAttributesWithEquationFormats:(NSArray *)formats;
//- (NSArray *)tat_constrainLayoutAttributesWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics;
//- (NSArray *)tat_constrainLayoutAttributesWithEquationFormats:(NSArray *)formats views:(NSDictionary *)views;

@end
