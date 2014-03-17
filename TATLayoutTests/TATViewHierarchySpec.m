//
//  TATViewHierarchySpec.m
//  TATLayout
//

#import "Kiwi.h"
#import "UIView+TATViewHierarchy.h"
#import "TATViewHierarchyHelper.h"

SPEC_BEGIN(TATViewHierarchySpec)

describe(@"Inspecting the View Hierarchy", ^{
    
    TATViewHierarchyHelper *vh = [TATViewHierarchyHelper new];
	
    describe(@"Ancestor of a view", ^{
        context(@"nil", ^{
            it(@"is not ancestor of any view", ^{
                [[theValue([vh.view1 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([vh.view2 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([vh.view3 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([vh.view4 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([vh.view5 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([vh.view6 tat_isAncestorOfView:nil]) should] beNo];
                [[theValue([vh.view7 tat_isAncestorOfView:nil]) should] beNo];
            });
        });
        context(@"every view", ^{
            it(@"is ancestor of itself", ^{
                [[theValue([vh.view1 tat_isAncestorOfView:vh.view1]) should] beYes];
                [[theValue([vh.view2 tat_isAncestorOfView:vh.view2]) should] beYes];
                [[theValue([vh.view3 tat_isAncestorOfView:vh.view3]) should] beYes];
                [[theValue([vh.view7 tat_isAncestorOfView:vh.view7]) should] beYes];
            });
        });
        context(@"vh.view1", ^{
            it(@"is ancestor of views 2, 3, 4, 5 and 6", ^{
                [[theValue([vh.view1 tat_isAncestorOfView:vh.view2]) should] beYes];
                [[theValue([vh.view1 tat_isAncestorOfView:vh.view3]) should] beYes];
                [[theValue([vh.view1 tat_isAncestorOfView:vh.view4]) should] beYes];
                [[theValue([vh.view1 tat_isAncestorOfView:vh.view5]) should] beYes];
                [[theValue([vh.view1 tat_isAncestorOfView:vh.view6]) should] beYes];
            });
            it(@"is not ancestor of view 7", ^{
                [[theValue([vh.view1 tat_isAncestorOfView:vh.view7]) should] beNo];
            });
        });
        context(@"vh.view2", ^{
            it(@"is ancestor of views 3, 4 and 5", ^{
                [[theValue([vh.view2 tat_isAncestorOfView:vh.view3]) should] beYes];
                [[theValue([vh.view2 tat_isAncestorOfView:vh.view4]) should] beYes];
                [[theValue([vh.view2 tat_isAncestorOfView:vh.view5]) should] beYes];
                [[theValue([vh.view2 tat_isAncestorOfView:vh.view1]) should] beNo];
                [[theValue([vh.view2 tat_isAncestorOfView:vh.view6]) should] beNo];
            });
            it(@"is not ancestor of views 1, 6 and 7", ^{
                [[theValue([vh.view2 tat_isAncestorOfView:vh.view1]) should] beNo];
                [[theValue([vh.view2 tat_isAncestorOfView:vh.view6]) should] beNo];
                [[theValue([vh.view2 tat_isAncestorOfView:vh.view7]) should] beNo];
            });
        });
        context(@"vh.view3", ^{
            it(@"is ancestor of view 4", ^{
                [[theValue([vh.view3 tat_isAncestorOfView:vh.view4]) should] beYes];
            });
            it(@"is not ancestor of views 1, 2, 5, 6 and 7", ^{
                [[theValue([vh.view3 tat_isAncestorOfView:vh.view1]) should] beNo];
                [[theValue([vh.view3 tat_isAncestorOfView:vh.view2]) should] beNo];
                [[theValue([vh.view3 tat_isAncestorOfView:vh.view5]) should] beNo];
                [[theValue([vh.view3 tat_isAncestorOfView:vh.view6]) should] beNo];
                [[theValue([vh.view3 tat_isAncestorOfView:vh.view7]) should] beNo];
            });
        });
        context(@"vh.view7", ^{
            it(@"is not ancestor of any view", ^{
                [[theValue([vh.view7 tat_isAncestorOfView:vh.view1]) should] beNo];
                [[theValue([vh.view7 tat_isAncestorOfView:vh.view2]) should] beNo];
                [[theValue([vh.view7 tat_isAncestorOfView:vh.view3]) should] beNo];
                [[theValue([vh.view7 tat_isAncestorOfView:vh.view4]) should] beNo];
                [[theValue([vh.view7 tat_isAncestorOfView:vh.view5]) should] beNo];
                [[theValue([vh.view7 tat_isAncestorOfView:vh.view6]) should] beNo];
            });
        });
        context(@"no view", ^{
            it(@"is ancestor of vh.view7", ^{
                [[theValue([vh.view1 tat_isAncestorOfView:vh.view7]) should] beNo];
                [[theValue([vh.view2 tat_isAncestorOfView:vh.view7]) should] beNo];
                [[theValue([vh.view3 tat_isAncestorOfView:vh.view7]) should] beNo];
                [[theValue([vh.view4 tat_isAncestorOfView:vh.view7]) should] beNo];
                [[theValue([vh.view5 tat_isAncestorOfView:vh.view7]) should] beNo];
                [[theValue([vh.view6 tat_isAncestorOfView:vh.view7]) should] beNo];
            });
        });
    });
    
    describe(@"Closest ancestor shared with view", ^{
        context(@"vh.view1", ^{
            it(@"is the closest ancestor shared by views 2 and 6", ^{
                [[[vh.view2 tat_closestAncestorSharedWithView:vh.view6] should] equal:vh.view1];
                [[[vh.view6 tat_closestAncestorSharedWithView:vh.view2] should] equal:vh.view1];
            });
            it(@"is the closest ancestor shared by views 3 and 6", ^{
                [[[vh.view3 tat_closestAncestorSharedWithView:vh.view6] should] equal:vh.view1];
                [[[vh.view6 tat_closestAncestorSharedWithView:vh.view3] should] equal:vh.view1];
            });
            it(@"is the closest ancestor shared by views 4 and 6", ^{
                [[[vh.view4 tat_closestAncestorSharedWithView:vh.view6] should] equal:vh.view1];
                [[[vh.view6 tat_closestAncestorSharedWithView:vh.view4] should] equal:vh.view1];
            });
            it(@"is the closest ancestor shared by views 5 and 6", ^{
                [[[vh.view5 tat_closestAncestorSharedWithView:vh.view6] should] equal:vh.view1];
                [[[vh.view6 tat_closestAncestorSharedWithView:vh.view5] should] equal:vh.view1];
            });
            it(@"is the closest ancestor shared by itself", ^{
                [[[vh.view1 tat_closestAncestorSharedWithView:vh.view1] should] equal:vh.view1];
            });
            it(@"is the closest ancestor shared by itself and vh.view2", ^{
                [[[vh.view1 tat_closestAncestorSharedWithView:vh.view2] should] equal:vh.view1];
                [[[vh.view2 tat_closestAncestorSharedWithView:vh.view1] should] equal:vh.view1];
            });
        });
        context(@"vh.view2", ^{
            it(@"is the closest ancestor shared by views 3 and 5", ^{
                [[[vh.view3 tat_closestAncestorSharedWithView:vh.view5] should] equal:vh.view2];
                [[[vh.view5 tat_closestAncestorSharedWithView:vh.view3] should] equal:vh.view2];
            });
            it(@"is the closest ancestor shared by views 4 and 5", ^{
                [[[vh.view4 tat_closestAncestorSharedWithView:vh.view5] should] equal:vh.view2];
                [[[vh.view5 tat_closestAncestorSharedWithView:vh.view4] should] equal:vh.view2];
            });
            it(@"is the closest ancestor shared by itself", ^{
                [[[vh.view2 tat_closestAncestorSharedWithView:vh.view2] should] equal:vh.view2];
            });
            it(@"is the closest ancestor shared by itself and view 3", ^{
                [[[vh.view2 tat_closestAncestorSharedWithView:vh.view3] should] equal:vh.view2];
                [[[vh.view3 tat_closestAncestorSharedWithView:vh.view2] should] equal:vh.view2];
            });
        });
        context(@"vh.view7", ^{
            it(@"does not share any ancestor", ^{
                [[[vh.view7 tat_closestAncestorSharedWithView:vh.view1] should] beNil];
                [[[vh.view7 tat_closestAncestorSharedWithView:vh.view2] should] beNil];
                [[[vh.view7 tat_closestAncestorSharedWithView:vh.view3] should] beNil];
                [[[vh.view7 tat_closestAncestorSharedWithView:vh.view4] should] beNil];
                [[[vh.view7 tat_closestAncestorSharedWithView:vh.view5] should] beNil];
                [[[vh.view7 tat_closestAncestorSharedWithView:vh.view6] should] beNil];
            });
        });
    });
});

SPEC_END
