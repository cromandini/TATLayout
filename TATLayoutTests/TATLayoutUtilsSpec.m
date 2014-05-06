//
//  TATLayoutUtilsSpec.m
//  TATLayoutTests
//

#import <Kiwi/Kiwi.h>
#import "TATLayoutUtils.h"


SPEC_BEGIN(TATLayoutUtilsSpec)

describe(@"Utils", ^{
    
    describe(@"Device Is IPAD", ^{
        context(@"when the current device idiom is Pad", ^{
            it(@"returns YES", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPad)];
                [[@(TATDeviceIsIPAD()) should] beYes];
            });
        });
        context(@"when the current device idiom is not Pad", ^{
            it(@"returns NO", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPhone)];
                [[@(TATDeviceIsIPAD()) should] beNo];
            });
        });
    });
    
    describe(@"Device Is IPHONE", ^{
        context(@"when the current device idiom is Phone", ^{
            it(@"returns YES", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPhone)];
                [[@(TATDeviceIsIPHONE()) should] beYes];
            });
        });
        context(@"when the current device idiom is not Phone", ^{
            it(@"returns NO", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPad)];
                [[@(TATDeviceIsIPHONE()) should] beNo];
            });
        });
    });
    
    context(@"Autoresizing mask", ^{
        __block UIView *view1;
        __block UIView *view2;
        beforeEach(^{
            view1 = [UIView new];
            view2 = [UIView new];
            [[@(view1.translatesAutoresizingMaskIntoConstraints) should] beYes];
            [[@(view2.translatesAutoresizingMaskIntoConstraints) should] beYes];
        });
        
        describe(@"Disable Autoresizing Constraints In Nil Terminated Views", ^{
            it(@"sets translatesAutoresizingMaskIntoConstraints = NO in the views of a given nil-terminated list", ^{
                TATDisableAutoresizingConstraintsInNilTerminatedViews(view1, view2, nil);
                [[@(view1.translatesAutoresizingMaskIntoConstraints) should] beNo];
                [[@(view2.translatesAutoresizingMaskIntoConstraints) should] beNo];
            });
        });
        
        describe(@"Disable Autoresizing Constraints In Views", ^{
            it(@"sets translatesAutoresizingMaskIntoConstraints = NO in the views of a given list", ^{
                TATDisableAutoresizingConstraintsInViews(view1, view2);
                [[@(view1.translatesAutoresizingMaskIntoConstraints) should] beNo];
                [[@(view2.translatesAutoresizingMaskIntoConstraints) should] beNo];
            });
        });
    });

});

SPEC_END
