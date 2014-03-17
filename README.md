# An expressive, simple yet poweful way for coding layout constraints in iOS.

TATLayout aims to reduce considerably the amount of lines of code used when coding layout constraints without compromising performance. It provides a higher level API to layout constraints that makes your layouts easier to read, mantain and modify dynamically.

#### Features:
- Category in `NSLayoutConstraint` providing a factory method for creating constraints using a linear equation format string.
- Category in `UIView` providing methods for constraining layout attributes.

#### Next steps:
- Create a Layout Manager that supports constraints creation, installation, uninstallation and retrieval (for editing).

## Requirements
iOS 6.0+

## Getting it
TATLayout is available through [CocoaPods](http://cocoapods.org) and as a static library. Check out the [Wiki](https://github.com/cromandini/TATLayout/wiki) for detailed installation steps.

## Usage
Check out the [documentation](http://cocoadocs.org/docsets/TATLayout/) for a comprehensive look at all of the APIs available in TATLayout.

#### Constraining layout attributes of a view:
```objective-c
UIView *view1 = [UIView new];
view1.translatesAutoresizingMaskIntoConstraints = NO;
[self.view addSubview:view1];

// Single attribute
[view1 tat_constrainLayoutAttributeWithEquationFormat:@"width == 300"];

// Multiple attributes
[view1 tat_constrainLayoutAttributesWithEquationFormats:@[@"width == superview.width * 0.5", @"height == superview.height * 0.5", @"centerX == superview.centerX", @"centerY == superview.centerY"]];

// Using metrics and views
UIView *view2 = [UIView new];
view2.translatesAutoresizingMaskIntoConstraints = NO;
NSDictionary *metrics = @{@"multiplier": @0.8, @"constant": @100, @"priority": @751};
NSDictionary *views = NSDictionaryOfVariableBindings(view2);

[view1 tat_constrainLayoutAttributeWithEquationFormat:@"leading == view2.leading + constant" metrics:metrics views:views];
[view1 tat_constrainLayoutAttributesWithEquationFormats:@[@"width == view2.width * multiplier", @"height == view2.height * multiplier", @"centerX == superview.centerX @priority", @"centerY == superview.centerY @priority"] metrics:metrics views:views];
```

#### Creating constraints with equation format strings:

```objective-c
NSDictionary *metrics = @{@"multiplier": @0.5, @"constant": @50, @"priority": @751};
NSDictionary *views = NSDictionaryOfVariableBindings(view1, view2, label);
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

// view2 leading is equal to view1's trailing
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"view2.leading == view1.trailing" metrics:nil views:views];

// view2 trailing is equal to its superview's trailing
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"view2.trailing == superview.trailing" metrics:nil views:views];

// view2 height is equal to half the view1's height
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"view2.height == view1.height * multiplier" metrics:metrics views:views];

// view2 top is greater than or equal to three quarters of view1's top plus 50 points with a priority of 500
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"view2.top >= view1.top * 0.75 + 50 @500" metrics:nil views:views];

// label baseline is equal to view1's centerY
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"label.baseline == view1.centerY" metrics:nil views:views];

// label is x centered with view1
c = [NSLayoutConstraint tat_constraintWithEquationFormat:@"label.centerX == view1.centerX" metrics:nil views:views];
```

## Examples app
Try out the examples app by opening __TATLayout.xcworkspace__ and running __TATLayoutExamples__ scheme. If you haven't cloned the project you can use CocoaPods `try` command:
```bash
$ pod try TATLayout
```

## Unit Tests
TATLayout is intensively unit tested. In order to run the tests, you must install the testing dependencies via CocoaPods:

```bash
$ pod install
```

Once testing dependencies are installed, open __TATLayout.xcworkspace__ in Xcode, make sure you have selected __TATLayoutExamples__ scheme and hit command+U.

## Documentation
The documentation is available [online](http://cocoadocs.org/docsets/TATLayout/) through [CocoaDocs](http://cocoadocs.org). Alternatively you can build the __Documentation__ scheme to have it locally. Once builded, the documentation is available in Xcode's Documentation and API Reference. Also, a folder named "Documentation" is created in the project containing the documentation in docset and html formats.

## Credits
Copyright (c) 2014 Claudio Romandini <[cromandini@me.com](mailto:cromandini@me.com)>

TATLayout uses [Kiwi](https://github.com/allending/Kiwi) for unit testing.

Available under the MIT license. See the [LICENSE](https://github.com/cromandini/TATLayout/blob/master/LICENSE) file for more info.
