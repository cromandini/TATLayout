//
//  TATLayoutHelperSpec.m
//  TATLayoutTests
//

#import <Kiwi/Kiwi.h>
#import "TATLayoutHelper.h"


SPEC_BEGIN(TATLayoutHelperSpec)

describe(@"Helper", ^{
    
    __block UIView *view1;
    __block UIView *view2;
    
    beforeEach(^{
        view1 = [UIView new];
        view2 = [UIView new];
        [[theValue(view1.translatesAutoresizingMaskIntoConstraints) should] beYes];
        [[theValue(view2.translatesAutoresizingMaskIntoConstraints) should] beYes];
    });
    
    describe(@"Disable Autoresizing Constraints In Nil Terminated Views", ^{
        it(@"sets translatesAutoresizingMaskIntoConstraints = NO in the views of a given nil-terminated list", ^{
            TATDisableAutoresizingConstraintsInNilTerminatedViews(view1, view2, nil);
            [[theValue(view1.translatesAutoresizingMaskIntoConstraints) should] beNo];
            [[theValue(view2.translatesAutoresizingMaskIntoConstraints) should] beNo];
        });
    });
    
    describe(@"Disable Autoresizing Constraints In Views", ^{
        it(@"sets translatesAutoresizingMaskIntoConstraints = NO in the views of a given list", ^{
            TATDisableAutoresizingConstraintsInViews(view1, view2);
            [[theValue(view1.translatesAutoresizingMaskIntoConstraints) should] beNo];
            [[theValue(view2.translatesAutoresizingMaskIntoConstraints) should] beNo];
        });
    });
});

SPEC_END
