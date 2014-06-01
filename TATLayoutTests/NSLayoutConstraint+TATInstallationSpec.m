//
//  NSLayoutConstraint+TATInstallationSpec.m
//  TATLayoutTests
//

#import <Kiwi/Kiwi.h>
#import "NSLayoutConstraint+TATInstallation.h"
#import "TATFakeViewHierarchy.h"

SPEC_BEGIN(NSLayoutConstraint_TATInstallationSpec)

describe(@"Constraint", ^{
    
    __block TATFakeViewHierarchy *vh;
    __block NSDictionary *views;
    __block NSArray *constraints;
    __block NSLayoutConstraint *constraint;
    
    beforeEach(^{
        vh = [TATFakeViewHierarchy new];
        views = @{@"view2": vh.view2, // TODO: remove unused views
                  @"view3": vh.view3,
                  @"view4": vh.view4,
                  @"view5": vh.view5,
                  @"view6": vh.view6};
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view6][view3][view4(==250)]" options:0 metrics:nil views:views];
    });
    
    describe(@"instance", ^{
        
        context(@"when installed", ^{
            it(@"is added to the closest ancestor shared by the views paricipating", ^{
                [constraints[0] tat_install];
                [constraints[1] tat_install];
                [constraints[2] tat_install];
                
                [[vh.view1.constraints should] contain:constraints[0]];
                [[vh.view1.constraints should] contain:constraints[1]];
                [[vh.view3.constraints should] contain:constraints[2]];
            });
            context(@"if there's only one view participating", ^{
                it(@"is added to the only view", ^{
                    [constraints[3] tat_install];
                    [[vh.view4.constraints should] contain:constraints[3]];
                });
            });
            context(@"if the container cannot be found", ^{
                it(@"throws", ^{
                    constraint = [NSLayoutConstraint constraintWithItem:vh.view1
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:vh.view7
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1
                                                               constant:0];
                    [[theBlock(^{
                        [constraint tat_install];
                    }) should] raiseWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Unable to install constraint: %@\nCannot find the closest ancestor shared by the views participating. Please ensure the following views are part of the same view hierarchy before attempting to install the constraint:\n%@\n%@", constraint, vh.view1, vh.view7]];
                });
            });
        });
    });
});

SPEC_END
