<img src="https://raw.github.com/cromandini/TATLayout/master/TATLayout/Assets/TATLayout-Icon.png" width="120" alt="TATLayout" title="TATLayout">

# TATLayout
An expressive, simple yet poweful way for coding layout constraints in iOS.

#### Features:
- Category in `NSLayoutConstraint` with a class method for creating constraints using a linear equation format string.

#### Next steps:
- Extend `UIView` with convenience methods for creating/installing constraints.
- Create a Layout Manager that supports constraints creation, installation, uninstallation and retrieval (for editing).

## Installation
TATLayout is available through [CocoaPods](http://cocoapods.org) and as a static library.

#### Using TATLayout with CocoaPods
1 - install CocoaPods if you have not already done so:
```bash
$ sudo gem install cocoapods
```

2 - In your project directory, create a Podfile if you still don't have one, and add TATLayout as a dependency:
```ruby
pod "TATLayout"
```

3 - Install the dependencies and open the generated workspace:
```bash
$ pod install
$ open <YourApp>.xcworkspace
```

4 - Import TATLayout in your application's source code:
```objective-c
#import <TATLayout/TATLayout.h>
```

#### Adding TATLayout as a project into your Xcode workspace
The best way to use TATLayout in your project is to set up an Xcode workspace that contains both your app project and the TATLayout project.

1 - Clone the repository:
```bash
$ git clone https://github.com/cromandini/TATLayout.git
```

2 - Drag the TATLayout.xcodeproj file from OS X Finder directly into Xcode's Project Navigator. Xcode will prompt you about creating a workspace. Accept, and create the workspace file. Once the workspace has been created, you should also see TATLayout in the project navigator.

3 - Select your application project to go to the project editor, then select your application target to go to the target editor. Select the "Build Phases" tab, expand the "Link Binary with libraries" section, and click the + button. Choose _libTATLayout.a_ and add it to the phase. Your application will now link against the library.

4 - Select the "Build Settings" tab in your application target editor. Find the "Other Linker Flags" build setting and add the flag _-ObjC_ to this build setting’s value if it is not already present.

5 - Import TATLayout in your application's source code:
```objective-c
#import <TATLayout/TATLayout.h>
```

#### Adding TATLayout binary into your Xcode project

## Usage

Check out the [documentation](http://cocoadocs.org/docsets/TATLayout/) for a comprehensive look at all of the APIs available in TATLayout.

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
Try out the included examples app by [downloading TATLayout](https://github.com/cromandini/TATLayout/archive/master.zip), cloning the repo or simply by using CocoaPods `try` command:

```bash
$ pod try TATLayout
```

## Unit Tests
TATLayout is intensively unit tested. In order to run the tests, you must install the testing dependencies via CocoaPods:

```bash
$ cd TATLayout
$ pod install
```

Once testing dependencies are installed, open _TATLayout.xcworkspace_ in Xcode and hit command+U.

## Credits
Copyright (c) 2014 Claudio Romandini <[cromandini@me.com](mailto:cromandini@me.com)>

TATLayout uses [Kiwi](https://github.com/allending/Kiwi) for unit testing.

Available under the MIT license. See the [LICENSE](https://github.com/cromandini/TATLayout/blob/master/LICENSE) file for more info.
