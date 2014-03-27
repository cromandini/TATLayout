//
//  TATLayoutHelperSpec.m
//  TATLayout
//

#import <Kiwi/Kiwi.h>
#import "TATLayout.h"


SPEC_BEGIN(TATLayoutHelperSpec)

describe(@"Layout Helper", ^{
    
    describe(@"TATLayoutDeviceIsPad()", ^{
        context(@"when the current device idiom is Pad", ^{
            it(@"returns YES", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPad)];
                [[theValue(TATLayoutDeviceIsPad()) should] beYes];
            });
        });
        context(@"when the current device idiom is not Pad", ^{
            it(@"returns NO", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPhone)];
                [[theValue(TATLayoutDeviceIsPad()) should] beNo];
            });
        });
    });
    
    describe(@"TATLayoutDeviceIsPhone()", ^{
        context(@"when the current device idiom is Phone", ^{
            it(@"returns YES", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPhone)];
                [[theValue(TATLayoutDeviceIsPhone()) should] beYes];
            });
        });
        context(@"when the current device idiom is not Phone", ^{
            it(@"returns NO", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPad)];
                [[theValue(TATLayoutDeviceIsPhone()) should] beNo];
            });
        });
    });
    
    context(@"Autoresizing mask", ^{
        __block UIView *view1;
        __block UIView *view2;
        beforeEach(^{
            view1 = [UIView new];
            view2 = [UIView new];
            [[theValue(view1.translatesAutoresizingMaskIntoConstraints) should] beYes];
            [[theValue(view2.translatesAutoresizingMaskIntoConstraints) should] beYes];
        });
        
        describe(@"TATLayoutSetViewsToNotTranslateAutoresizingMaskIntoConstraints(firstView, ...)", ^{
            it(@"sets translatesAutoresizingMaskIntoConstraints = NO in all the views of a given nil-terminated list", ^{
                TATLayoutSetViewsToNotTranslateAutoresizingMaskIntoConstraints(view1, view2, nil);
                [[theValue(view1.translatesAutoresizingMaskIntoConstraints) should] beNo];
                [[theValue(view2.translatesAutoresizingMaskIntoConstraints) should] beNo];
            });
        });
        
        describe(@"TATLayoutUnableAutoresizingMaskInViews(...)", ^{
            it(@"sets translatesAutoresizingMaskIntoConstraints = NO in all the views of a given list", ^{
                TATLayoutUnableAutoresizingMaskInViews(view1, view2);
                [[theValue(view1.translatesAutoresizingMaskIntoConstraints) should] beNo];
                [[theValue(view2.translatesAutoresizingMaskIntoConstraints) should] beNo];
            });
        });
    });
});

SPEC_END
