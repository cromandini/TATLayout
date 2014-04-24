//
//  TATLayoutUtilitiesSpec.m
//  TATLayout
//

#import <Kiwi/Kiwi.h>
#import "TATLayout.h"


SPEC_BEGIN(TATLayoutUtilitiesSpec)

describe(@"Utilities", ^{
    
    describe(@"Device Is Pad", ^{
        context(@"when the current device idiom is Pad", ^{
            it(@"returns YES", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPad)];
                [[@(TATLayoutDeviceIsPad()) should] beYes];
            });
        });
        context(@"when the current device idiom is not Pad", ^{
            it(@"returns NO", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPhone)];
                [[@(TATLayoutDeviceIsPad()) should] beNo];
            });
        });
    });
    
    describe(@"Device Is Phone", ^{
        context(@"when the current device idiom is Phone", ^{
            it(@"returns YES", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPhone)];
                [[@(TATLayoutDeviceIsPhone()) should] beYes];
            });
        });
        context(@"when the current device idiom is not Phone", ^{
            it(@"returns NO", ^{
                [[UIDevice currentDevice] stub:@selector(userInterfaceIdiom) andReturn:theValue(UIUserInterfaceIdiomPad)];
                [[@(TATLayoutDeviceIsPhone()) should] beNo];
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
        
        describe(@"Deactivate Autoresizing Mask In Nil Terminated Views", ^{
            it(@"sets translatesAutoresizingMaskIntoConstraints = NO in all the views of a given nil-terminated list", ^{
                TATLayoutDeactivateAutoresizingMaskInNilTerminatedViews(view1, view2, nil);
                [[@(view1.translatesAutoresizingMaskIntoConstraints) should] beNo];
                [[@(view2.translatesAutoresizingMaskIntoConstraints) should] beNo];
            });
        });
        
        describe(@"Deactivate Autoresizing Mask In Views", ^{
            it(@"sets translatesAutoresizingMaskIntoConstraints = NO in all the views of a given list", ^{
                TATLayoutDeactivateAutoresizingMaskInViews(view1, view2);
                [[@(view1.translatesAutoresizingMaskIntoConstraints) should] beNo];
                [[@(view2.translatesAutoresizingMaskIntoConstraints) should] beNo];
            });
        });
    });
    
    describe(@"Array With Visual Format And Options", ^{
        NSLayoutFormatOptions options = NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom;
        
        it(@"creates an array with visual format and options", ^{
            NSString *visualFormat = @"H:|[view1][view2]|";
            [[TATLayoutArrayWithVisualFormatAndOptions(visualFormat, options) should] equal:@[visualFormat, @(options)]];
        });
        context(@"when visual format is nil", ^{
            it(@"throws", ^{
                [[theBlock(^{
                    TATLayoutArrayWithVisualFormatAndOptions(nil, options);
                }) should] raiseWithName:NSInternalInconsistencyException reason:@"Invalid parameter not satisfying: visualFormat"];
            });
        });
        describe(@"visual format", ^{
            it(@"can be any string", ^{
                NSString *string = @"any string";
                [[TATLayoutArrayWithVisualFormatAndOptions(string, options) should] equal:@[string, @(options)]];
            });
        });
    });
});

SPEC_END
