//
//  NSLayoutConstraint+TATActivationSpec.m
//  TATLayoutTests
//

#import <Kiwi/Kiwi.h>
#import "TATFakeViewHierarchy.h"
#import "NSLayoutConstraint+TATActivation.h"
#import "NSLayoutConstraint+TATFactory.h"

SPEC_BEGIN(NSLayoutConstraint_TATActivationSpec)

describe(@"Constraint", ^{
    
    __block TATFakeViewHierarchy *vh;
    __block NSDictionary *views;
    __block NSArray *constraints;
    __block NSLayoutConstraint *constraintWithViews1And6;
    __block NSLayoutConstraint *constraintWithViews6And3;
    __block NSLayoutConstraint *constraintWithViews3And4;
    __block NSLayoutConstraint *constraintWithView4;
    __block NSLayoutConstraint *constraintWithViews1And7;
    
    beforeEach(^{
        vh = [TATFakeViewHierarchy new];
        views = @{@"view1": vh.view1,
                  @"view2": vh.view2,
                  @"view3": vh.view3,
                  @"view4": vh.view4,
                  @"view5": vh.view5,
                  @"view6": vh.view6,
                  @"view7": vh.view7};
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view6][view3][view4(==250)]" options:0 metrics:nil views:views];
        constraintWithViews1And6 = constraints[0];
        constraintWithViews6And3 = constraints[1];
        constraintWithViews3And4 = constraints[2];
        constraintWithView4 = constraints[3];
        constraintWithViews1And7 = [NSLayoutConstraint constraintWithItem:vh.view1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:vh.view7 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    });
    
    describe(@"instance", ^{
        
        context(@"when activated", ^{
            it(@"is active", ^{
                constraintWithViews1And6.tat_active = YES;
                [[theValue(constraintWithViews1And6.tat_isActive) should] beYes];
            });
            it(@"is added to the closest ancestor shared by the views participating", ^{
                constraintWithViews1And6.tat_active = YES;
                [[vh.view1.constraints should] contain:constraintWithViews1And6];
            });
            context(@"if there's only one view participating", ^{
                it(@"is added to the only view", ^{
                    constraintWithView4.tat_active = YES;
                    [[vh.view4.constraints should] contain:constraintWithView4];
                });
            });
            context(@"if the closest ancestor cannot be found", ^{
                it(@"throws", ^{
                    [[theBlock(^{
                        constraintWithViews1And7.tat_active = YES;
                    }) should] raiseWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Unable to install constraint: %@\nCannot find a common ancestor of the views participating. Please ensure the following views are part of the same view hierarchy before attempting to install the constraint:\n%@\n%@", constraintWithViews1And7, vh.view1, vh.view7]];
                });
            });
        });
        context(@"when deactivated", ^{
            it(@"is not active", ^{
                constraintWithViews1And6.tat_active = NO;
                [[theValue(constraintWithViews1And6.tat_isActive) should] beNo];
            });
            it(@"is removed from the closest ancestor shared by the views participating", ^{
                [vh.view1 addConstraint:constraintWithViews1And6];
                constraintWithViews1And6.tat_active = NO;
                [[vh.view1.constraints should] beEmpty];
            });
            context(@"if the constraint is not held by the closest ancestor", ^{
                it(@"has no effect", ^{
                    [vh.view1 addConstraint:constraintWithViews3And4];
                    constraintWithViews3And4.tat_active = NO;
                    
                    [[vh.view1.constraints should] contain:constraintWithViews3And4];
                });
            });
            context(@"if the constraint is not active", ^{
                it(@"has no effect", ^{
                    [[theBlock(^{
                        constraintWithViews1And6.tat_active = NO;
                    }) shouldNot] raise];
                });
            });
            context(@"if the closest ancestor cannot be found", ^{
                it(@"has no effect", ^{
                    [[theBlock(^{
                        constraintWithViews1And7.tat_active = NO;
                    }) shouldNot] raise];
                });
            });
        });
    });
    describe(@"class", ^{
        
        it(@"activates arrays of contraints", ^{
            [NSLayoutConstraint tat_activateConstraints:constraints];
            
            [[vh.view1.constraints should] contain:constraintWithViews1And6];
            [[vh.view1.constraints should] contain:constraintWithViews6And3];
            [[vh.view3.constraints should] contain:constraintWithViews3And4];
            [[vh.view4.constraints should] contain:constraintWithView4];
        });
        
        it(@"deactivates arrays of constraints", ^{
            [vh.view1 addConstraint:constraintWithViews1And6];
            [vh.view1 addConstraint:constraintWithViews6And3];
            [vh.view3 addConstraint:constraintWithViews3And4];
            [vh.view4 addConstraint:constraintWithView4];
            
            [NSLayoutConstraint tat_deactivateConstraints:constraints];
            
            [[[vh.view1 constraints] should] beEmpty];
            [[[vh.view3 constraints] should] beEmpty];
            [[[vh.view4 constraints] should] beEmpty];
        });
        
        describe(@"when creating and activating in the same operation", ^{
            
            __block NSString *format;
            __block NSDictionary *metrics;
            __block NSDictionary *views;
            
            beforeEach(^{
                metrics = @{@"margin": @10};
                views = @{@"view2": vh.view2, @"view6": vh.view6};
            });

            context(@"with the equation format", ^{
                
                beforeEach(^{
                    format = @"view6.left == superview.left + margin";
                });
                
                it(@"creates and returns an active constraint", ^{
                    NSLayoutConstraint *c = [NSLayoutConstraint tat_activateConstraintWithEquationFormat:format metrics:metrics views:views];
                    
                    [[theValue(c.tat_isActive) should] beYes];
                    [[theValue(c.constant) should] equal:theValue(10)];
                    [[[vh.view1 constraints] should] contain:c];
                });
                
                it(@"creates and returns a group of active constraints", ^{
                    NSArray *formats = @[format, @"view2.right == superview.right - 20"];
                    NSArray *cs = [NSLayoutConstraint tat_activateConstraintsWithEquationFormats:formats metrics:metrics views:views];
                    NSLayoutConstraint *c0 = cs[0];
                    NSLayoutConstraint *c1 = cs[1];

                    
                    [[theValue(c0.tat_isActive) should] beYes];
                    [[theValue(c1.tat_isActive) should] beYes];
                    [[theValue(c0.constant) should] equal:theValue(10)];
                    [[theValue(c1.constant) should] equal:theValue(-20)];
                    [[[vh.view1 constraints] should] contain:c0];
                    [[[vh.view1 constraints] should] contain:c1];
                });
            });
            
            context(@"with the visual format", ^{
                it(@"creates and returns a group of active constraints", ^{
                    format = @"V:|-margin-[view2]-20-[view6]";
                    NSLayoutFormatOptions options = NSLayoutFormatAlignAllLeft;
                    NSArray *cs = [NSLayoutConstraint tat_activateConstraintsWithVisualFormat:format options:options metrics:metrics views:views];
                    NSLayoutConstraint *c0 = cs[0];
                    NSLayoutConstraint *c1 = cs[1];
                    
                    [[theValue(c0.tat_isActive) should] beYes];
                    [[theValue(c1.tat_isActive) should] beYes];
                    [[theValue(c0.constant) should] equal:theValue(10)];
                    [[theValue(c1.constant) should] equal:theValue(20)];
                    [[[vh.view1 constraints] should] contain:c0];
                    [[[vh.view1 constraints] should] contain:c1];
                });
            });
        });
    });
});

SPEC_END
