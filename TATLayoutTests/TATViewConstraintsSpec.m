//
//  TATViewConstraintsSpec.m
//  TATLayout
//

#import "Kiwi.h"
#import "UIView+TATViewConstraints.h"
#import "NSLayoutConstraint+TATConstraintFactory.h"

SPEC_BEGIN(TATViewConstraintsSpec)

describe(@"Constraining Layout Attributes", ^{
    
    __block UIView *view1;
    __block UIView *view2;
    __block NSDictionary *metrics;
    __block NSDictionary *views;
    
    beforeEach(^{
        view1 = [UIView new];
        view2 = [UIView new];
        metrics = @{};
        views = @{};
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
