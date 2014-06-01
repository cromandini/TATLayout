//
//  NSLayoutConstraint+TATFactorySpec.m
//  TATLayoutTests
//

#import "Kiwi.h"
#import "NSLayoutConstraint+TATFactory.h"

SPEC_BEGIN(NSLayoutConstraint_TATFactorySpec)

describe(@"Equation Format", ^{
    __block NSString *equation;
    __block NSLayoutConstraint *constraint;
    __block UIView *square;
    __block UIView *circle;
    __block NSDictionary *views;
    NSDictionary *metrics = @{@"multiplier": @0.5, @"constant": @750, @"priority": @251};
    
    beforeEach(^{
        square = [UIView new];
        circle = [UIView new];
        views = NSDictionaryOfVariableBindings(square, circle);
    });
    
    describe(@"items", ^{
        it(@"are keys that map to objects in the views dictionary", ^{
            equation = @"square.leading==circle.trailing";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[constraint.firstItem should] equal:square];
            [[constraint.secondItem should] equal:circle];
        });
    });
    
    describe(@"second item", ^{
        context(@"in a constraint with only one item", ^{
            it(@"is nil", ^{
                equation = @"square.width==constant";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[constraint.secondItem should] beNil];
            });
        });
        context(@"when is superview", ^{
            it(@"is the superview of the first item", ^{
                UIView *superview = [UIView new];
                [superview addSubview:square];
                equation = @"square.height==superview.height";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[constraint.secondItem should] equal:((UIView *)constraint.firstItem).superview];
                [[constraint.secondItem should] equal:superview];
            });
        });
    });
    
    describe(@"attribute", ^{
        describe(@"left", ^{
            it(@"is NSLayoutAttributeLeft", ^{
                equation = @"square.left==circle.left";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeLeft)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeLeft)];
            });
        });
        describe(@"right", ^{
            it(@"is NSLayoutAttributeRight", ^{
                equation = @"square.right==circle.right";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeRight)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeRight)];
            });
        });
        describe(@"top", ^{
            it(@"is NSLayoutAttributeTop", ^{
                equation = @"square.top==circle.top";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeTop)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeTop)];
            });
        });
        describe(@"bottom", ^{
            it(@"is NSLayoutAttributeBottom", ^{
                equation = @"square.bottom==circle.bottom";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeBottom)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeBottom)];
            });
        });
        describe(@"leading", ^{
            it(@"is NSLayoutAttributeLeading", ^{
                equation = @"square.leading==circle.leading";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeLeading)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeLeading)];
            });
        });
        describe(@"trailing", ^{
            it(@"is NSLayoutAttributeTrailing", ^{
                equation = @"square.trailing==circle.trailing";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeTrailing)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeTrailing)];
            });
        });
        describe(@"width", ^{
            it(@"is NSLayoutAttributeWidth", ^{
                equation = @"square.width==circle.width";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeWidth)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeWidth)];
            });
        });
        describe(@"height", ^{
            it(@"is NSLayoutAttributeHeight", ^{
                equation = @"square.height==circle.height";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeHeight)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeHeight)];
            });
        });
        describe(@"centerX", ^{
            it(@"is NSLayoutAttributeCenterX", ^{
                equation = @"square.centerX==circle.centerX";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeCenterX)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeCenterX)];
            });
        });
        describe(@"centerY", ^{
            it(@"is NSLayoutAttributeCenterY", ^{
                equation = @"square.centerY==circle.centerY";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeCenterY)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeCenterY)];
            });
        });
        describe(@"baseline", ^{
            it(@"is NSLayoutAttributeBaseline", ^{
                equation = @"square.baseline==circle.baseline";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeBaseline)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeBaseline)];
            });
        });
        describe(@"second attribute", ^{
            context(@"in a constraint with only one item", ^{
                it(@"is NSLayoutAttributeNotAnAttribute", ^{
                    equation = @"square.width==constant";
                    constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                    [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeNotAnAttribute)];
                });
            });
        });
    });
    
    describe(@"relation", ^{
        describe(@"less than or equal sign", ^{
            it(@"is NSLayoutRelationLessThanOrEqual", ^{
                equation = @"square.width<=circle.width";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.relation) should] equal:theValue(NSLayoutRelationLessThanOrEqual)];
            });
        });
        describe(@"equal sign", ^{
            it(@"is NSLayoutRelationEqual", ^{
                equation = @"square.width==circle.width";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.relation) should] equal:theValue(NSLayoutRelationEqual)];
            });
        });
        describe(@"greater than or equal sign (>=)", ^{
            it(@"is NSLayoutRelationGreaterThanOrEqual", ^{
                equation = @"square.width>=circle.width";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.relation) should] equal:theValue(NSLayoutRelationGreaterThanOrEqual)];
            });
        });
    });
    
    describe(@"multiplier", ^{
        it(@"can be described with an integer", ^{
            equation = @"square.width==circle.width*2";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.multiplier) should] equal:theValue(2)];
        });
        it(@"can be described with a decimal", ^{
            equation = @"square.width==circle.width*0.5";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.multiplier) should] equal:theValue(0.5)];
        });
        it(@"can be described with a decimal without specifying the integer", ^{
            equation = @"square.width==circle.width*.5";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.multiplier) should] equal:theValue(0.5)];
        });
        it(@"can be a key of an object in the metrics dictionary", ^{
            equation = @"square.width==circle.width*multiplier";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.multiplier) should] equal:theValue(0.5)];
        });
        it(@"can be omitted and defaults to 1", ^{
            equation = @"square.width==circle.width";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.multiplier) should] equal:theValue(1)];
        });
    });
    
    describe(@"constant", ^{
        it(@"can be described with an integer", ^{
            equation = @"square.width==circle.width+2";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(2)];
        });
        it(@"can be described with a decimal", ^{
            equation = @"square.width==circle.width+200.5";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(200.5)];
        });
        it(@"can be described with a decimal without specifying the integer", ^{
            equation = @"square.width==circle.width+.5";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(0.5)];
        });
        it(@"can be a key of an object in the metrics dictionary", ^{
            equation = @"square.width==circle.width+constant";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(750)];
        });
        it(@"can be omitted and defaults to 0", ^{
            equation = @"square.width==circle.width";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(0)];
        });
        context(@"when preceded with a minus sign", ^{
            context(@"and described with a number", ^{
                it(@"is negative", ^{
                    equation = @"square.width==circle.width-200";
                    constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                    [[theValue(constraint.constant) should] equal:theValue(-200)];
                });
            });
            context(@"and described with a key", ^{
                it(@"is negative", ^{
                    equation = @"square.width==circle.width-constant";
                    constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                    [[theValue(constraint.constant) should] equal:theValue(-750)];
                });
            });
        });
        context(@"when there is only one view participating", ^{
            it(@"can be described with an integer", ^{
                equation = @"square.width==500";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.constant) should] equal:theValue(500)];
            });
            it(@"can be described with a decimal", ^{
                equation = @"square.width==200.5";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.constant) should] equal:theValue(200.5)];
            });
            it(@"can be described with a decimal without specifying the integer", ^{
                equation = @"square.width==.5";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.constant) should] equal:theValue(0.5)];
            });
            it(@"can be a key of an object in the metrics dictionary", ^{
                equation = @"square.width==constant";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.constant) should] equal:theValue(750)];
            });
        });
    });
    
    describe(@"priority", ^{
        it(@"can be described with an integer", ^{
            equation = @"square.width==500@751";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.priority) should] equal:theValue(751)];
        });
        it(@"can be described with a decimal", ^{
            equation = @"square.width==circle.width@200.5";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.priority) should] equal:theValue(200.5)];
        });
        it(@"can be described with a decimal without specifying the integer", ^{
            equation = @"square.width==500@.5";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.priority) should] equal:theValue(0.5)];
        });
        it(@"can be a key of an object in the metrics dictionary", ^{
            equation = @"square.width==circle.width@priority";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.priority) should] equal:theValue(251)];
        });
        it(@"can be omitted and defaults to 1000", ^{
            equation = @"square.width==500";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.priority) should] equal:theValue(1000)];
        });
    });
    
    context(@"whitespace", ^{
        it(@"is allowed", ^{
            equation = @"square.width == circle.width * 0.5 + 25 @750";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[constraint.firstItem should] equal:square];
            [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeWidth)];
            [[theValue(constraint.relation) should] equal:theValue(NSLayoutRelationEqual)];
            [[constraint.secondItem should] equal:circle];
            [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeWidth)];
            [[theValue(constraint.multiplier) should] equal:theValue(0.5)];
            [[theValue(constraint.constant) should] equal:theValue(25)];
            [[theValue(constraint.priority) should] equal:theValue(750)];
        });
    });
});

