//
//  TATViewConstraintsViewController.m
//  TATLayout
//
// This example showcases the use of tat_constrainLayoutAttributeWithEquationFormat:metrics:views: and variants.


#import "TATViewConstraintsViewController.h"
#import "TATLayout.h"

@interface TATViewConstraintsViewController ()
@property (strong, nonatomic) UIColor *blackColor;
@property (strong, nonatomic) UIView *keyboard;
@property (strong, nonatomic) UIView *division;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) NSLayoutConstraint *divisionWidth;
@end

@implementation TATViewConstraintsViewController

#pragma mark - Lifecycle

- (void)loadView
{
    UIView *view = [UIView new];
    
    UIColor *orange = [UIColor colorWithRed:0.941 green:0.466 blue:0.126 alpha:1.000];
    UIColor *gray = [UIColor colorWithRed:0.735 green:0.739 blue:0.744 alpha:1.000];
    UIColor *lightGray = [UIColor colorWithRed:0.843 green:0.847 blue:0.855 alpha:1.000];
    
    UIView *keyboard = [UIView new];
    keyboard.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:keyboard];
    self.keyboard = keyboard;
    [keyboard tat_constrainLayoutAttributesWithEquationFormats:@[@"bottom == superview.bottom",
                                                                 @"leading == superview.leading",
                                                                 @"trailing == superview.trailing"]];
    UIView *console = [UIView new];
    console.backgroundColor = self.blackColor;
    console.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:console];
    [console tat_constrainLayoutAttributesWithEquationFormats:@[@"top == superview.top",
                                                                @"leading == superview.leading",
                                                                @"trailing == superview.trailing",
                                                                @"bottom == keyboard.top"]
                                                      metrics:nil views:NSDictionaryOfVariableBindings(keyboard)];
    
    UIButton *division = [self buttonWithImageNamed:@"starWhite" backgroundColor:orange];
    [keyboard addSubview:division];
    self.division = division;
    [division tat_constrainLayoutAttributeWithEquationFormat:@"height == view.height * proportion"
                                                   metrics:@{@"proportion": @(1.0 / 6.3)} views:NSDictionaryOfVariableBindings(view)];
    
    UIButton *multiplication = [self buttonWithImageNamed:@"starWhite" backgroundColor:orange];
    UIButton *subtraction = [self buttonWithImageNamed:@"starWhite" backgroundColor:orange];
    UIButton *addition = [self buttonWithImageNamed:@"starWhite" backgroundColor:orange];
    UIButton *equals = [self buttonWithImageNamed:@"starWhite" backgroundColor:orange];
    
    UIButton *openPar = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *closePar = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *mc = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *mPlus = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *mMinus = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *mr = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *ac = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *sign = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *percent = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    
    UIButton *second = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *x2 = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *x3 = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *xY = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *eX = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *tenX = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *seven = [self buttonWithImageNamed:@"starBlack" backgroundColor:lightGray];
    UIButton *eight = [self buttonWithImageNamed:@"starBlack" backgroundColor:lightGray];
    UIButton *nine = [self buttonWithImageNamed:@"starBlack" backgroundColor:lightGray];
    
    UIButton *oneOverX = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *xSquare2 = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *xSquare3 = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *ySquareX = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *ln = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *log = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *four = [self buttonWithImageNamed:@"starBlack" backgroundColor:lightGray];
    UIButton *five = [self buttonWithImageNamed:@"starBlack" backgroundColor:lightGray];
    UIButton *six = [self buttonWithImageNamed:@"starBlack" backgroundColor:lightGray];
    
    UIButton *negate = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *sin = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *cos = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *tan = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *e = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *ee = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *one = [self buttonWithImageNamed:@"starBlack" backgroundColor:lightGray];
    UIButton *two = [self buttonWithImageNamed:@"starBlack" backgroundColor:lightGray];
    UIButton *three = [self buttonWithImageNamed:@"starBlack" backgroundColor:lightGray];
    
    UIButton *rad = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *sinh = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *cosh = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *tanh = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *pi = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *rand = [self buttonWithImageNamed:@"starBlack" backgroundColor:gray];
    UIButton *zero = [self buttonWithImageNamed:@"starBlack" backgroundColor:lightGray];
    UIButton *dot = [self buttonWithImageNamed:@"starBlack" backgroundColor:lightGray];
    
    NSDictionary *buttons = NSDictionaryOfVariableBindings(equals, addition, subtraction, multiplication, division, dot, three, six, nine, percent, zero, two, five, eight, sign, one, four, seven, ac, rand, ee, log, tenX, mr, pi, e, ln, eX, mMinus, tanh, tan, ySquareX, xY,mPlus, cosh, cos, xSquare3, x3, mc, sinh, sin, xSquare2, x2, closePar, rad, negate, oneOverX, second, openPar);
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[openPar(==division)][closePar(==division)][mc(==division)][mPlus(==division)][mMinus(==division)][mr(==division)][ac(==division)][sign(==division)][percent(==division)][division]|" options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[second][x2][x3][xY][eX][tenX][seven][eight][nine][multiplication]|" options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[oneOverX][xSquare2][xSquare3][ySquareX][ln][log][four][five][six][subtraction]|" options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[negate][sin][cos][tan][e][ee][one][two][three][addition]|" options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rad][sinh][cosh][tanh][pi][rand][zero][dot][equals]|" options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[division][multiplication(==division)][subtraction(==division)][addition(==division)][equals(==division)]|" options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[percent][nine][six][three][dot]|" options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sign][eight][five][two]" options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[ac][seven][four][one]" options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mr][tenX][log][ee][rand]|" options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mMinus][eX][ln][e][pi]|" options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mPlus][xY][ySquareX][tan][tanh]|" options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mc][x3][xSquare3][cos][cosh]|" options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[closePar][x2][xSquare2][sin][sinh]|" options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing metrics:nil views:buttons]];
    
    [keyboard addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[openPar][second][oneOverX][negate][rad]|" options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing metrics:nil views:buttons]];
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.text = @"0";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [console addSubview:label];
    self.label = label;
    [label tat_constrainLayoutAttributesWithEquationFormats:@[@"centerY == superview.centerY",
                                                              @"centerX == division.centerX"] metrics:nil views:buttons];
    
    self.view = view;
}

- (void)viewWillLayoutSubviews
{
    [self.keyboard removeConstraint:self.divisionWidth];
    int numberOfButtons;
    if (UIDeviceOrientationIsLandscape(self.interfaceOrientation)) {
        numberOfButtons = 10;
        self.label.font = [UIFont systemFontOfSize:40];
    } else {
        numberOfButtons = 4;
        self.label.font = [UIFont systemFontOfSize:80];
    }
    self.divisionWidth = [self.division tat_constrainLayoutAttributeWithEquationFormat:@"width == superview.width * proportion"
                                                                               metrics:@{@"proportion": @(1.0 / numberOfButtons)}
                                                                                 views:nil];
}

#pragma mark - UI helpers

- (UIButton *)buttonWithImageNamed:(NSString *)image backgroundColor:(UIColor *)backgroundColor
{
    UIButton *button = [UIButton new];
    button.backgroundColor = backgroundColor;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    button.layer.borderColor = self.blackColor.CGColor;
    button.layer.borderWidth = 0.5;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.keyboard addSubview:button];
    return button;
}

- (UIColor *)blackColor
{
    if (!_blackColor) {
        _blackColor = [UIColor colorWithRed:0.125 green:0.125 blue:0.125 alpha:1.000];
    }
    return _blackColor;
}

@end
