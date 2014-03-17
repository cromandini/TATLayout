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
 Constrain a layout attribute by creating a constraint described with the equation format and installing it into the closest ancestor shared by the receiver and any view related.
 
 The first item is automatically set to be the receiver so the equation must start from the first attribute, example `width == superview.width` translates to `self.width == superview.width`. Also, if you need to set the second item to be the receiver you can do so by using the keyword `self`, example `width == self.height`.
 
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return The constraint created.
 @see NSLayoutConstraint(TATConstraintFactory) for a description of the language used in the equation format string.
 */
- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Convenience method to send tat_constrainLayoutAttributeWithEquationFormat:metrics:views: to the receiver with `nil` metrics and views.
 
 @param format The format specification for the constraint.
 @return The constraint created.
 @warning If there is any metric or view specified in the equation string an error will be thrown.
 */
- (NSLayoutConstraint *)tat_constrainLayoutAttributeWithEquationFormat:(NSString *)format;

/**
 Constrain multiple layout attributes by creating constraints described with the equation format and installing them into the closest ancestor shared by the receiver and any view related.
 
 @param formats The format specifications for the constraints.
 @param metrics A dictionary of constants that appear in the equation format strings. The keys must be the string values used in the equation format strings, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format strings. The keys must be the string values used in the equation format strings, and the values must be the view objects.
 @return The constraints created.
 @see NSLayoutConstraint(TATConstraintFactory) for a description of the language used in the equation format string.
 */
- (NSArray *)tat_constrainLayoutAttributesWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Convenience method to send tat_constrainLayoutAttributesWithEquationFormats:metrics:views: to the receiver with `nil` metrics and views.
 
 @param formats The format specifications for the constraints.
 @return The constraints created.
 @warning If there is any metric or view specified in the equation string an error will be thrown.
 */
- (NSArray *)tat_constrainLayoutAttributesWithEquationFormats:(NSArray *)formats;

@end
