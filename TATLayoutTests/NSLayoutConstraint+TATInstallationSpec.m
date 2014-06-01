//
//  NSLayoutConstraint+TATInstallationSpec.m
//  TATLayoutTests
//

#import <Kiwi/Kiwi.h>
#import "TATFakeViewHierarchy.h"
#import "NSLayoutConstraint+TATInstallation.h"
#import "NSLayoutConstraint+TATFactory.h"

SPEC_BEGIN(NSLayoutConstraint_TATInstallationSpec)

describe(@"Constraint", ^{
    
    __block TATFakeViewHierarchy *vh;
    __block NSDictionary *views;
    __block NSArray *constraints;
    __block NSLayoutConstraint *constraintWith1And7;
    
    beforeEach(^{
        vh = [TATFakeViewHierarchy new];
        views = @{@"view1": vh.view1,
                  @"view2": vh.view2,
                  @"view3": vh.view3,
                  @"view4": vh.view4,
                  @"view5": vh.view5,
                  @"view6": vh.view6,
                  @"view7": vh.view7};
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view6][view3][view4(==250)]" options:0 metrics:nil views:views];
        constraintWith1And7 = [NSLayoutConstraint constraintWithItem:vh.view1
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:vh.view7
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1
                                                            constant:0];
    });
    
    describe(@"instance", ^{
        
        context(@"when installed", ^{
            it(@"is added to the closest ancestor shared by the views paricipating", ^{
                [constraints[0] tat_install];
                [constraints[1] tat_install];
                [constraints[2] tat_install];
                
                [[vh.view1.constraints should] contain:constraints[0]];
                [[vh.view1.constraints should] contain:constraints[1]];
                [[vh.view3.constraints should] contain:constraints[2]];
            });
            context(@"if there's only one view participating", ^{
                it(@"is added to the only view", ^{
                    [constraints[3] tat_install];
                    [[vh.view4.constraints should] contain:constraints[3]];
                });
            });
            context(@"if the closest ancestor cannot be found", ^{
                it(@"throws", ^{
                    [[theBlock(^{
                        [constraintWith1And7 tat_install];
                    }) should] raiseWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Unable to install constraint: %@\nCannot find the closest ancestor shared by the views participating. Please ensure the following views are part of the same view hierarchy before attempting to install the constraint:\n%@\n%@", constraintWith1And7, vh.view1, vh.view7]];
                });
            });
        });
        context(@"when uninstalled", ^{
            it(@"is removed from the closest ancestor shared by the views participating", ^{
                [vh.view1 addConstraint:constraints[0]];
                [vh.view1 addConstraint:constraints[1]];
                [vh.view3 addConstraint:constraints[2]];
                
                [constraints[0] tat_uninstall];
                [constraints[1] tat_uninstall];
                [constraints[2] tat_uninstall];
                
                [[vh.view1.constraints should] beEmpty];
                [[vh.view1.constraints should] beEmpty];
                [[vh.view3.constraints should] beEmpty];
            });
            context(@"if the constraint is not held by the closest ancestor", ^{
                it(@"has no effect", ^{
                    [vh.view1 addConstraint:constraints[2]];
                    [constraints[2] tat_uninstall];
                    
                    [[vh.view1.constraints should] contain:constraints[2]];
                });
            });
            context(@"if the constraint is not installed", ^{
                it(@"has no effect", ^{
                    [[theBlock(^{
                        [constraints[0] tat_uninstall];
                    }) shouldNot] raise];
                });
            });
            context(@"if the closest ancestor cannot be found", ^{
                it(@"has no effect", ^{
                    [[theBlock(^{
                        [constraintWith1And7 tat_uninstall];
                    }) shouldNot] raise];
                });
            });
        });
    });
    
    describe(@"class", ^{
        
        it(@"installs arrays of contraints", ^{
            [[constraints[0] should] receive:@selector(tat_install)];
            [[constraints[1] should] receive:@selector(tat_install)];
            [[constraints[2] should] receive:@selector(tat_install)];
            [[constraints[3] should] receive:@selector(tat_install)];
            
            [NSLayoutConstraint tat_installConstraints:constraints];
        });
        context(@"when installing an array of constraints, if any object is not a constraint", ^{
            it(@"throws", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_installConstraints:@[constraints[0], @1]];
                }) should] raiseWithName:NSInternalInconsistencyException reason:@"Invalid parameter not satisfying: [constraint isKindOfClass:[NSLayoutConstraint class]]"];
            });
        });
        
        it(@"uninstalls arrays of constraints", ^{
            [[constraints[0] should] receive:@selector(tat_uninstall)];
            [[constraints[1] should] receive:@selector(tat_uninstall)];
            [[constraints[2] should] receive:@selector(tat_uninstall)];
            [[constraints[3] should] receive:@selector(tat_uninstall)];
            
            [NSLayoutConstraint tat_uninstallConstraints:constraints];
        });
        context(@"when uninstalling an array of constraints, if any object is not a constraint", ^{
            it(@"throws", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_uninstallConstraints:@[constraints[0], @1]];
                }) should] raiseWithName:NSInternalInconsistencyException reason:@"Invalid parameter not satisfying: [constraint isKindOfClass:[NSLayoutConstraint class]]"];
            });
        });
        
        describe(@"when creating and installing in the same operation", ^{
            
            NSString *format = @"the format";
            NSDictionary *metrics = @{@"the": @"metrics"};
            NSDictionary *views = @{@"the": @"views"};
            __block NSLayoutConstraint *constraintMock;
            
            beforeEach(^{
                constraintMock = [NSLayoutConstraint new];
            });
            
            context(@"a constraint described by the equation format", ^{
                it(@"creates the constraint", ^{
                    [constraintMock stub:@selector(tat_install)];
                    [[NSLayoutConstraint should] receive:@selector(tat_constraintWithEquationFormat:metrics:views:)
                                               andReturn:constraintMock
                                           withArguments:format, metrics, views];
                    
                    [NSLayoutConstraint tat_installConstraintWithEquationFormat:format metrics:metrics views:views];
                });
                it(@"installs the constraint", ^{
                    [NSLayoutConstraint stub:@selector(tat_constraintWithEquationFormat:metrics:views:) andReturn:constraintMock];
                    [[constraintMock should] receive:@selector(tat_install)];
                    
                    [NSLayoutConstraint tat_installConstraintWithEquationFormat:format metrics:metrics views:views];
                });
                it(@"returns the constraint", ^{
                    [NSLayoutConstraint stub:@selector(tat_constraintWithEquationFormat:metrics:views:) andReturn:constraintMock];
                    [constraintMock stub:@selector(tat_install)];
                    
                    NSLayoutConstraint *constraint = [NSLayoutConstraint tat_installConstraintWithEquationFormat:format
                                                                                                         metrics:metrics
                                                                                                           views:views];
                    [[constraint should] equal:constraintMock];
                });
            });
            context(@"constraints described by the equation format", ^{
                NSArray *formats = @[format, @"other format"];
                
                it(@"creates the constraints", ^{
                    [constraintMock stub:@selector(tat_install)];
                    [[NSLayoutConstraint should] receive:@selector(tat_constraintWithEquationFormat:metrics:views:)
                                               andReturn:constraintMock
                                           withArguments:format, metrics, views];
                    [[NSLayoutConstraint should] receive:@selector(tat_constraintWithEquationFormat:metrics:views:)
                                               andReturn:constraintMock
                                           withArguments:@"other format", metrics, views];
                    
                    [NSLayoutConstraint tat_installConstraintsWithEquationFormats:formats metrics:metrics views:views];
                });
                it(@"installs the constraints", ^{
                    [NSLayoutConstraint stub:@selector(tat_constraintWithEquationFormat:metrics:views:) andReturn:constraintMock];
                    [[constraintMock should] receive:@selector(tat_install) withCount:2];
                    
                    [NSLayoutConstraint tat_installConstraintsWithEquationFormats:formats metrics:metrics views:views];
                });
                it(@"returns the constraints", ^{
                    [NSLayoutConstraint stub:@selector(tat_constraintWithEquationFormat:metrics:views:) andReturn:constraintMock];
                    [constraintMock stub:@selector(tat_install)];
                    
                    NSArray *constraints = [NSLayoutConstraint tat_installConstraintsWithEquationFormats:formats metrics:metrics views:views];
                    [[constraints should] equal:@[constraintMock, constraintMock]];
                });
                context(@"if any object in formats is not a string", ^{
                    it(@"throws", ^{
                        [[theBlock(^{
                            [NSLayoutConstraint tat_installConstraintsWithEquationFormats:@[@1, format] metrics:nil views:nil];
                        }) should] raiseWithName:NSInternalInconsistencyException reason:@"Invalid parameter not satisfying: [format isKindOfClass:[NSString class]]"];
                    });
                });
            });
            context(@"constraints described by the visual format", ^{
                NSLayoutFormatOptions options = NSLayoutFormatAlignAllCenterX;
                
                it(@"creates the constraints", ^{
                    [constraintMock stub:@selector(tat_install)];
                    [[NSLayoutConstraint should] receive:@selector(constraintsWithVisualFormat:options:metrics:views:)
                                               andReturn:@[constraintMock, constraintMock]
                                           withArguments:format, theValue(options), metrics, views];
                    
                    [NSLayoutConstraint tat_installConstraintsWithVisualFormat:format options:options metrics:metrics views:views];
                });
                it(@"installs the constraints", ^{
                    [NSLayoutConstraint stub:@selector(constraintsWithVisualFormat:options:metrics:views:)
                                   andReturn:@[constraintMock, constraintMock, constraintMock]];
                    [[constraintMock should] receive:@selector(tat_install) withCount:3];
                    
                    [NSLayoutConstraint tat_installConstraintsWithVisualFormat:format options:options metrics:metrics views:views];
                });
                it(@"returns the constraints", ^{
                    [NSLayoutConstraint stub:@selector(constraintsWithVisualFormat:options:metrics:views:)
                                   andReturn:@[constraintMock]];
                    [constraintMock stub:@selector(tat_install)];
                    
                    NSArray *constraints = [NSLayoutConstraint tat_installConstraintsWithVisualFormat:format
                                                                                              options:options
                                                                                              metrics:metrics
                                                                                                views:views];
                    [[constraints should] equal:@[constraintMock]];
                });
            });
        });
    });
});

SPEC_END
