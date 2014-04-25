//
//  NSLayoutConstraint+TATConstraintName.h
//  TATLayout
//

@import UIKit;

/**
 This category in `NSLayoutConstraint` adds support for naming the constraint.
 */
@interface NSLayoutConstraint (TATConstraintName)

///-------------------------
/// @name Naming Constraints
///-------------------------

/**
 A name is an associated string that can be assigned to the constraint.
 @return The name associated with the constraint or `nil` if there's no such object.
 */
@property (strong, nonatomic) NSString *tat_name;

@end
