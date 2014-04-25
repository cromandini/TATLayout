//
//  TATTestViewHierarchy.m
//  TATLayout
//

#import "TATTestViewHierarchy.h"

@implementation TATTestViewHierarchy

- (instancetype)init
{
    self = [super init];
    if (self) {
        _view1 = [UIView new];
        _view2 = [UIView new];
        _view3 = [UIView new];
        _view4 = [UIView new];
        _view5 = [UIView new];
        _view6 = [UIView new];
        _view7 = [UIView new];
        
        [_view1 addSubview:_view2];
        [_view1 addSubview:_view6];
        [_view2 addSubview:_view3];
        [_view2 addSubview:_view5];
        [_view3 addSubview:_view4];
    }
    return self;
}

@end