describe(@"When creating multiple constraints", ^{
    
    NSArray *formats = @[@"format1", @"format2", @"format3"];
    NSDictionary *metrics = @{@"metrics": @"dictionary"};
    NSDictionary *views = @{@"views": @"dictionary"};
    NSLayoutConstraint *c1 = [NSLayoutConstraint new];
    NSLayoutConstraint *c2 = [NSLayoutConstraint new];
    NSLayoutConstraint *c3 = [NSLayoutConstraint new];
    
    void (^mockAndStubSingleConstraintFactory)() = ^void() {
        [[[NSLayoutConstraint should] receiveAndReturn:c1] tat_constraintWithEquationFormat:@"format1" metrics:metrics views:views];
        [[[NSLayoutConstraint should] receiveAndReturn:c2] tat_constraintWithEquationFormat:@"format2" metrics:metrics views:views];
        [[[NSLayoutConstraint should] receiveAndReturn:c3] tat_constraintWithEquationFormat:@"format3" metrics:metrics views:views];
    };
    
    it(@"returns the constraints created", ^{
        mockAndStubSingleConstraintFactory();
        NSArray *constraints = [NSLayoutConstraint tat_constraintsWithEquationFormats:formats metrics:metrics views:views];
        [[[constraints should] have:3] items];
        [[constraints[0] should] equal:c1];
        [[constraints[1] should] equal:c2];
        [[constraints[2] should] equal:c3];
    });
    context(@"all objects in formats array", ^{
        it(@"must be strings", ^{
            mockAndStubSingleConstraintFactory();
            NSArray *formatsIncludingNonString = [formats arrayByAddingObject:@[]];
            [[theBlock(^{
                [NSLayoutConstraint tat_constraintsWithEquationFormats:formatsIncludingNonString metrics:metrics views:views];
            }) should] raiseWithName:NSInternalInconsistencyException reason:@"Invalid parameter not satisfying: [format isKindOfClass:[NSString class]]"];
        });
    });
    context(@"when formats is nil", ^{
        it(@"returns an empty array", ^{
            NSArray *constraints = [NSLayoutConstraint tat_constraintsWithEquationFormats:nil metrics:metrics views:views];
            [[constraints shouldNot] beNil];
            [[constraints should] beEmpty];
        });
    });
});

SPEC_END
