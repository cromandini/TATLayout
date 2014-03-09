//
//  TATLayoutViewConstraintsViewController.m
//  TATLayout
//

#import "TATLayoutViewConstraintsViewController.h"
#import "TATLayout.h"

@interface TATLayoutViewConstraintsViewController ()
@end

@implementation TATLayoutViewConstraintsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] init];
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
