//
//  TATViewHierarchySpec.m
//  TATLayout
//

#import "Kiwi.h"
#import "UIView+TATViewHierarchy.h"
#import "TATTestViewHierarchy.h"

SPEC_BEGIN(TATViewHierarchySpec)

describe(@"View Hierarchy", ^{
    
    TATTestViewHierarchy *vh = [TATTestViewHierarchy new];
	
    describe(@"ancestor of view", ^{
        describe(@"nil", ^{
            it(@"is not ancestor of any view", ^{
                [[@([vh.view1 tat_isAncestorOfView:nil]) should] beNo];
                [[@([vh.view2 tat_isAncestorOfView:nil]) should] beNo];
                [[@([vh.view3 tat_isAncestorOfView:nil]) should] beNo];
                [[@([vh.view4 tat_isAncestorOfView:nil]) should] beNo];
                [[@([vh.view5 tat_isAncestorOfView:nil]) should] beNo];
                [[@([vh.view6 tat_isAncestorOfView:nil]) should] beNo];
                [[@([vh.view7 tat_isAncestorOfView:nil]) should] beNo];
            });
        });
        describe(@"every view", ^{
            it(@"is ancestor of itself", ^{
                [[@([vh.view1 tat_isAncestorOfView:vh.view1]) should] beYes];
                [[@([vh.view2 tat_isAncestorOfView:vh.view2]) should] beYes];
                [[@([vh.view3 tat_isAncestorOfView:vh.view3]) should] beYes];
                [[@([vh.view7 tat_isAncestorOfView:vh.view7]) should] beYes];
            });
        });
        describe(@"view1", ^{
            it(@"is ancestor of views 2, 3, 4, 5 and 6", ^{
                [[@([vh.view1 tat_isAncestorOfView:vh.view2]) should] beYes];
                [[@([vh.view1 tat_isAncestorOfView:vh.view3]) should] beYes];
                [[@([vh.view1 tat_isAncestorOfView:vh.view4]) should] beYes];
                [[@([vh.view1 tat_isAncestorOfView:vh.view5]) should] beYes];
                [[@([vh.view1 tat_isAncestorOfView:vh.view6]) should] beYes];
            });
            it(@"is not ancestor of view 7", ^{
                [[@([vh.view1 tat_isAncestorOfView:vh.view7]) should] beNo];
            });
        });
        describe(@"view2", ^{
            it(@"is ancestor of views 3, 4 and 5", ^{
                [[@([vh.view2 tat_isAncestorOfView:vh.view3]) should] beYes];
                [[@([vh.view2 tat_isAncestorOfView:vh.view4]) should] beYes];
                [[@([vh.view2 tat_isAncestorOfView:vh.view5]) should] beYes];
                [[@([vh.view2 tat_isAncestorOfView:vh.view1]) should] beNo];
                [[@([vh.view2 tat_isAncestorOfView:vh.view6]) should] beNo];
            });
            it(@"is not ancestor of views 1, 6 and 7", ^{
                [[@([vh.view2 tat_isAncestorOfView:vh.view1]) should] beNo];
                [[@([vh.view2 tat_isAncestorOfView:vh.view6]) should] beNo];
                [[@([vh.view2 tat_isAncestorOfView:vh.view7]) should] beNo];
            });
        });
        describe(@"view3", ^{
            it(@"is ancestor of view 4", ^{
                [[@([vh.view3 tat_isAncestorOfView:vh.view4]) should] beYes];
            });
            it(@"is not ancestor of views 1, 2, 5, 6 and 7", ^{
                [[@([vh.view3 tat_isAncestorOfView:vh.view1]) should] beNo];
                [[@([vh.view3 tat_isAncestorOfView:vh.view2]) should] beNo];
                [[@([vh.view3 tat_isAncestorOfView:vh.view5]) should] beNo];
                [[@([vh.view3 tat_isAncestorOfView:vh.view6]) should] beNo];
                [[@([vh.view3 tat_isAncestorOfView:vh.view7]) should] beNo];
            });
        });
        describe(@"view7", ^{
            it(@"is not ancestor of any view", ^{
                [[@([vh.view7 tat_isAncestorOfView:vh.view1]) should] beNo];
                [[@([vh.view7 tat_isAncestorOfView:vh.view2]) should] beNo];
                [[@([vh.view7 tat_isAncestorOfView:vh.view3]) should] beNo];
                [[@([vh.view7 tat_isAncestorOfView:vh.view4]) should] beNo];
                [[@([vh.view7 tat_isAncestorOfView:vh.view5]) should] beNo];
                [[@([vh.view7 tat_isAncestorOfView:vh.view6]) should] beNo];
            });
        });
        describe(@"no view", ^{
            it(@"is ancestor of view 7", ^{
                [[@([vh.view1 tat_isAncestorOfView:vh.view7]) should] beNo];
                [[@([vh.view2 tat_isAncestorOfView:vh.view7]) should] beNo];
                [[@([vh.view3 tat_isAncestorOfView:vh.view7]) should] beNo];
                [[@([vh.view4 tat_isAncestorOfView:vh.view7]) should] beNo];
                [[@([vh.view5 tat_isAncestorOfView:vh.view7]) should] beNo];
                [[@([vh.view6 tat_isAncestorOfView:vh.view7]) should] beNo];
            });
        });
    });
    
    describe(@"closest ancestor shared with view", ^{
        describe(@"view1", ^{
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
            it(@"is the closest ancestor shared by itself and view 2", ^{
                [[[vh.view1 tat_closestAncestorSharedWithView:vh.view2] should] equal:vh.view1];
                [[[vh.view2 tat_closestAncestorSharedWithView:vh.view1] should] equal:vh.view1];
            });
        });
        describe(@"view2", ^{
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
        describe(@"view7", ^{
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