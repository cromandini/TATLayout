//
//  TATConstraintNameSpec.m
//  TATLayoutTests
//

#import <Kiwi/Kiwi.h>
#import "NSLayoutConstraint+TATConstraintName.h"

SPEC_BEGIN(TATConstraintNameSpec)

describe(@"Constraint", ^{
    __block NSLayoutConstraint *constraint;
    
    beforeEach(^{
        constraint = [NSLayoutConstraint new];
    });
    
    describe(@"name", ^{
        it(@"is an associated string that can be assigned to the constraint", ^{
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
