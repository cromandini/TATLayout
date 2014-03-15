//
//  TATViewHierarchySpec.m
//  TATLayout
//

#import "Kiwi.h"
#import "UIView+TATViewHierarchy.h"

SPEC_BEGIN(TATViewHierarchySpec)

describe(@"Inspecting the View Hierarchy", ^{
	
    __block UIView *view1;
    __block UIView *view2;
    __block UIView *view3;
    __block UIView *view4;
    __block UIView *view5;
    __block UIView *view6;
    __block UIView *view7;
    
    beforeEach(^{
        view1 = [UIView new];
        view2 = [UIView new];
        view3 = [UIView new];
        view4 = [UIView new];
        view5 = [UIView new];
        view6 = [UIView new];
        view7 = [UIView new];
        
        // See ViewHierarchy.pdf in Supporting Files for visual reference
        [view1 addSubview:view2];
        [view1 addSubview:view6];
        [view2 addSubview:view3];
        [view2 addSubview:view5];
        [view3 addSubview:view4];
    });
    
    describe(@"Ancestor of a view", ^{
        
        context(@"nil", ^{
            it(@"is not ancestor of any view", ^{
                [[theValue([view1 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([view2 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([view3 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([view4 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([view5 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([view6 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([view7 tat_isAncestorOfView:nil]) should] beNo];
            });
        });
        context(@"every view", ^{
            it(@"is ancestor of itself", ^{
                [[theValue([view1 tat_isAncestorOfView:view1]) should] beYes];
                [[theValue([view2 tat_isAncestorOfView:view2]) should] beYes];
                [[theValue([view3 tat_isAncestorOfView:view3]) should] beYes];
                [[theValue([view7 tat_isAncestorOfView:view7]) should] beYes];
            });
        });
        context(@"view1", ^{
            it(@"is ancestor of views 2, 3, 4, 5 and 6", ^{
                [[theValue([view1 tat_isAncestorOfView:view2]) should] beYes];
                [[theValue([view1 tat_isAncestorOfView:view3]) should] beYes];
                [[theValue([view1 tat_isAncestorOfView:view4]) should] beYes];
                [[theValue([view1 tat_isAncestorOfView:view5]) should] beYes];
                [[theValue([view1 tat_isAncestorOfView:view6]) should] beYes];
            });
            it(@"is not ancestor of view 7", ^{
                [[theValue([view1 tat_isAncestorOfView:view7]) should] beNo];
            });
        });
        context(@"view2", ^{
            it(@"is ancestor of views 3, 4 and 5", ^{
                [[theValue([view2 tat_isAncestorOfView:view3]) should] beYes];
                [[theValue([view2 tat_isAncestorOfView:view4]) should] beYes];
                [[theValue([view2 tat_isAncestorOfView:view5]) should] beYes];
                [[theValue([view2 tat_isAncestorOfView:view1]) should] beNo];
                [[theValue([view2 tat_isAncestorOfView:view6]) should] beNo];
            });
            it(@"is not ancestor of views 1, 6 and 7", ^{
                [[theValue([view2 tat_isAncestorOfView:view1]) should] beNo];
                [[theValue([view2 tat_isAncestorOfView:view6]) should] beNo];
                [[theValue([view2 tat_isAncestorOfView:view7]) should] beNo];
            });
        });
        context(@"view3", ^{
            it(@"is ancestor of view 4", ^{
                [[theValue([view3 tat_isAncestorOfView:view4]) should] beYes];
            });
            it(@"is not ancestor of views 1, 2, 5, 6 and 7", ^{
                [[theValue([view3 tat_isAncestorOfView:view1]) should] beNo];
                [[theValue([view3 tat_isAncestorOfView:view2]) should] beNo];
                [[theValue([view3 tat_isAncestorOfView:view5]) should] beNo];
                [[theValue([view3 tat_isAncestorOfView:view6]) should] beNo];
                [[theValue([view3 tat_isAncestorOfView:view7]) should] beNo];
            });
        });
        context(@"view7", ^{
            it(@"is not ancestor of any view", ^{
                [[theValue([view7 tat_isAncestorOfView:view1]) should] beNo];
                [[theValue([view7 tat_isAncestorOfView:view2]) should] beNo];
                [[theValue([view7 tat_isAncestorOfView:view3]) should] beNo];
                [[theValue([view7 tat_isAncestorOfView:view4]) should] beNo];
                [[theValue([view7 tat_isAncestorOfView:view5]) should] beNo];
                [[theValue([view7 tat_isAncestorOfView:view6]) should] beNo];
            });
        });
        context(@"no view", ^{
            it(@"is ancestor of view7", ^{
                [[theValue([view1 tat_isAncestorOfView:view7]) should] beNo];
                [[theValue([view2 tat_isAncestorOfView:view7]) should] beNo];
                [[theValue([view3 tat_isAncestorOfView:view7]) should] beNo];
                [[theValue([view4 tat_isAncestorOfView:view7]) should] beNo];
                [[theValue([view5 tat_isAncestorOfView:view7]) should] beNo];
                [[theValue([view6 tat_isAncestorOfView:view7]) should] beNo];
            });
        });
    });
    
    describe(@"Closest ancestor shared with view", ^{
        
        context(@"view1", ^{
            it(@"is the closest ancestor shared by views 2 and 6", ^{
                [[[view2 tat_closestAncestorSharedWithView:view6] should] equal:view1];
                [[[view6 tat_closestAncestorSharedWithView:view2] should] equal:view1];
            });
            it(@"is the closest ancestor shared by views 3 and 6", ^{
                [[[view3 tat_closestAncestorSharedWithView:view6] should] equal:view1];
                [[[view6 tat_closestAncestorSharedWithView:view3] should] equal:view1];
            });
            it(@"is the closest ancestor shared by views 4 and 6", ^{
                [[[view4 tat_closestAncestorSharedWithView:view6] should] equal:view1];
                [[[view6 tat_closestAncestorSharedWithView:view4] should] equal:view1];
            });
            it(@"is the closest ancestor shared by views 5 and 6", ^{
                [[[view5 tat_closestAncestorSharedWithView:view6] should] equal:view1];
                [[[view6 tat_closestAncestorSharedWithView:view5] should] equal:view1];
            });
            it(@"is the closest ancestor shared by itself", ^{
                [[[view1 tat_closestAncestorSharedWithView:view1] should] equal:view1];
            });
            it(@"is the closest ancestor shared by itself and view2", ^{
                [[[view1 tat_closestAncestorSharedWithView:view2] should] equal:view1];
                [[[view2 tat_closestAncestorSharedWithView:view1] should] equal:view1];
            });
        });
        context(@"view2", ^{
            it(@"is the closest ancestor shared by views 3 and 5", ^{
                [[[view3 tat_closestAncestorSharedWithView:view5] should] equal:view2];
                [[[view5 tat_closestAncestorSharedWithView:view3] should] equal:view2];
            });
            it(@"is the closest ancestor shared by views 4 and 5", ^{
                [[[view4 tat_closestAncestorSharedWithView:view5] should] equal:view2];
                [[[view5 tat_closestAncestorSharedWithView:view4] should] equal:view2];
            });
            it(@"is the closest ancestor shared by itself", ^{
                [[[view2 tat_closestAncestorSharedWithView:view2] should] equal:view2];
            });
            it(@"is the closest ancestor shared by itself and view 3", ^{
                [[[view2 tat_closestAncestorSharedWithView:view3] should] equal:view2];
                [[[view3 tat_closestAncestorSharedWithView:view2] should] equal:view2];
            });
        });
        context(@"view7", ^{
            it(@"does not share any ancestor", ^{
                [[[view7 tat_closestAncestorSharedWithView:view1] should] beNil];
                [[[view7 tat_closestAncestorSharedWithView:view2] should] beNil];
                [[[view7 tat_closestAncestorSharedWithView:view3] should] beNil];
                [[[view7 tat_closestAncestorSharedWithView:view4] should] beNil];
                [[[view7 tat_closestAncestorSharedWithView:view5] should] beNil];
                [[[view7 tat_closestAncestorSharedWithView:view6] should] beNil];
            });
        });
    });
});

SPEC_END
