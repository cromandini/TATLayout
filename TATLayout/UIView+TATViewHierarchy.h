//
//  UIView+TATViewHierarchy.h
//  TATLayout
//

@import UIKit;

/**
 This category in `UIView` provides support for inspecting the view hierarchy.
 */
@interface UIView (TATViewHierarchy)

///------------------------------------
/// @name Inspecting the View Hierarchy
///------------------------------------

/**
 Indicates whether the receiver is ancestor of a given view (being a view ancestor of itself).
 @param view The view to test if is within scope of the receiver.
 @return `YES` if `view` is within scope of the receiver, otherwise `NO`. If `view` is identical to the receiver, returns `YES`.
 */
- (BOOL)tat_isAncestorOfView:(UIView *)view;

/**
 The closest ancestor shared by the receiver and a given view.
 @param view The view to test (along with the receiver) for closest shared ancestor.
 @return The closest shared ancestor or `nil` if there’s no such object. Returns `self` if `view` is identical to the receiver.
 */
- (UIView *)tat_closestAncestorSharedWithView:(UIView *)view;

@end
