//
//  TATLayoutManagerViewController.m
//  TATLayout
//

#import "TATLayoutManagerViewController.h"
#import "TATLayout.h"

@interface TATLayoutManagerViewController ()
@end

@implementation TATLayoutManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *label = [UILabel new];
    label.text = @"Coming soon...";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    NSDictionary *bindings = NSDictionaryOfVariableBindings(label);
    [self.view addConstraint:[NSLayoutConstraint tat_constraintWithEquationFormat:@"label.centerX == superview.centerX"
                                                                          metrics:nil views:bindings]];
    [self.view addConstraint:[NSLayoutConstraint tat_constraintWithEquationFormat:@"label.centerY == superview.centerY"
                                                                          metrics:nil views:bindings]];
}

@end
