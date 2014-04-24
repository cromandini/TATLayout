//
//  TATConstraintDataSpec.m
//  TATLayout
//

#import <Kiwi/Kiwi.h>
#import "NSLayoutConstraint+TATConstraintData.h"

SPEC_BEGIN(TATConstraintDataSpec)

describe(@"Constraint Data", ^{
    __block NSLayoutConstraint *constraint;
    
    beforeEach(^{
        constraint = [NSLayoutConstraint new];
    });
    
    describe(@"name", ^{
        it(@"is an associated string that can be assigned to a constraint", ^{
            NSString *name = @"the name";
            constraint.tat_name = name;
            [[constraint.tat_name should] equal:name];
        });
        it(@"is nil by default", ^{
            [[constraint.tat_name should] beNil];
        });
    });
});

SPEC_END
