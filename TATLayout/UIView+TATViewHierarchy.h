//
//  UIView+TATViewHierarchy.h
//  TATLayout
//

@import UIKit;

/**
 This category in `UIView` provides support for inspecting the view hierarchy to see if a view is ancestor of another and to calculate the closest ancestor shared by 2 views.
 */
@interface UIView (TATViewHierarchy)

///------------------------------------
/// @name Inspecting the View Hierarchy
///------------------------------------

/**
 Returns a Boolean value that indicates whether the receiver is ancestor of a given view (being a view ancestor of itself).
 @param view The view to test if it is within scope of the receiver.
 @return `YES` if `view` is within scope of the receiver, otherwise `NO`. If `view` is identical to the receiver, returns `YES`.
 */
- (BOOL)tat_isAncestorOfView:(UIView *)view; // TODO: Should this method be private?

/**
 Returns the closest ancestor shared by the receiver and a given view.
 @param view The view to test (along with the receiver) for closest shared ancestor.
 @return The closest shared ancestor or `nil` if there’s no such object. Returns `self` if `view` is identical to the receiver.
 */
- (UIView *)tat_closestAncestorSharedWithView:(UIView *)view;

@end
