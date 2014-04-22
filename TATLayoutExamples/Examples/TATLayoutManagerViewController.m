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
    
    UIView *blue = [UIView new];
    blue.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blue];
    
    UIView *green = [UIView new];
    green.backgroundColor = [UIColor greenColor];
    [self.view addSubview:green];
    
    TATLayoutDeactivateAutoresizingMaskInViews(blue, green);
    
    NSDictionary *views = NSDictionaryOfVariableBindings(blue, green);
    
    [blue tat_constrainLayoutAttributeUsingEquationFormat:@"width == superview.width * 0.5"];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blue][green(==blue)]|"
                                                                     options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom
                                                                     metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[green]|"
                                                                      options:0 metrics:nil views:views]];
}

@end
