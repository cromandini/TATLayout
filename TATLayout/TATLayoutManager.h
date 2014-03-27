//
//  TATLayoutManager.h
//  TATLayout
//

@import Foundation;
@import UIKit;

/**
 Creates an array with a visual format string and an `NSNumber` containing an `NSLayoutFormatOptions`.
 @param visualFormat The visual format string. Keep in mind that any string is valid, since the format is not validated.
 @param formatOptions The options for the visual format string.
 @return An array with the visual format string as the first element and an `NSNumber` containing the given options as the second.
 @discussion This function is particularly useful when adding constraints with mixed formats in the layout manager.
 @warning Throws an exception if _visualFormat_ is `nil`.
 */
extern NSArray *TATLayoutManagerArrayWithVisualFormatAndOptions(NSString *visualFormat, NSLayoutFormatOptions formatOptions);

/**
 `TATLayoutManager` manages parts of a layout by providing creation, installation, uninstallation and retrieval of Layout Constraints.
 */
@interface TATLayoutManager : NSObject

///--------------------------------
/// @name Creating a Layout Manager
///--------------------------------

/**
 Creates and returns a layout manager.
 @return An initialized layout manager.
 */
+ (instancetype)layoutManager;

///-----------------------------------------------------
/// @name Activating and Deactivating the Layout Manager
///-----------------------------------------------------

/**
 Indicates whether the layout manager is active. Defaults to `YES`. (read-only)
 @return A boolean value that indicates whether the layout manager is active.
 @discussion When the layout manager is active, the constraints held by the layout manager are installed and any constraint that is created using the `constrainUsing...` methods will be installed automatically (ie: added to the view which is the closest ancestor shared by the views participating in every constraint). Otherwise, when the layout manager is not active, the constraints held by the layout manager are not installed and none of the constraints created will be installed automatically.
 */
@property (nonatomic, readonly, getter=isActive) BOOL active;

/**
 Activates the layout by installing all the constraints held by the layout manager and entering the active state (ie: the constraints added from now on will be installed automatically).
 @see active.
 */
- (void)activate;

/**
 Deactivates the layout by uninstalling all the constraints held by the layout manager and exiting the active state (ie: the constraints added from now on will not be installed automatically).
 @see active.
 */
- (void)deactivate;

///-------------------------------------
/// @name Constraining Layout Attributes
///-------------------------------------

/**
 Creates a constraint described by the equation format and installs it into the closest ancestor shared by the views participating in the constraint.
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @return The constraint created.
 */
+ (NSLayoutConstraint *)constrainUsingEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Creates constraints described by the visual format and installs them into the closest ancestor shared by the views participating in every constraint.
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects.
 @return The constraints created.
 */
+ (NSArray *)constrainUsingVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Creates a constraint described by the equation format and installs it if the layout manager is active.
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @discussion When the layout manager is active, the constraint is also installed (ie: added to the view which is the closest ancestor shared by the views participating in the constraint). See NSLayoutConstraint(TATConstraintFactory) for a description of the language used in the equation format string.
 */
- (void)constrainUsingEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Creates a constraint described by the equation format, associated with a given name, and installs it if the layout manager is active.
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @param name The name to associate with the constraint.
 @discussion When the layout manager is active, the constraint is also installed (ie: added to the view which is the closest ancestor shared by the views participating in the constraint). See NSLayoutConstraint(TATConstraintFactory) for a description of the language used in the equation format string.
 */
- (void)constrainUsingEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views named:(NSString *)name;

///-------------------------
/// @name Adding Constraints
///-------------------------

/**
 Adds a constraint to the layout manager, described by the equation format.
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @discussion When the layout manager is active, the constraint is also installed (ie: added to the view which is the closest ancestor shared by the views participating in the constraint). See NSLayoutConstraint(TATConstraintFactory) for a description of the language used in the equation format string.
 */
- (void)addConstraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Adds a constraint to the layout manager, described by the equation format and associated with a given name.
 @param format The format specification for the constraint.
 @param metrics A dictionary of constants that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the equation format string. The keys must be the string values used in the equation format string, and the values must be the view objects.
 @param name The name to associate with the constraint.
 @discussion When the layout manager is active, the constraint is also installed (ie: added to the view which is the closest ancestor shared by the views participating in the constraint). See NSLayoutConstraint(TATConstraintFactory) for a description of the language used in the equation format string.
 */
- (void)addConstraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views named:(NSString *)name;

/**
 Adds multiple constraints to the layout manager, described by the visual format.
 @param format The format specification for the constraints.
 @param options Options describing the attribute and the direction of layout for all objects in the visual format string.
 @param metrics A dictionary of constants that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects.
 @discussion When the layout manager is active, the constraints are also installed (ie: added to the view which is the closest ancestor shared by the views participating in every constraint). See "Visual Format Language" in Apple's Auto Layout Guide for a description of the language used in the visual format string.
 */
