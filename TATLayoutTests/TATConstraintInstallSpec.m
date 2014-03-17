//
//  TATConstraintInstallSpec.m
//  TATLayout
//

#import <Kiwi/Kiwi.h>
#import "NSLayoutConstraint+TATConstraintInstall.h"
#import "TATViewHierarchyHelper.h"

SPEC_BEGIN(TATConstraintInstallSpec)

describe(@"Installing constraints", ^{
    
    TATViewHierarchyHelper *vh = [TATViewHierarchyHelper new];
    NSDictionary *views = @{@"view2": vh.view2,
                            @"view3": vh.view3,
                            @"view4": vh.view4,
                            @"view5": vh.view5};
    
    describe(@"constraints", ^{
        it(@"are added to the closest ancestor shared by the views the constraint involves", ^{
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
        context(@"when there's only one view participating", ^{
            it(@"is added to the first view", ^{
                NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:vh.view1
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
        it(@"throws when both items are not in the view hierarchy", ^{
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:vh.view1
                                                                          attribute:NSLayoutAttributeCenterX
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:vh.view7
                                                                          attribute:NSLayoutAttributeCenterX
                                                                         multiplier:1
                                                                           constant:0];
            NSString *reason = [NSString stringWithFormat:@"Unable to install constraint: %@\nCannot find the closest ancestor shared by the views participating. Please ensure the following views are part of the view hierarchy before attempting to install the constraint:\n%@\n%@", constraint, vh.view1, vh.view7];
            
            [[theBlock(^{
                [constraint tat_install];
            }) should] raiseWithName:NSInternalInconsistencyException reason:reason];
        });
    });
});

describe(@"Uninstalling constraints", ^{
    
});

SPEC_END
