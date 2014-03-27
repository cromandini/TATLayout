//
//  TATLayoutHelper.h
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

///-------------------------------------------------------------------------
/// @name Settings views to not translate autoresizing mask into constraints
///-------------------------------------------------------------------------

/**
 Sets `translatesAutoresizingMaskIntoConstraints = NO` in all the views of a given nil-terminated list.
 @param firstView, ... A comma-separated list of views ending with `nil`.
 */
extern void TATLayoutSetViewsToNotTranslateAutoresizingMaskIntoConstraints(id firstView, ...) NS_REQUIRES_NIL_TERMINATION;

/**
 This macro is a helper that can be used to call `TATLayoutSetViewsToNotTranslateAutoresizingMaskIntoConstraints()` without terminating the list of views with `nil`.
 */
#define TATLayoutUnableAutoresizingMaskInViews(...) TATLayoutSetViewsToNotTranslateAutoresizingMaskIntoConstraints(__VA_ARGS__, nil)
