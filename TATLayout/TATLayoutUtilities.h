//
//  TATLayoutUtilities.h
//  TATLayout
//
// These are a few helper functions and macros that are useful when working with layouts.

@import Foundation;
@import UIKit;

///--------------------------------
/// @name Checking the Device Idiom
///--------------------------------

/**
 Indicates whether the current device idiom is Pad.
 @return `YES` if the current device idiom is Pad, otherwise returns `NO`.
 */
extern BOOL TATLayoutDeviceIsPad();

/**
 Indicates whether the current device idiom is Phone.
 @return `YES` if the current device idiom is Phone, otherwise returns `NO`.
 */
extern BOOL TATLayoutDeviceIsPhone();

///------------------------------------------------
/// @name Deactivating the view's autoresizing mask
///------------------------------------------------

/**
 Sets `translatesAutoresizingMaskIntoConstraints = NO` in all the views of a given nil-terminated list.
 @param firstView, ... A comma-separated list of views ending with `nil`.
 */
extern void TATLayoutDeactivateAutoresizingMaskInNilTerminatedViews(id firstView, ...) NS_REQUIRES_NIL_TERMINATION;

extern void TATDisableAutoresizingConstraintsInNilTerminatedViews(id firstView, ...) NS_REQUIRES_NIL_TERMINATION;

/**
 This macro is a helper that can be used instead of `TATLayoutDeactivateAutoresizingMaskInNilTerminatedViews()` to avoid terminating the list of views with `nil`.
 */
#define TATLayoutDeactivateAutoresizingMaskInViews(...) TATLayoutDeactivateAutoresizingMaskInNilTerminatedViews(__VA_ARGS__, nil)

#define TATDisableAutoresizingConstraintsInViews(...) TATDisableAutoresizingConstraintsInNilTerminatedViews(__VA_ARGS__, nil)

///-----------------------------------------------------------
/// @name Creating arrays containing visual format and options
///-----------------------------------------------------------

/**
 Creates an array with a visual format string and an `NSNumber` containing an `NSLayoutFormatOptions`.
 @param visualFormat The visual format string. Keep in mind that any string is valid, since the format is not validated.
 @param formatOptions The options for the visual format string.
 @return An array with the visual format string as the first element and an `NSNumber` containing the given options as the second.
 @discussion This function is particularly useful when adding constraints with mixed formats in the layout manager.
 @warning Throws an exception if _visualFormat_ is `nil`.
 */
extern NSArray *TATLayoutArrayWithVisualFormatAndOptions(NSString *visualFormat, NSLayoutFormatOptions formatOptions);
