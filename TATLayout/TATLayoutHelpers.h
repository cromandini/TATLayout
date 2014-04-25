//
//  TATLayoutHelpers.h
//  TATLayout
//
// These are a few helper functions and macros that are useful when working with layouts.

@import Foundation;
@import UIKit;

#define TATDeviceIsIPAD     [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad
#define TATDeviceIsIPHONE   [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone

/**
 Sets `translatesAutoresizingMaskIntoConstraints = NO` in the views of a given nil-terminated list.
 @param firstView, ... A comma-separated list of views ending with `nil`.
 */
extern void TATDisableAutoresizingConstraintsInNilTerminatedViews(id firstView, ...) NS_REQUIRES_NIL_TERMINATION;

// This is a helper to call `TATDisableAutoresizingConstraintsInNilTerminatedViews()` without terminating the list of views with `nil`.
#define TATDisableAutoresizingConstraintsInViews(...) TATDisableAutoresizingConstraintsInNilTerminatedViews(__VA_ARGS__, nil)