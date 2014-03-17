//
//  TATViewConstraintsViewController.m
//  TATLayout
//

#import "TATViewConstraintsViewController.h"
#import "TATLayout.h"

@interface TATViewConstraintsViewController ()
@end

@implementation TATViewConstraintsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor greenColor];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view];
    [view tat_constrainLayoutAttributesWithEquationFormats:@[@"width == superview.width * 0.9",
                                                             @"height == superview.height * 0.9",
                                                             @"centerX == superview.centerX",
                                                             @"centerY == superview.centerY"]];
}

@end
