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
    __block UIView *view3;
    __block NSDictionary *metrics;
    __block NSDictionary *views;
    
    beforeEach(^{
        view1 = [UIView new];
        view2 = [UIView new];
        view3 = [UIView new];
        metrics = @{@"constant": @300,
                    @"multiplier": @2,
                    @"priority": @751};
        views = NSDictionaryOfVariableBindings(view2, view3);
    });
    
    describe(@"the receiver", ^{
        it(@"is the first item in the equation", ^{
            NSLayoutConstraint *constraint = [view1 tat_constrainLayoutAttributeWithEquationFormat:@"width == 250"];
            [[constraint.firstItem should] equal:view1];
        });
        it(@"can be set to be the second item by using the magic keyword self", ^{
            NSLayoutConstraint *constraint = [view1 tat_constrainLayoutAttributeWithEquationFormat:@"width == self.height"];
            [[constraint.secondItem should] equal:view1];
        });
    });
    
    describe(@"the constraint created", ^{
        it(@"is described by the equation format", ^{
            NSString *format = @"width == view2.width * multiplier + constant @priority";
            NSLayoutConstraint *constraint = [view1 tat_constrainLayoutAttributeWithEquationFormat:format metrics:metrics views:views];
            
            [[@(constraint.firstAttribute) should] equal:@(NSLayoutAttributeWidth)];
            [[@(constraint.relation) should] equal:@(NSLayoutRelationEqual)];
            [[constraint.secondItem should] equal:view2];
            [[@(constraint.secondAttribute) should] equal:@(NSLayoutAttributeWidth)];
            [[@(constraint.multiplier) should] equal:metrics[@"multiplier"]];
            [[@(constraint.constant) should] equal:metrics[@"constant"]];
            [[@(constraint.priority) should] equal:metrics[@"priority"]];
        });
        it(@"is installed into the closest ancestor shared by the receiver and any view related", ^{
            // TODO: add spec
        });
    });
    
    describe(@"multiple attributes", ^{
        it(@"can be constrained in only one message", ^{
            NSArray *formats = @[@"width == self.height",
                                 @"height == view2.height * multiplier",
                                 @"centerX == view3.centerX + 100",
                                 @"centerY == view3.centerY @251"];
            NSArray *constraints = [view1 tat_constrainLayoutAttributesWithEquationFormats:formats metrics:metrics views:views];
            
            NSLayoutConstraint *constraint = (NSLayoutConstraint *)constraints[0];
            [[constraint.secondItem should] equal:view1];
            [[@(constraint.secondAttribute) should] equal:@(NSLayoutAttributeHeight)];
            
            constraint = (NSLayoutConstraint *)constraints[1];
            [[constraint.secondItem should] equal:view2];
            [[@(constraint.secondAttribute) should] equal:@(NSLayoutAttributeHeight)];
            [[@(constraint.multiplier) should] equal:metrics[@"multiplier"]];
            
            constraint = (NSLayoutConstraint *)constraints[2];
            [[constraint.secondItem should] equal:view3];
            [[@(constraint.secondAttribute) should] equal:@(NSLayoutAttributeCenterX)];
            [[@(constraint.constant) should] equal:@(100)];
            
            constraint = (NSLayoutConstraint *)constraints[3];
            [[constraint.secondItem should] equal:view3];
            [[@(constraint.secondAttribute) should] equal:@(NSLayoutAttributeCenterY)];
            [[@(constraint.priority) should] equal:@(251)];
        });
    });
    
    describe(@"convenience methods", ^{
        describe(@"tat_constrainLayoutAttributeWithEquationFormat", ^{
            it(@"sends tat_constrainLayoutAttributeWithEquationFormat:metrics:views: to the receiver with nil metrics and views", ^{
                NSString *equation = @"width == 250";
                [[view1 should] receive:@selector(tat_constrainLayoutAttributeWithEquationFormat:metrics:views:)
                          withArguments:equation, nil, nil];
                [view1 tat_constrainLayoutAttributeWithEquationFormat:equation];
            });
        });
        describe(@"tat_constrainLayoutAttributesWithEquationFormats", ^{
            it(@"sends tat_constrainLayoutAttributesWithEquationFormats:metrics:views: to the receiver with nil metrics and views", ^{
                [[view1 should] receive:@selector(tat_constrainLayoutAttributesWithEquationFormats:metrics:views:)];
                [view1 tat_constrainLayoutAttributesWithEquationFormats:@[@"width == 250",
                                                                          @"height == 300"]];
            });
        });
    });
});

SPEC_END
