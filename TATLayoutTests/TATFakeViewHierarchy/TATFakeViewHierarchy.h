//
//  TATFakeViewHierarchy.h
//  TATLayoutTests
//

@import UIKit;

/**
 This class represents a view hierarchy stack used in some of the specs. See TATFakeViewHierarchy.pdf for visual reference.
 */
@interface TATFakeViewHierarchy : NSObject

@property (strong, nonatomic) UIView *view1;
@property (strong, nonatomic) UIView *view2;
@property (strong, nonatomic) UIView *view3;
@property (strong, nonatomic) UIView *view4;
@property (strong, nonatomic) UIView *view5;
@property (strong, nonatomic) UIView *view6;
@property (strong, nonatomic) UIView *view7;

@end
