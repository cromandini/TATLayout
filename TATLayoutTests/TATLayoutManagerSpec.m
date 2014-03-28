//
//  TATLayoutManagerSpec.m
//  TATLayout
//

#import "Kiwi.h"
#import "TATLayoutManager.h"
#import "NSLayoutConstraint+TATConstraintFactory.h"
#import "NSLayoutConstraint+TATConstraintInstall.h"

SPEC_BEGIN(TATLayoutManagerSpec)

describe(@"Helper", ^{
    
    describe(@"Array with visual format and options", ^{
        NSLayoutFormatOptions formatOptions = NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom;
        
        it(@"creates an array with visual format and options", ^{
            NSString *visualFormat = @"H:|[view1][view2]|";
            [[TATLayoutManagerArrayWithVisualFormatAndOptions(visualFormat, formatOptions) should] equal:@[visualFormat, @(formatOptions)]];
        });
        context(@"when visual format is nil", ^{
            it(@"throws", ^{
                [[theBlock(^{
                    TATLayoutManagerArrayWithVisualFormatAndOptions(nil, formatOptions);
                }) should] raiseWithName:NSInternalInconsistencyException reason:@"Invalid parameter not satisfying: visualFormat"];
            });
        });
        describe(@"visual format", ^{
            it(@"can be any string", ^{
                NSString *string = @"any string";
                [[TATLayoutManagerArrayWithVisualFormatAndOptions(string, formatOptions) should] equal:@[string, @(formatOptions)]];
            });
        });
    });
});

