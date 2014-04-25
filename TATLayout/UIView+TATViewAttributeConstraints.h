//
//  UIView+TATViewAttributeConstraints.h
//  TATLayout
//

@import UIKit;

/**
 This category in `UIView` adds support for creating and installing constraints (relating the view as the first item) in the same operation. The constraints are described with the equation format string.
 */
@interface UIView (TATViewAttributeConstraints)

///-------------------------------------
/// @name Constraining Layout Attributes
///-------------------------------------

/**
 Creates a constraint, described by the equation format, with the receiver as the first item and installs the constraint into the closest ancestor shared by the receiver and any view related.
 @param format The format specification for the constraint. Since the first item is automatically set to be the receiver, the equation format must start from the first attribute (the receiver's attribute to be constrained), example `width == superview.width` translates to `self.width == superview.width`. Also, if you want the second item to be the receiver you can do so by using the keyword `self`, example `width == self.height`.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return The constraint created.
 @discussion See NSLayoutConstraint(TATConstraintFactory) for a description of the language used in the equation format string.
 */
- (NSLayoutConstraint *)tat_constrainLayoutAttributeUsingEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Convenience method to constrain a layout attribute without metrics and views.
 @param format The format specification for the constraint.
 @return The constraint created.
 @warning If there is any metric or view specified in the equation format string an error will be thrown.
 @see tat_constrainLayoutAttributeUsingEquationFormat:metrics:views:
 */
- (NSLayoutConstraint *)tat_constrainLayoutAttributeUsingEquationFormat:(NSString *)format;

/**
 Creates constraints, described by multiple equation formats, with the receiver as the first item and installs the constraints into the closest ancestor shared by the receiver and any view related.
 @param formats The format specifications for the constraints. See tat_constrainLayoutAttributeUsingEquationFormat:metrics:views: for details.
 @param metrics A dictionary of constants that appear in the equation format strings. The keys must be the string values used in the equation format strings, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format strings. The keys must be the string values used in the equation format strings, and the values must be the view objects.
 @return The constraints created.
 @discussion See NSLayoutConstraint(TATConstraintFactory) for a description of the language used in the equation format string.
 */
- (NSArray *)tat_constrainLayoutAttributesUsingEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Convenience method to constrain multiple layout attributes without metrics and views.
 @param formats The format specifications for the constraints.
 @return The constraints created.
 @warning If there is any metric or view specified in the equation format string an error will be thrown.
 @see tat_constrainLayoutAttributesUsingEquationFormats:metrics:views:
  */
- (NSArray *)tat_constrainLayoutAttributesUsingEquationFormats:(NSArray *)formats;

@end
