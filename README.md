## An expressive, simple yet powerful way for coding layout constraints in iOS.

__TATLayout__ aims to reduce considerably the amount of lines of code used when coding layout constraints in iOS. It provides a high level API to layout constraints that makes your layout code easier to read, mantain and modify dynamically.

#### Features:
- Category in `NSLayoutConstraint` providing a factory method for creating constraints using a linear equation format string.
- Category in `NSLayoutConstraint ` providing methods for activation and deactivation that can be used in iOS 6+ but uses iOS 8 when available.
- A couple of helper methods useful for working with layouts.

## Requirements
iOS 6.0+

## Getting it
__TATLayout__ is available through [CocoaPods](http://cocoapods.org) and as a static library. Check out the [Wiki](https://github.com/cromandini/TATLayout/wiki) for detailed installation steps.

## Usage
Check out the [documentation](http://cocoadocs.org/docsets/TATLayout/) for a comprehensive look at all of the APIs available in __TATLayout__.

```objective-c
#import <TATLayout/TATLayout.h>

UIView *view1 = [UIView new];
UIView *view2 = [UIView new];
UILabel *label = [UILabel new];
NSDictionary *metrics = @{@"multiplier": @0.5, @"constant": @50, @"priority": @751};
NSDictionary *views = NSDictionaryOfVariableBindings(view1, view2, label);

TATDisableAutoresizingConstraintsInViews(view1, view2, label);


// Creating constraints with equation format strings:

NSLayoutConstraint *c;

// view1 width is equal to 100 points
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"view1.width == 100" metrics:nil views:views];

// view1 height is equal to 2 times its width
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"view1.height == view1.width * 2" metrics:nil views:views];

// view1 center x is equal to its superview's center x
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"view1.centerX == superview.centerX" metrics:nil views:views];

// view1 top is equal to its superview's top plus 50 points
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"view1.top == superview.top + constant" metrics:metrics views:views];

// view1 bottom is less than or equal to its superview's bottom with a priority of 251
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"view1.bottom <= superview.bottom @251" metrics:nil views:views];

// view1 bottom is greater than or equal to view2's bottom with a priority of 751
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"view1.bottom >= view2.bottom @priority" metrics:metrics views:views];

// view2 top is greater than or equal to three quarters of view1's top plus 50 points with a priority of 500
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"view2.top >= view1.top * 0.75 + 50 @500" metrics:nil views:views];


// Multiple constraints can be created at once:

NSArray *constraints = [tat_constraintsWithEquationFormats:@[@"view2.leading == view1.trailing" // view2 leading is equal to view1's trailing
                                                             @"view2.trailing == superview.trailing" // view2 trailing is equal to its superview's trailing
                                                             @"view2.height == view1.height * multiplier" // view2 height is equal to half the view1's height
                                                             @"label.baseline == view1.centerY" // label baseline is equal to view1's centerY
                                                             @"label.centerX == view1.centerX"] // label is x centered with view1
                                                   metrics:metrics views:views];


// Activating and deactivating constraints:

// Single (uses iOS 8 when available)
c.tat_active = YES;
c.tat_active = NO;

// Multiple (uses iOS 8 when available)
[NSLayoutConstraint tat_activateConstraints:constraints];
[NSLayoutConstraint tat_deactivateConstraints:constraints];


// Creating and activating constraints in the same operation:

[NSLayoutConstraint tat_activateConstraintWithEquationFormat:@"label.leading == view1.trailing" metrics:metrics views:views];

[NSLayoutConstraint tat_activateConstraintsWithEquationFormats:@[@"label.leading == view1.trailing"
                                                                @"label.trailing == view2.leading",
                                                                @"label.baseline == view1.centerY"]
                                                      metrics:metrics views:views];

[NSLayoutConstraint tat_activateConstraintsWithVisualFormat:@"H:|[view1][label][view2]|" options:NSLayoutFormatAlignAllTop metrics:metrics views:views];
```

## Example app
Try out the example app by opening __TATLayout.xcworkspace__ and running __TATLayoutExample__ scheme. If you haven't cloned the project you can use CocoaPods `try` command:
```bash
$ pod try TATLayout
```

## Unit Tests
__TATLayout__ is driven by unit testing. In order to run the tests, you must install the testing dependencies via CocoaPods:

```bash
$ pod install
```

Once testing dependencies are installed, open __TATLayout.xcworkspace__ in Xcode, make sure you have selected __TATLayoutExample__ scheme and hit command+U.

## Documentation
The documentation is available [online](http://cocoadocs.org/docsets/TATLayout/) through [CocoaDocs](http://cocoadocs.org).

## Credits
__TATLayout__ uses [Kiwi](https://github.com/kiwi-bdd/Kiwi) for unit testing.

This project is under the MIT license.
