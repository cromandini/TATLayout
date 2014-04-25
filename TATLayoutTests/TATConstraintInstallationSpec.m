//
//  TATConstraintInstallationSpec.m
//  TATLayout
//

#import <Kiwi/Kiwi.h>
#import "NSLayoutConstraint+TATConstraintInstallation.h"
#import "TATTestViewHierarchy.h"

SPEC_BEGIN(TATConstraintInstallationSpec)

describe(@"Constraint", ^{
    
    TATTestViewHierarchy *vh = [TATTestViewHierarchy new];
    NSDictionary *views = @{@"view2": vh.view2,
                            @"view3": vh.view3,
                            @"view4": vh.view4,
                            @"view5": vh.view5};
    
    context(@"when installed", ^{
        __block NSLayoutConstraint *constraint;
        
        it(@"is added to the closest ancestor shared by the views paricipating", ^{
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view2][view3][view4][view5]"
                                                                           options:0 metrics:nil views:views];
            for (NSLayoutConstraint *constraint in constraints) {
                [constraint tat_install];
            }
            [[vh.view1.constraints should] contain:constraints[0]];
            [[vh.view2.constraints should] contain:constraints[1]];
            [[vh.view3.constraints should] contain:constraints[2]];
            [[vh.view2.constraints should] contain:constraints[3]];
        });
        context(@"and any of the views participating is not in the same view hierarchy", ^{
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
        context(@"and there is only one view participating", ^{
            it(@"is added to the first view", ^{
                constraint = [NSLayoutConstraint constraintWithItem:vh.view1
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:100];
                [constraint tat_install];
                [[vh.view1.constraints should] contain:constraint];
            });
        });
    });
});

SPEC_END