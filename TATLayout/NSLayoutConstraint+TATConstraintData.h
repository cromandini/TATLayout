//
//  NSLayoutConstraint+TATConstraintData.h
//  TATLayout
//

@import UIKit;

/**
 This category in `NSLayoutConstraint` provides support for accessing extra data, like a name that is an associated string used to retrieve constraints.
 */
@interface NSLayoutConstraint (TATConstraintData)

///--------------------------------
/// @name Accessing Constraint Data
///--------------------------------

/**
 A name is an associated string that can be assigned to the receiver. Defaults to `nil`.
 @return The name associated to the receiver or `nil` if there's no name associated.
 */
@property (strong, nonatomic) NSString *tat_name;

@end
