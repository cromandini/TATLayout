//
//  NSLayoutConstraint+TATConstraintFactoryErrorSpec.m
//  TATLayoutTests
//

#import "Kiwi.h"
#import "NSLayoutConstraint+TATConstraintFactory.h"

SPEC_BEGIN(NSLayoutConstraint_TATConstraintFactoryErrorSpec)

describe(@"Constraint Factory Error", ^{

    NSString *errorMessagePrefix = @"Unable to parse constraint format:";
    __block UIView *square;
    __block UIView *circle;
    __block NSDictionary *metrics;
    __block NSDictionary *views;
    
    beforeEach(^{
        square = [UIView new];
        circle = [UIView new];
        metrics = @{@"line": @200};
        views = NSDictionaryOfVariableBindings(square, circle);
    });
    
    context(@"equation", ^{
        context(@"when the equation is nil", ^{
            it(@"throws explaining the string is empty", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:nil metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@" It's an empty string."]];
            });
        });
        context(@"when the equation is an empty string", ^{
            it(@"throws explaining the string is empty", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@" It's an empty string."]];
            });
        });
    });
    
    context(@"first item", ^{
        context(@"when the first item is a minus sign", ^{
            it(@"throws expecting a view", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"-" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a view. View names must start with a letter or an underscore, then contain letters, numbers, and underscores.\n(whitespace stripped)\n-\n^"]];
            });
        });
        context(@"when the first item starts with a number", ^{
            it(@"throws expecting a view", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"1view" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a view. View names must start with a letter or an underscore, then contain letters, numbers, and underscores.\n(whitespace stripped)\n1view\n^"]];
            });
        });
        context(@"when the first item starts with an asterisk", ^{
            it(@"throws expecting a view", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"*view" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a view. View names must start with a letter or an underscore, then contain letters, numbers, and underscores.\n(whitespace stripped)\n*view\n^"]];
            });
        });
        context(@"when the first item is not a key in the views dictionary", ^{
            it(@"throws explaining the key is not present", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"orange" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\norange is not a key in the views dictionary.\n(whitespace stripped)\norange\n      ^"]];
            });
        });
    });
    
    context(@"first attribute", ^{
        context(@"when there is no first attribute", ^{
            it(@"throws expecting an attribute", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"square" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected an attribute. Attribute names must start with a dot and be one of left, right, top, bottom, leading, trailing, width, height, centerX, centerY or baseline.\n(whitespace stripped)\nsquare\n      ^"]];
            });
        });
        context(@"when there is a dot but no first attribute", ^{
            it(@"throws expecting an attribute", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle." metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected an attribute. Attribute names must start with a dot and be one of left, right, top, bottom, leading, trailing, width, height, centerX, centerY or baseline.\n(whitespace stripped)\ncircle.\n       ^"]];
            });
        });
        context(@"when the first attribute starts with an asterisk", ^{
            it(@"throws expecting an attribute", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.*width" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected an attribute. Attribute names must start with a dot and be one of left, right, top, bottom, leading, trailing, width, height, centerX, centerY or baseline.\n(whitespace stripped)\ncircle.*width\n       ^"]];
            });
        });
        context(@"when the first attribute is not a valid name", ^{
            it(@"throws explaining the attribute name is not valid", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.size" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nsize is not a valid attribute name. Attribute names must be one of left, right, top, bottom, leading, trailing, width, height, centerX, centerY or baseline.\n(whitespace stripped)\ncircle.size\n           ^"]];
            });
        });
        context(@"when the first attribute is not valid and there is a valid relation", ^{
            it(@"throws explaining the attribute name is not valid", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.size==" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nsize is not a valid attribute name. Attribute names must be one of left, right, top, bottom, leading, trailing, width, height, centerX, centerY or baseline.\n(whitespace stripped)\ncircle.size==\n           ^"]];
            });
        });
    });
    
    context(@"relation", ^{
        context(@"when there is no relation", ^{
            it(@"throws expecting a relation", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a relation. Relation must be one of <=, == or >=.\n(whitespace stripped)\ncircle.width\n            ^"]];
            });
        });
        context(@"when there is a plus sign after a valid first attribute", ^{
            it(@"throws expecting a relation", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width+500" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a relation. Relation must be one of <=, == or >=.\n(whitespace stripped)\ncircle.width+500\n            ^"]];
            });
        });
        context(@"when there is a number after a valid first attribute", ^{
            it(@"throws expecting a relation", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width123" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a relation. Relation must be one of <=, == or >=.\n(whitespace stripped)\ncircle.width123\n            ^"]];
            });
        });
        context(@"when there is an asterisk after a valid first attribute", ^{
            it(@"throws expecting a relation", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width*0.5" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a relation. Relation must be one of <=, == or >=.\n(whitespace stripped)\ncircle.width*0.5\n            ^"]];
            });
        });
    });
    
    context(@"right hand side", ^{
        context(@"when there is no right hand side", ^{
            it(@"throws expecting a view or constant", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a view or constant.\n(whitespace stripped)\ncircle.width==\n              ^"]];
            });
        });
        context(@"when the right hand side is an asterisk", ^{
            it(@"throws expecting a view or constant", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==*" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a view or constant.\n(whitespace stripped)\ncircle.width==*\n              ^"]];
            });
        });
        context(@"when the right hand side is a plus sign", ^{
            it(@"throws expecting a view or constant", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==+" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a view or constant.\n(whitespace stripped)\ncircle.width==+\n              ^"]];
            });
        });
        context(@"when the right hand side is a dot", ^{
            it(@"throws expecting a view or constant", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==." metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a view or constant.\n(whitespace stripped)\ncircle.width==.\n              ^"]];
            });
        });
        context(@"when the right hand side is an ampersand", ^{
            it(@"throws expecting a view or constant", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==@" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected a view or constant.\n(whitespace stripped)\ncircle.width==@\n              ^"]];
            });
        });
    });
    
    context(@"second item", ^{
        context(@"when the second item is not a key in the views dictionary", ^{
            it(@"throws explaining the key is not present", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"square.width==blue.width" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nblue is not a key in the views dictionary.\n(whitespace stripped)\nsquare.width==blue.width\n                  ^"]];
            });
        });
        context(@"when the second item is superview and the first item does not have a superview", ^{
            it(@"throws explaining the first item does not have a superview", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"square.width==superview.width" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nsquare doesn't have a superview. When using superview as second item, the first view must be added to its superview before creating the constraint.\n(whitespace stripped)\nsquare.width==superview.width\n                       ^"]];
            });
        });
    });
    
    context(@"second attribute", ^{
        context(@"when the second attribute is not a valid name", ^{
            it(@"throws explaining the attribute name is not valid", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"square.width==circle.size" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nsize is not a valid attribute name. Attribute names must be one of left, right, top, bottom, leading, trailing, width, height, centerX, centerY or baseline.\n(whitespace stripped)\nsquare.width==circle.size\n                         ^"]];
            });
        });
    });
    
    context(@"multiplier", ^{
        context(@"when the multiplier is not a key in the metrics dictionary", ^{
            it(@"throws explaining the key is not present", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"square.width==circle.width*red" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nred is not a key in the metrics dictionary.\n(whitespace stripped)\nsquare.width==circle.width*red\n                              ^"]];
            });
        });
    });
    
    context(@"constant", ^{
        context(@"when the constant is not a key in the metrics dictionary", ^{
            it(@"throws explaining the key is not present", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"square.width==circle.width+red" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nred is not a key in the metrics dictionary.\n(whitespace stripped)\nsquare.width==circle.width+red\n                              ^"]];
            });
        });
        context(@"in a constraint with only one item", ^{
            context(@"when the constant is not a key in the metrics dictionary", ^{
                it(@"throws explaining the key is not present", ^{
                    [[theBlock(^{
                        [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==blue" metrics:metrics views:views];
                    }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nblue is not a key in the metrics dictionary.\n(whitespace stripped)\ncircle.width==blue\n                  ^"]];
                });
            });
            context(@"when the constant is not a key in the metrics dictionary and a dot", ^{
                it(@"throws explaining the key is not present", ^{
                    [[theBlock(^{
                        [NSLayoutConstraint tat_constraintWithEquationFormat:@"square.width==circle." metrics:metrics views:views];
                    }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\ncircle is not a key in the metrics dictionary.\n(whitespace stripped)\nsquare.width==circle.\n                    ^"]];
                });
            });
            context(@"when the constant is not a key in the metrics dictionary and an asterisk", ^{
                it(@"throws explaining the key is not present", ^{
                    [[theBlock(^{
                        [NSLayoutConstraint tat_constraintWithEquationFormat:@"square.width==blue*" metrics:metrics views:views];
                    }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nblue is not a key in the metrics dictionary.\n(whitespace stripped)\nsquare.width==blue*\n                  ^"]];
                });
            });
        });
    });
    
    context(@"priority", ^{
        context(@"when the priority is not a key in the metrics dictionary", ^{
            it(@"throws explaining the key is not present", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"square.width==circle.height@blue" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nblue is not a key in the metrics dictionary.\n(whitespace stripped)\nsquare.width==circle.height@blue\n                                ^"]];
            });
        });
        context(@"in a constraint with only one item", ^{
            context(@"when the priority is not a key in the metrics dictionary", ^{
                it(@"throws explaining the key is not present", ^{
                    [[theBlock(^{
                        [NSLayoutConstraint tat_constraintWithEquationFormat:@"square.width==line@blue" metrics:metrics views:views];
                    }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nblue is not a key in the metrics dictionary.\n(whitespace stripped)\nsquare.width==line@blue\n                       ^"]];
                });
            });
        });
    });
    
    describe(@"extra characters at the end of the format string", ^{
        context(@"when the right hand side is a valid view and attribute and an asterisk", ^{
            it(@"throws expecting the end of the format string", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"square.width==circle.width*" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected the end of the format string.\n(whitespace stripped)\nsquare.width==circle.width*\n                          ^"]];
            });
        });
        context(@"when the right hand side is a valid constant and a plus sign", ^{
            it(@"throws expecting the end of the format string", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==line+" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected the end of the format string.\n(whitespace stripped)\ncircle.width==line+\n                  ^"]];
            });
        });
        context(@"when the right hand side is a valid constant and an ampersand", ^{
            it(@"throws expecting the end of the format string", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==line@" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected the end of the format string.\n(whitespace stripped)\ncircle.width==line@\n                  ^"]];
            });
        });
        context(@"when the right hand side is a valid constant, an ampersand and a plus sign", ^{
            it(@"throws expecting the end of the format string", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==line@+" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected the end of the format string.\n(whitespace stripped)\ncircle.width==line@+\n                  ^"]];
            });
        });
        context(@"when the right hand side is a valid constant and priority and a plus sign", ^{
            it(@"throws expecting the end of the format string", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==line@200+" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected the end of the format string.\n(whitespace stripped)\ncircle.width==line@200+\n                      ^"]];
            });
        });
        context(@"when the right hand side is a valid constant and a minus sign", ^{
            it(@"throws expecting the end of the format string", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==line-" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected the end of the format string.\n(whitespace stripped)\ncircle.width==line-\n                  ^"]];
            });
        });
        context(@"when the right hand side is a valid constant and extra characters", ^{
            it(@"throws expecting the end of the format string", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==line-25*5" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected the end of the format string.\n(whitespace stripped)\ncircle.width==line-25*5\n                  ^"]];
            });
        });
        context(@"when the right hand side is a number and a plus sign", ^{
            it(@"throws expecting the end of the format string", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==750+" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected the end of the format string.\n(whitespace stripped)\ncircle.width==750+\n                 ^"]];
            });
        });
        context(@"when the right hand side is a number and extra characters", ^{
            it(@"throws expecting the end of the format string", ^{
                [[theBlock(^{
                    [NSLayoutConstraint tat_constraintWithEquationFormat:@"circle.width==750*multiplier" metrics:metrics views:views];
                }) should] raiseWithName:NSInvalidArgumentException reason:[errorMessagePrefix stringByAppendingString:@"\nExpected the end of the format string.\n(whitespace stripped)\ncircle.width==750*multiplier\n                 ^"]];
            });
        });
    });
});

SPEC_END
