//
//  TATViewConstraintsSpec.m
//  TATLayout
//

#import "Kiwi.h"
#import "UIView+TATViewConstraints.h"

SPEC_BEGIN(TATViewConstraintsSpec)

describe(@"Constraining layout attributes with the equation format", ^{
    
    __block UIView *view1;
    __block UIView *view2;
    NSDictionary *metrics = @{};
    NSDictionary *views = @{};
    
    beforeEach(^{
        view1 = [UIView new];
        view2 = [UIView new];
    });
    
    describe(@"the receiver", ^{
        it(@"is the first item in the equation", ^{
            NSLayoutConstraint *constraint = [view1 tat_constrainLayoutAttributeWithEquationFormat:@"width == 500"];
            [[constraint.firstItem should] equal:view1];
        });
        it(@"can be set to be the second item by using the magic key self", ^{
            NSLayoutConstraint *constraint = [view1 tat_constrainLayoutAttributeWithEquationFormat:@"width == self.height"];
            [[constraint.secondItem should] equal:view1];
        });
    });
    
    describe(@"Convenience methods", ^{
        
        NSString *format = @"width == 250";
        
        describe(@"tat_constrainLayoutAttributeWithEquationFormat", ^{
            it(@"sends tat_constrainLayoutAttributeWithEquationFormat:metrics:views: to the receiver with nil metrics and views", ^{
                [[view1 should] receive:@selector(tat_constrainLayoutAttributeWithEquationFormat:metrics:views:)
                          withArguments:format, nil, nil];
                [view1 tat_constrainLayoutAttributeWithEquationFormat:format];
            });
        });
        describe(@"tat_constrainLayoutAttributeWithEquationFormat:metrics", ^{
            it(@"sends tat_constrainLayoutAttributeWithEquationFormat:metrics:views: to the receiver with nil views", ^{
                [[view1 should] receive:@selector(tat_constrainLayoutAttributeWithEquationFormat:metrics:views:)
                          withArguments:format, metrics, nil];
                [view1 tat_constrainLayoutAttributeWithEquationFormat:format metrics:metrics];
            });
        });
        describe(@"tat_constrainLayoutAttributeWithEquationFormat:views", ^{
            it(@"sends tat_constrainLayoutAttributeWithEquationFormat:metrics:views: to the receiver with nil metrics", ^{
                [[view1 should] receive:@selector(tat_constrainLayoutAttributeWithEquationFormat:metrics:views:)
                          withArguments:format, nil, views];
                [view1 tat_constrainLayoutAttributeWithEquationFormat:format views:views];
            });
        });
    });
});

SPEC_END
