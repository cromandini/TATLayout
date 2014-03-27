//
//  TATViewConstraintsSpec.m
//  TATLayout
//

#import "Kiwi.h"
#import "UIView+TATViewConstraints.h"
#import "NSLayoutConstraint+TATConstraintFactory.h"
#import "NSLayoutConstraint+TATConstraintInstall.h"

SPEC_BEGIN(TATViewConstraintsSpec)

describe(@"View", ^{
    UIView *view1 = [UIView new];
    UIView *view2 = [UIView new];
    NSDictionary *metrics = @{@"size": @"150"};
    NSDictionary *inViews = NSDictionaryOfVariableBindings(view2);
    
    context(@"when constraining a layout attribute", ^{
        NSString *inFormat = @"width == self.height";
        NSString *outFormat = @"self.width == self.height";
        NSDictionary *outViews = @{@"self": view1, @"view2": view2};
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view1
                                                                      attribute:NSLayoutAttributeWidth
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:view1
                                                                      attribute:NSLayoutAttributeHeight
                                                                     multiplier:1
                                                                       constant:0];
        beforeEach(^{
            [[NSLayoutConstraint stubAndReturn:constraint] tat_constraintWithEquationFormat:outFormat metrics:metrics views:outViews];
        });
        
        it(@"creates a constraint with the equation format", ^{
            [[[NSLayoutConstraint should] receive] tat_constraintWithEquationFormat:outFormat metrics:metrics views:outViews];
            [view1 tat_constrainLayoutAttributeUsingEquationFormat:inFormat metrics:metrics views:inViews];
        });
        it(@"prepends self in the equation format string", ^{
            KWCaptureSpy *spy = [NSLayoutConstraint captureArgument:@selector(tat_constraintWithEquationFormat:metrics:views:) atIndex:0];
            [view1 tat_constrainLayoutAttributeUsingEquationFormat:inFormat metrics:metrics views:inViews];
            [[spy.argument should] equal:outFormat];
        });
        it(@"adds the receiver in the views dictionary with the keyword self", ^{
            KWCaptureSpy *spy = [NSLayoutConstraint captureArgument:@selector(tat_constraintWithEquationFormat:metrics:views:) atIndex:2];
            [view1 tat_constrainLayoutAttributeUsingEquationFormat:inFormat metrics:metrics views:inViews];
            [[spy.argument should] equal:outViews];
        });
        context(@"when the views dictionary is nil", ^{
            it(@"creates a view dictionary containing the receiver in the keyword self", ^{
                KWCaptureSpy *spy = [NSLayoutConstraint captureArgument:@selector(tat_constraintWithEquationFormat:metrics:views:) atIndex:2];
                [view1 tat_constrainLayoutAttributeUsingEquationFormat:inFormat metrics:metrics views:nil];
                [[spy.argument should] equal:@{@"self": view1}];
            });
        });
        it(@"installs the constraint", ^{
            [[[constraint should] receive] tat_install];
            [view1 tat_constrainLayoutAttributeUsingEquationFormat:inFormat metrics:metrics views:inViews];
        });
        it(@"returns the constraint created", ^{
            [[[view1 tat_constrainLayoutAttributeUsingEquationFormat:inFormat metrics:metrics views:inViews] should] equal:constraint];
        });
        describe(@"without metrics and views", ^{
            it(@"is the same as constraining with nil metrics and views", ^{
                [[[view1 should] receive] tat_constrainLayoutAttributeUsingEquationFormat:inFormat metrics:nil views:nil];
                [view1 tat_constrainLayoutAttributeUsingEquationFormat:inFormat];
            });
        });
    });
    
    context(@"when constraining multiple layout attributes", ^{
        NSString *format1 = @"width == 100";
        NSString *format2 = @"height == 200";
        NSString *format3 = @"centerX == view2.centerX";
        NSString *format4 = @"centerY == view2.centerY";
        NSArray *formats = @[format1, format2, format3, format4];
        NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:view1
                                                                       attribute:NSLayoutAttributeWidth
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1
                                                                        constant:100];
        NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:view1
                                                                       attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1
                                                                        constant:200];
        NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:view1
                                                                       attribute:NSLayoutAttributeCenterX
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:view2
                                                                       attribute:NSLayoutAttributeCenterX
                                                                     multiplier:1
                                                                        constant:0];
        NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:view1
                                                                       attribute:NSLayoutAttributeCenterY
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:view2
                                                                       attribute:NSLayoutAttributeCenterY
                                                                     multiplier:1
                                                                        constant:0];
        NSArray *constraints = @[constraint1, constraint2, constraint3, constraint4];
        
        beforeEach(^{
            [[view1 stubAndReturn:constraint1] tat_constrainLayoutAttributeUsingEquationFormat:format1 metrics:metrics views:inViews];
            [[view1 stubAndReturn:constraint2] tat_constrainLayoutAttributeUsingEquationFormat:format2 metrics:metrics views:inViews];
            [[view1 stubAndReturn:constraint3] tat_constrainLayoutAttributeUsingEquationFormat:format3 metrics:metrics views:inViews];
            [[view1 stubAndReturn:constraint4] tat_constrainLayoutAttributeUsingEquationFormat:format4 metrics:metrics views:inViews];
        });
        
        it(@"creates and installs a constraint for every format in formats", ^{
            [[[view1 should] receive] tat_constrainLayoutAttributeUsingEquationFormat:format1 metrics:metrics views:inViews];
            [[[view1 should] receive] tat_constrainLayoutAttributeUsingEquationFormat:format2 metrics:metrics views:inViews];
            [[[view1 should] receive] tat_constrainLayoutAttributeUsingEquationFormat:format3 metrics:metrics views:inViews];
            [[[view1 should] receive] tat_constrainLayoutAttributeUsingEquationFormat:format4 metrics:metrics views:inViews];
            [view1 tat_constrainLayoutAttributesUsingEquationFormats:formats metrics:metrics views:inViews];
        });
        context(@"and any of the formats is not a string", ^{
            it(@"throws", ^{
                [[theBlock(^{
                    [view1 tat_constrainLayoutAttributesUsingEquationFormats:@[format1, [UIView new]] metrics:metrics views:inViews];
                }) should] raiseWithName:NSInternalInconsistencyException reason:@"Invalid parameter not satisfying: [format isKindOfClass:[NSString class]]"];
            });
        });
        it(@"returns the constraints created", ^{
            [[[view1 tat_constrainLayoutAttributesUsingEquationFormats:formats metrics:metrics views:inViews] should] equal:constraints];
        });
        describe(@"without metrics and views", ^{
            it(@"is the same as constraining with nil metrics and views", ^{
                [[[view1 should] receive] tat_constrainLayoutAttributesUsingEquationFormats:formats metrics:nil views:nil];
                [view1 tat_constrainLayoutAttributesUsingEquationFormats:formats];
            });
        });
    });
});

SPEC_END