- (void)addConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Adds multiple constraints to the layout manager, described by the visual format and associated with a given name.
 @param format The format specification for the constraints.
 @param options Options describing the attribute and the direction of layout for all objects in the visual format string.
 @param metrics A dictionary of constants that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects.
 @param name The name to associate with the constraints.
 @discussion When the layout manager is active, the constraints are also installed (ie: added to the view which is the closest ancestor shared by the views participating in every constraint). See "Visual Format Language" in Apple's Auto Layout Guide for a description of the language used in the visual format string.
 */
- (void)addConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views named:(NSString *)name;

/**
 Adds multiple constraints to the layout manager, described by mixed format strings (including equation and visual formats).
 @param formats An array of mixed objects that can be equation format strings or an array with a visual format string as the first element and an `NSNumber` containing an `NSLayoutFormatOptions` value as the second. You can create the mentioned array by using the helper function `TATLayoutManagerArrayWithVisualFormatAndOptions()`, but why bother using that verbose name when you can create the array literally, example:
 
    NSArray *formats = @[@"view1.width == superview.width * 0.5",
                         @[@"H:|[view1][view2(==view1)]|", @(NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom)]
                         @[@"V:|[view2]|", @0]];
    [layoutManager addConstraintsWithMixedFormats:formats metrics:nil views:NSDictionaryOfVariableBindings(view1, view2)];
 
 @param metrics A dictionary of constants that appear in the format strings. The keys must be the string values used in the format strings, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the format strings. The keys must be the string values used in the format strings, and the values must be the view objects.
 @discussion When the layout manager is active, the constraints are also installed (ie: added to the view which is the closest ancestor shared by the views participating in every constraint). See "Visual Format Language" in Apple's Auto Layout Guide for a description of the language used in the visual format string and NSLayoutConstraint(TATConstraintFactory) for a description of the language used in the equation format string.
 */
- (void)addConstraintsWithMixedFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 Adds multiple constraints to the layout manager, described by mixed format strings (including equation and visual formats) and associated with a given name.
 @param formats An array of mixed objects that can be equation format strings or an array with a visual format string as the first element and an `NSNumber` containing an `NSLayoutFormatOptions` value as the second. See addConstraintsWithMixedFormats:metrics:views: for an example.
 @param metrics A dictionary of constants that appear in the format strings. The keys must be the string values used in the format strings, and the values must be `NSNumber` objects.
 @param views A dictionary of views that appear in the format strings. The keys must be the string values used in the format strings, and the values must be the view objects.
 @param name The name to associate with the constraints.
 @discussion When the layout manager is active, the constraints are also installed (ie: added to the view which is the closest ancestor shared by the views participating in every constraint). See "Visual Format Language" in Apple's Auto Layout Guide for a description of the language used in the visual format string and NSLayoutConstraint(TATConstraintFactory) for a description of the language used in the equation format string.
 */
- (void)addConstraintsWithMixedFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views named:(NSString *)name;

///---------------------------
/// @name Removing Constraints
///---------------------------

/**
 Removes all the constraints held by the layout manager.
 @return An array containing the constraints removed. It can be empty if no constraint were removed.
 @discussion When the layout manager is active, the constraints are also uninstalled (ie: removed from the view that holds every constraint).
 */
- (NSArray *)removeAllConstraints;

/**
 Removes the specified constraints from the layout manager.
 @param constraints The constraints to remove.
 @return An array containing the constraints removed. It can be empty if no constraint were removed.
 @return The constraints removed.
 @discussion When the layout manager is active, the constraints are also uninstalled (ie: removed from the view that holds every constraint).
 */
- (NSArray *)removeConstraints:(NSArray *)constraints;

/**
 Removes the constraints associated with a given name from the layout manager.
 @param name The name associated with the constraints to be removed.
 @return An array containing the constraints removed. It can be empty if no constraint were removed.
 @discussion When the layout manager is active, the constraints are also uninstalled (ie: removed from the view that holds every constraint).
 */
- (NSArray *)removeConstraintsNamed:(NSString *)name;

///-----------------------------
/// @name Retrieving Constraints
///-----------------------------

/**
 The constraints held by the layout manager.
 @return An array containing the constraints held by the layout manager. If the layout manager is empty, returns an empty array. The constraints are returned in the same order they were created.
 */
@property (strong, nonatomic, readonly) NSArray *constraints; // of NSLayoutConstraint

/**
 The first constraint associated with a given name.
 @param name The name to test for association with the constraint.
 @return The first constraint associated with the given name, if any. Otherwise returns `nil`. If there are more than one constraint associated with the same name you may want to use constraintsNamed: instead.
 */
- (NSLayoutConstraint *)constraintNamed:(NSString *)name;

/**
 The constraints associated with a given name.
 @param name The name to test for association with the constraints.
 @return An array containing the constraints associated with the given name, if any. Otherwise returns an empty array.
 */
- (NSArray *)constraintsNamed:(NSString *)name;

@end
