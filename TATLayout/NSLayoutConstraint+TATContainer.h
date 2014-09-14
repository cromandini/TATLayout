//
//  NSLayoutConstraint+TATContainer.h
//  TATLayout
//

#import <UIKit/UIKit.h>

/**
 This category in `NSLayoutConstraint` adds support for calculating the closest ancestor shared by the views participating as well as for weakly associating the container of the constraint. The association is used to cache the container in order to avoid inspecting the view hierarchy more than one time when the constraint is activated-deactivated.
 */
@interface NSLayoutConstraint (TATContainer)

/**
 The container of the constraint.
 @return The container associated with the constraint or `nil` if there's no such object.
 @discussion This value is set when the constraint is activated and reseted once deactivated.
 */
@property (weak, nonatomic) id tat_container;

/**
 The closest ancestor shared by the views participating.
 @return The closest ancestor or `nil` if there’s no such object. Returns the first view if there's only one view participating.
 */
- (UIView *)tat_closestAncestorSharedByItems;

@end
