//
//  TATViewConstraintsSpec.m
//  TATLayout
//

#import "Kiwi.h"
#import "UIView+TATViewConstraints.h"
#import "NSLayoutConstraint+TATConstraintFactory.h"
#import "TATViewHierarchyHelper.h"

SPEC_BEGIN(TATViewConstraintsSpec)

describe(@"Constraining layout attributes with the equation format", ^{
    
    TATViewHierarchyHelper *vh = [TATViewHierarchyHelper new];
    NSDictionary *metrics = @{@"multiplier": @2, @"priority": @751};
    NSDictionary *views = @{@"view6": vh.view6};
    
    describe(@"the receiver", ^{
        it(@"is set as the first item in the equation", ^{
            NSLayoutConstraint *constraint = [vh.view2 tat_constrainLayoutAttributeWithEquationFormat:@"width == 250"];
            [[constraint.firstItem should] equal:vh.view2];
        });
        it(@"can be set to be the second item by using the keyword self", ^{
            NSLayoutConstraint *constraint = [vh.view2 tat_constrainLayoutAttributeWithEquationFormat:@"width == self.height"];
            [[constraint.secondItem should] equal:vh.view2];
        });
    });
    
    describe(@"the constraint", ^{
        NSString *format = @"width == view6.width * multiplier + 100 @priority";
        
        it(@"is described by the equation format", ^{
            NSLayoutConstraint *constraint = [vh.view2 tat_constrainLayoutAttributeWithEquationFormat:format metrics:metrics views:views];
            
            [[@(constraint.firstAttribute) should] equal:@(NSLayoutAttributeWidth)];
            [[@(constraint.relation) should] equal:@(NSLayoutRelationEqual)];
            [[constraint.secondItem should] equal:vh.view6];
            [[@(constraint.secondAttribute) should] equal:@(NSLayoutAttributeWidth)];
            [[@(constraint.multiplier) should] equal:metrics[@"multiplier"]];
            [[@(constraint.constant) should] equal:@100];
            [[@(constraint.priority) should] equal:metrics[@"priority"]];
        });
        it(@"is created with TATConstraintFactory method tat_constraintWithEquationFormat:metrics:views:", ^{
            [[NSLayoutConstraint should] receive:@selector(tat_constraintWithEquationFormat:metrics:views:)];
            [vh.view2 tat_constrainLayoutAttributeWithEquationFormat:format metrics:metrics views:views];
        });
        it(@"is installed into the closest ancestor shared by the receiver and any view related", ^{
            NSLayoutConstraint *constraint = [vh.view2 tat_constrainLayoutAttributeWithEquationFormat:format metrics:metrics views:views];
            [[vh.view1.constraints should] contain:constraint];
        });
    });
    
    describe(@"convenience methods", ^{
        describe(@"tat_constrainLayoutAttributeWithEquationFormat", ^{
            it(@"sends tat_constrainLayoutAttributeWithEquationFormat:metrics:views: to the receiver with nil metrics and views", ^{
                NSString *equation = @"width == 250";
                [[vh.view2 should] receive:@selector(tat_constrainLayoutAttributeWithEquationFormat:metrics:views:)
                             withArguments:equation, nil, nil];
                [vh.view2 tat_constrainLayoutAttributeWithEquationFormat:equation];
            });
        });
        describe(@"tat_constrainLayoutAttributesWithEquationFormats:metrics:views:", ^{
            NSArray *formats = @[@"width == 100",
                                 @"height == 200",
                                 @"centerX == view6.centerX",
                                 @"centerY == view6.centerY"];
            
            it(@"constrains multiple layout attributes", ^{
                NSArray *constraints = [vh.view2 tat_constrainLayoutAttributesWithEquationFormats:formats metrics:metrics views:views];
                [[constraints should] haveCountOf:4];
                
                NSLayoutConstraint *constraint = constraints[0];
                [[@(constraint.firstAttribute) should] equal:@(NSLayoutAttributeWidth)];
                
                constraint = constraints[1];
                [[@(constraint.firstAttribute) should] equal:@(NSLayoutAttributeHeight)];
                
                constraint = constraints[2];
                [[@(constraint.firstAttribute) should] equal:@(NSLayoutAttributeCenterX)];
                
                constraint = constraints[3];
                [[@(constraint.firstAttribute) should] equal:@(NSLayoutAttributeCenterY)];
            });
            it(@"uses tat_constrainLayoutAttributeWithEquationFormat:metrics:views:", ^{
                [[vh.view2 should] receive:@selector(tat_constrainLayoutAttributeWithEquationFormat:metrics:views:)
                                 andReturn:@"a fake object" withCount:4];
                [vh.view2 tat_constrainLayoutAttributesWithEquationFormats:formats metrics:metrics views:views];
            });
            it(@"throws if any item in the formats array is not a string", ^{
                [[theBlock(^{
                    [vh.view2 tat_constrainLayoutAttributesWithEquationFormats:@[@"width == 100", @2] metrics:metrics views:views];
                }) should] raiseWithName:NSInternalInconsistencyException reason:@"2 is not a format string."];
            });
        });
        describe(@"tat_constrainLayoutAttributesWithEquationFormats", ^{
            it(@"sends tat_constrainLayoutAttributesWithEquationFormats:metrics:views: to the receiver with nil metrics and views", ^{
                NSArray *formats = @[@"width == 250", @"height == 300"];
                [[vh.view2 should] receive:@selector(tat_constrainLayoutAttributesWithEquationFormats:metrics:views:)
                             withArguments:formats, nil, nil];
                [vh.view2 tat_constrainLayoutAttributesWithEquationFormats:formats];
            });
        });
    });
});

SPEC_END
