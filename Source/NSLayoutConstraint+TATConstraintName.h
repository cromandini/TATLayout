//
//  NSLayoutConstraint+TATConstraintName.h
//  TATLayout
//

@import UIKit;

/**
 This category in `NSLayoutConstraint` adds support for associating a name to the constraint. It is used in the context of a Layout Manager.
 */
@interface NSLayoutConstraint (TATConstraintName)

///-------------------------
/// @name Naming Constraints
///-------------------------

/**
 A name is an associated string that can be assigned to the constraint.
 @return The name associated with the constraint. Returns `nil` if there's no name associated.
 */
@property (strong, nonatomic) NSString *tat_name;

@end
