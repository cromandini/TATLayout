//
//  NSLayoutConstraint+TATConstraintFactory.h
//  TATLayout
//

@import UIKit;

/**
 This category in `NSLayoutConstraint` provides support for creating constraints with a linear equation format string. The format string describes a linear equation with the addition of the priority and can be of 2 types, depending on the number of views related:
 
    item1.attribute1 == item2.attribute2 * multiplier + constant @priority
    item1.attribute1 == constant @priority
 
 The equation format string grammar is defined as follows (literals are shown in `code font`).
 
 | Symbol              | Replacement rule                                                                                                   |
 |---------------------|--------------------------------------------------------------------------------------------------------------------|
 | \<twoViewsEquation\>| \<item1.attribute1\>\<relation\>\<item2.attribute2\>(`*`\<multiplier\>)?(\<sign\>\<constant\>)?(`@`\<priority\>)?  |
 | \<oneViewEquation\> | \<item1.attribute1\>\<relation\>\<constant\>(`@`\<priority\>)?                                                     |
 | \<item1\>           | \<viewName\>                                                                                                       |
 | \<attribute1\>      | \<attributeName\>                                                                                                  |
 | \<relation\>        | `<=`|`==`|`>=`                                                                                                     |
 | \<item2\>           | \<viewName\>|`superview`                                                                                           |
 | \<attribute2\>      | \<attributeName\>                                                                                                  |
 | \<multiplier\>      | \<metricName\>|\<number\>                                                                                          |
 | \<sign\>            | `+`|`-`                                                                                                            |
 | \<constant\>        | \<metricName\>|\<number\>                                                                                          |
 | \<priority\>        | \<metricName\>|\<number\>                                                                                          |
 | \<viewName\>        | Parsed as a C identifier. This must be a key mapping to an instance of `UIView` in the passed views dictionary.    |
 | \<attributeName\>   | `left`|`right`|`top`|`bottom`|`leading`|`trailing`|`width`|`height`|`centerX`|`centerY`|`baseline`                 |
 | \<metricName\>      | Parsed as a C identifier. This must be a key mapping to an instance of `NSNumber` in the passed metrics dictionary.|
 | \<number\>          | A valid text representation of a floating-point number. As parsed by `strtod_l`, with the C locale.                |
 
 Examples of equation format strings:
 
    someView.width == otherView.width * 0.5 + 200 @751
    someView.height == someView.width
    someView.leading == otherView.leading * 2
    someView.trailing <= otherView.trailing + 500
    otherView.top >= superview.top
    otherView.top == 500 @251
    otherView.left == 0
 
 `superview` is a magic key which is set to be the superview of the first item. That said, when using `superview` as second item, the first item must be added to its superview before creating the constraint. Examples:
 
    otherView.bottom == superview.bottom - someMetricName
    otherView.right <= superview.right * someMetricName - otherMetricName @yetAnotherMetricName
 
 Whitespace is allowed anywhere in the string, so the following are the same:
 
    someView.width==superview.width*0.5+200@751
    someView.width == superview.width *0.5 +200 @751
    someView.width == superview.width * 0.5 + 200 @ 751
 
 If you make a syntactic mistake, an exception is thrown with a diagnostic message. For example:
 
    notAView is not a key in the views dictionary.
    (whitespace stripped)
    notAView.width==200
            ^
 
    size is not a valid attribute name. Attribute names must be one of left, right, top, bottom,
    leading, trailing, width, height, centerX, centerY or baseline.
    (whitespace stripped)
    someView.size==200
                 ^
 
    Expected a relation. Relation must be one of <=, == or >=.
    (whitespace stripped)
    someView.width>200
                  ^
 
    someConstant is not a key in the metrics dictionary.
    (whitespace stripped)
    someView.width>=otherView.width+someConstant
                                                ^
 */
@interface NSLayoutConstraint (TATConstraintFactory)

///----------------------------------------------------
/// @name Creating Constraints with the Equation Format
///----------------------------------------------------

/**
 Create a constraint explicitly, described by a linear equation format string.
 
 This method is a wrapper for `constraintWithItem:attribute:relatedBy:toItem:attribute:multiplier:constant:` with the addition of the priority.
 @warning When using `superview` as second item, the first view must be added to its superview before creating the constraint.
 
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return A constraint object relating the provided views with the specified relation, attributes, multiplier, constant and priority.
 */
+ (NSLayoutConstraint *)tat_constraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

@end
