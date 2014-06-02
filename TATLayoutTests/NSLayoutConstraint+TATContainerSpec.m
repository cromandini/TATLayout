//
//  NSLayoutConstraint+TATContainerSpec.m
//  TATLayoutTests
//

#import "Kiwi.h"
#import "NSLayoutConstraint+TATContainer.h"
#import "TATFakeViewHierarchy.h"

SPEC_BEGIN(NSLayoutConstraint_TATContainerSpec)

describe(@"Constraint container", ^{
	
    it(@"is an object that can be associated with the constraint", ^{
        NSString *container = @"Container";
        NSLayoutConstraint *constraint = [NSLayoutConstraint new];
        
        constraint.tat_container = container;
        [[constraint.tat_container should] equal:container];
    });
    context(@"the association", ^{
        it(@"is weak", ^{
            CFStringRef container = CFStringCreateWithCString(NULL, "Container", kCFStringEncodingUTF8);
            NSLayoutConstraint *constraint = [NSLayoutConstraint new];
            constraint.tat_container = (__bridge NSString *)container;
            
            CFRelease(container);
            container = NULL;
            [[constraint.tat_container should] beNil];
        });
    });
    
    describe(@"when calculating the closest ancestor", ^{
        TATFakeViewHierarchy *vh = [TATFakeViewHierarchy new];
        __block NSLayoutConstraint *constraint;
        
        context(@"if there are 2 views participating", ^{
            it(@"returns the closest ancestor shared by the views participating", ^{
                constraint = [NSLayoutConstraint constraintWithItem:vh.view6
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:vh.view3
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0];
                [[[constraint tat_closestAncestorSharedByItems] should] equal:vh.view1];
            });
        });
        context(@"if there's only one view participating", ^{
            it(@"returns the first view", ^{
                constraint = [NSLayoutConstraint constraintWithItem:vh.view7
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:0];
                [[[constraint tat_closestAncestorSharedByItems] should] equal:vh.view7];
            });
        });
        context(@"if the closest ancestor cannot be found", ^{
            it(@"returns nil", ^{
                constraint = [NSLayoutConstraint constraintWithItem:vh.view1
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:vh.view7
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0];
                [[[constraint tat_closestAncestorSharedByItems] should] beNil];
            });
        });
    });
});

SPEC_END
