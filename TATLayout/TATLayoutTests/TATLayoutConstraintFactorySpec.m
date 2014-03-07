//
//  TATLayoutConstraintFactorySpec.m
//  TATLayout
//

#import "Kiwi.h"
#import "NSLayoutConstraint+TATLayoutFactory.h"

SPEC_BEGIN(TATLayoutConstraintFactorySpec)

describe(@"Constraint factory", ^{
    
    __block UIView *square;
    __block UIView *circle;
    __block NSDictionary *metrics;
    __block NSDictionary *views;
    __block NSLayoutConstraint *constraint;
    __block NSString *equation;
    
    beforeEach(^{
        square = [[UIView alloc] init];
        circle = [[UIView alloc] init];
        metrics = @{@"multiplier": @0.5, @"constant": @750, @"priority": @251};
        views = NSDictionaryOfVariableBindings(square, circle);
    });
    
    describe(@"items", ^{
        it(@"are keys that map to objects in the views dictionary", ^{
            equation = @"square.leading==circle.trailing";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[constraint.firstItem should] equal:square];
            [[constraint.secondItem should] equal:circle];
        });
        describe(@"second item", ^{
            context(@"in unary constraints", ^{
                it(@"is nil", ^{
                    equation = @"square.width==constant";
                    constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                    [[constraint.secondItem should] beNil];
                });
            });
            context(@"when the second item name is superview", ^{
                it(@"is the first item's superview", ^{
                    UIView *topView = [[UIView alloc] init];
                    [topView addSubview:square];
                    equation = @"square.height==superview.height";
                    constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                    [[constraint.secondItem should] equal:((UIView *)constraint.firstItem).superview];
                });
            });
        });
    });
    
    describe(@"attributes", ^{
        
        context(@"left", ^{
            it(@"equals to NSLayoutAttributeLeft", ^{
                equation = @"square.left==circle.left";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeLeft)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeLeft)];
            });
        });
        context(@"right", ^{
            it(@"equals to NSLayoutAttributeRight", ^{
                equation = @"square.right==circle.right";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeRight)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeRight)];
            });
        });
        context(@"top", ^{
            it(@"equals to NSLayoutAttributeTop", ^{
                equation = @"square.top==circle.top";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeTop)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeTop)];
            });
        });
        context(@"bottom", ^{
            it(@"equals to NSLayoutAttributeBottom", ^{
                equation = @"square.bottom==circle.bottom";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeBottom)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeBottom)];
            });
        });
        context(@"leading", ^{
            it(@"equals to NSLayoutAttributeLeading", ^{
                equation = @"square.leading==circle.leading";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeLeading)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeLeading)];
            });
        });
        context(@"trailing", ^{
            it(@"equals to NSLayoutAttributeTrailing", ^{
                equation = @"square.trailing==circle.trailing";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeTrailing)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeTrailing)];
            });
        });
        context(@"width", ^{
            it(@"equals to NSLayoutAttributeWidth", ^{
                equation = @"square.width==circle.width";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeWidth)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeWidth)];
            });
        });
        context(@"height", ^{
            it(@"equals to NSLayoutAttributeHeight", ^{
                equation = @"square.height==circle.height";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeHeight)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeHeight)];
            });
        });
        context(@"centerX", ^{
            it(@"equals to NSLayoutAttributeCenterX", ^{
                equation = @"square.centerX==circle.centerX";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeCenterX)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeCenterX)];
            });
        });
        context(@"centerY", ^{
            it(@"equals to NSLayoutAttributeCenterY", ^{
                equation = @"square.centerY==circle.centerY";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeCenterY)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeCenterY)];
            });
        });
        context(@"baseline", ^{
            it(@"equals to NSLayoutAttributeBaseline", ^{
                equation = @"square.baseline==circle.baseline";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.firstAttribute) should] equal:theValue(NSLayoutAttributeBaseline)];
                [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeBaseline)];
            });
        });
        describe(@"second attribute", ^{
            context(@"in unary constraints", ^{
                it(@"equals to NSLayoutAttributeNotAnAttribute", ^{
                    equation = @"square.width==constant";
                    constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                    [[theValue(constraint.secondAttribute) should] equal:theValue(NSLayoutAttributeNotAnAttribute)];
                });
            });
        });
    });
    
    describe(@"relation", ^{
        
        context(@"less than or equal sign (<=)", ^{
            it(@"equals to NSLayoutRelationLessThanOrEqual", ^{
                equation = @"square.width<=circle.width";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.relation) should] equal:theValue(NSLayoutRelationLessThanOrEqual)];
            });
        });
        context(@"equal sign (==)", ^{
            it(@"equals to NSLayoutRelationEqual", ^{
                equation = @"square.width==circle.width";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.relation) should] equal:theValue(NSLayoutRelationEqual)];
            });
        });
        context(@"greater than or equal sign (>=)", ^{
            it(@"equals to NSLayoutRelationGreaterThanOrEqual", ^{
                equation = @"square.width>=circle.width";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.relation) should] equal:theValue(NSLayoutRelationGreaterThanOrEqual)];
            });
        });
    });
    
    describe(@"multiplier", ^{
        
        it(@"can be a number", ^{
            equation = @"square.width==circle.width*2";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.multiplier) should] equal:theValue(2)];
        });
        it(@"can be a number with decimal", ^{
            equation = @"square.width==circle.width*0.5";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.multiplier) should] equal:theValue(0.5)];
        });
        it(@"can be a number with decimal without specifying the integer part", ^{
            equation = @"square.width==circle.width*.5";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.multiplier) should] equal:theValue(0.5)];
        });
        it(@"can be a key of an object in the metrics dictionary", ^{
            equation = @"square.width==circle.width*multiplier";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.multiplier) should] equal:theValue(0.5)];
        });
        it(@"is optional and defaults to 1", ^{
            equation = @"square.width==circle.width";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.multiplier) should] equal:theValue(1)];
        });
    });
    
    describe(@"constant", ^{
        
        it(@"can be a number", ^{
            equation = @"square.width==circle.width+2";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(2)];
        });
        it(@"can be a number with decimal", ^{
            equation = @"square.width==circle.width+200.5";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(200.5)];
        });
        it(@"can be a number with decimal without specifying the integer part", ^{
            equation = @"square.width==circle.width+.5";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(0.5)];
        });
        it(@"can be a key of an object in the metrics dictionary", ^{
            equation = @"square.width==circle.width+constant";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(750)];
        });
        it(@"is optional and defaults to 0", ^{
            equation = @"square.width==circle.width";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(0)];
        });
        context(@"when the modifier is a minus sign", ^{
            it(@"mofifies the constant number", ^{
                equation = @"square.width==circle.width-200";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.constant) should] equal:theValue(-200)];
            });
            it(@"mofifies the constant value from metrics", ^{
                equation = @"square.width==circle.width-constant";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.constant) should] equal:theValue(-750)];
            });
        });
    });
    
    describe(@"unary constraint constant", ^{
        
        it(@"can be a number", ^{
            equation = @"square.width==500";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(500)];
        });
        it(@"can be a number with decimal", ^{
            equation = @"square.width==200.5";
            constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
            [[theValue(constraint.constant) should] equal:theValue(200.5)];
        });
        it(@"can be a number with decimal without specifying the integer part", ^{
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
    
    describe(@"priority", ^{
        
        context(@"in unary constraints", ^{
            it(@"can be a number", ^{
                equation = @"square.width==500@751";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.priority) should] equal:theValue(751)];
            });
            it(@"can be a number with decimal", ^{
                equation = @"square.width==500@200.5";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.priority) should] equal:theValue(200.5)];
            });
            it(@"can be a number with decimal without specifying the integer part", ^{
                equation = @"square.width==500@.5";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.priority) should] equal:theValue(0.5)];
            });
            it(@"can be a key of an object in the metrics dictionary", ^{
                equation = @"square.width==500@priority";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.priority) should] equal:theValue(251)];
            });
            it(@"is optional and defaults to 1000", ^{
                equation = @"square.width==500";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.priority) should] equal:theValue(1000)];
            });
        });
        context(@"in binary constraints", ^{
            it(@"can be a number", ^{
                equation = @"square.width==circle.width@751";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.priority) should] equal:theValue(751)];
            });
            it(@"can be a number with decimal", ^{
                equation = @"square.width==circle.width@200.5";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.priority) should] equal:theValue(200.5)];
            });
            it(@"can be a number with decimal without specifying the integer part", ^{
                equation = @"square.width==circle.width@.5";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.priority) should] equal:theValue(0.5)];
            });
            it(@"can be a key of an object in the metrics dictionary", ^{
                equation = @"square.width==circle.width@priority";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.priority) should] equal:theValue(251)];
            });
            it(@"is optional and defaults to 1000", ^{
                equation = @"square.width==circle.width";
                constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:equation metrics:metrics views:views];
                [[theValue(constraint.priority) should] equal:theValue(1000)];
            });
        });
    });
    
    describe(@"whitespace", ^{
        it(@"is allowed in the format string", ^{
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

SPEC_END