describe(@"Layout Manager", ^{
    UIView *view = [UIView new];
    NSString *equationFormat = @"view.height == 100";
    NSString *visualFormat = @"H:|view|";
    NSLayoutFormatOptions options = NSLayoutFormatAlignAllCenterX|NSLayoutFormatAlignAllCenterY;
    NSDictionary *metrics = @{@"size": @"150"};
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:view
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1
                                                                    constant:100];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:view
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1
                                                                     constant:200];
    NSArray *constraints1And2 = @[constraint1, constraint2];
    
    context(@"when constraining using the equation format", ^{
        beforeEach(^{
            [[NSLayoutConstraint stubAndReturn:constraint1] tat_constraintWithEquationFormat:equationFormat metrics:metrics views:views];
        });
        it(@"creates the constraint", ^{
            [[[NSLayoutConstraint should] receive] tat_constraintWithEquationFormat:equationFormat metrics:metrics views:views];
            [TATLayoutManager constrainUsingEquationFormat:equationFormat metrics:metrics views:views];
        });
        it(@"installs the constraint", ^{
            [[[constraint1 should] receive] tat_install];
            [TATLayoutManager constrainUsingEquationFormat:equationFormat metrics:metrics views:views];
        });
        it(@"returns the constraint", ^{
            [[[TATLayoutManager constrainUsingEquationFormat:equationFormat metrics:metrics views:views] should] equal:constraint1];
        });
    });
    
    context(@"when constraining using the visual format", ^{
        beforeEach(^{
            [[NSLayoutConstraint stubAndReturn:constraints1And2] constraintsWithVisualFormat:visualFormat options:options metrics:metrics views:views];
        });
        it(@"creates the constraints", ^{
            [[[NSLayoutConstraint should] receive] constraintsWithVisualFormat:visualFormat options:options metrics:metrics views:views];
            [TATLayoutManager constrainUsingVisualFormat:visualFormat options:options metrics:metrics views:views];
        });
        it(@"installs the constraints", ^{
            [[[constraint1 should] receive] tat_install];
            [[[constraint2 should] receive] tat_install];
            [TATLayoutManager constrainUsingVisualFormat:visualFormat options:options metrics:metrics views:views];
        });
        it(@"returns the constraints", ^{
            [[[TATLayoutManager constrainUsingVisualFormat:visualFormat options:options metrics:metrics views:views] should] equal:constraints1And2];
        });
    });
    
    describe(@"instance", ^{
        NSString *name = @"the name";
        __block TATLayoutManager *layoutManager;
        
        beforeEach(^{
            layoutManager = [TATLayoutManager layoutManager];
        });
        
        context(@"when created", ^{
            it(@"is active", ^{
                [[theValue(layoutManager.isActive) should] beYes];
                [[theValue([TATLayoutManager new].isActive) should] beYes];
            });
            describe(@"constraints", ^{
                it(@"is empty", ^{
                    [[layoutManager.constraints should] beEmpty];
                    [[[TATLayoutManager new].constraints should] beEmpty];
                });
            });
        });
        it(@"can be deactivated", ^{
            [layoutManager deactivate];
            [[theValue(layoutManager.isActive) should] beNo];
        });
        context(@"when deactivated", ^{
            it(@"can be activated", ^{
                [layoutManager deactivate];
                [layoutManager activate];
                [[theValue(layoutManager.isActive) should] beYes];
            });
        });
        context(@"when constraining using the equation format", ^{
            beforeEach(^{
                [[NSLayoutConstraint stubAndReturn:constraint1] tat_constraintWithEquationFormat:equationFormat metrics:metrics views:views];
            });
            describe(@"the name", ^{
                it(@"can be nil", ^{
                    [[theBlock(^{
                        [layoutManager constrainUsingEquationFormat:equationFormat metrics:metrics views:views named:nil];
                    }) shouldNot] raise];
                });
            });
            context(@"without a name", ^{
                it(@"is like constraining with a nil name", ^{
                    [[[layoutManager should] receive] constrainUsingEquationFormat:equationFormat metrics:metrics views:views named:nil];
                    [layoutManager constrainUsingEquationFormat:equationFormat metrics:metrics views:views];
                });
            });
            it(@"creates the constraint", ^{
                [[[NSLayoutConstraint should] receive] tat_constraintWithEquationFormat:equationFormat metrics:metrics views:views];
                [layoutManager constrainUsingEquationFormat:equationFormat metrics:metrics views:views];
            });
            context(@"and is active", ^{
                it(@"installs the constraint", ^{
                    [[[constraint1 should] receive] tat_install];
                    [layoutManager constrainUsingEquationFormat:equationFormat metrics:metrics views:views];
                });
            });
            context(@"and is deactivated", ^{
                it(@"does not install the constraint", ^{
                    [layoutManager deactivate];
                    [[[constraint1 shouldNot] receive] tat_install];
                    [layoutManager constrainUsingEquationFormat:equationFormat metrics:metrics views:views];
                });
            });
            it(@"keeps a reference to the constraint", ^{
                [layoutManager constrainUsingEquationFormat:equationFormat metrics:metrics views:views];
                [[layoutManager.constraints should] contain:constraint1];
            });
            context(@"with a name", ^{
                describe(@"the constraint", ^{
                    it(@"can be retrieved with the same name", ^{
                        [layoutManager constrainUsingEquationFormat:equationFormat metrics:metrics views:views named:name];
                        [[[layoutManager constraintNamed:name] should] equal:constraint1];
                    });
                });
            });
        });
        context(@"when constraining using the visual format", ^{
            beforeEach(^{
                [[NSLayoutConstraint stubAndReturn:constraints1And2] constraintsWithVisualFormat:visualFormat options:options metrics:metrics views:views];
            });
            describe(@"the name", ^{
                it(@"can be nil", ^{
                    [[theBlock(^{
                        [layoutManager constrainUsingVisualFormat:visualFormat options:options metrics:metrics views:views named:nil];
                    }) shouldNot] raise];
                });
            });
            context(@"without a name", ^{
                it(@"is like constraining with a nil name", ^{
                    [[[layoutManager should] receive] constrainUsingVisualFormat:visualFormat options:options metrics:metrics views:views named:nil];
                    [layoutManager constrainUsingVisualFormat:visualFormat options:options metrics:metrics views:views];
                });
            });
            it(@"creates the constraint", ^{
                [[[NSLayoutConstraint should] receive] constraintsWithVisualFormat:visualFormat options:options metrics:metrics views:views];
                [layoutManager constrainUsingVisualFormat:visualFormat options:options metrics:metrics views:views];
            });
            context(@"and is active", ^{
                it(@"installs the constraint", ^{
                    [[[constraint1 should] receive] tat_install];
                    [[[constraint2 should] receive] tat_install];
                    [layoutManager constrainUsingVisualFormat:visualFormat options:options metrics:metrics views:views];
                });
            });
            context(@"and is deactivated", ^{
                it(@"does not install the constraint", ^{
                    [layoutManager deactivate];
                    [[[constraint1 shouldNot] receive] tat_install];
                    [[[constraint2 shouldNot] receive] tat_install];
                    [layoutManager constrainUsingVisualFormat:visualFormat options:options metrics:metrics views:views];
                });
            });
            it(@"keeps references to the constraints", ^{
                [layoutManager constrainUsingVisualFormat:visualFormat options:options metrics:metrics views:views];
                [[layoutManager.constraints should] contain:constraint1];
                [[layoutManager.constraints should] contain:constraint2];
            });
            context(@"with a name", ^{
                describe(@"the constraints", ^{
                    it(@"can be retrieved with the same name", ^{
                        [layoutManager constrainUsingVisualFormat:visualFormat options:options metrics:metrics views:views named:name];
                        [[[layoutManager constraintsNamed:name] should] equal:constraints1And2];
                    });
                });
            });
        });
    });
});

SPEC_END
