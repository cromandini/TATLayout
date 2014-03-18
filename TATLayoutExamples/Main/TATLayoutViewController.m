//
//  TATLayoutViewController.m
//  TATLayout
//

#import "TATLayoutViewController.h"
#import "TATConstraintFactoryViewController.h"
#import "TATViewConstraintsViewController.h"
#import "TATLayoutManagerViewController.h"

typedef NS_ENUM(NSUInteger, TATLayoutViewControllerExample) {
    TATLayoutViewControllerExampleConstraintFactory,
    TATLayoutViewControllerExampleViewConstraints,
    TATLayoutViewControllerExampleLayoutManager
};

#define TAT_LAYOUT_INIT_EXAMPLE TATLayoutViewControllerExampleConstraintFactory

@interface TATLayoutViewController () <UIActionSheetDelegate>
@property (strong, nonatomic) NSArray *exampleNames;
@property (nonatomic) TATLayoutViewControllerExample currentExample;
@property (strong, nonatomic) UIActionSheet *exampleSelector;
@end

@implementation TATLayoutViewController


- (NSArray *)exampleNames
{
    if (!_exampleNames) {
        _exampleNames = @[@"Constraint Factory",
                          @"View Constraints",
                          @"Layout Manager"];
    }
    return _exampleNames;
}

- (void)setCurrentExample:(TATLayoutViewControllerExample)example
{
    _currentExample = example;
    self.navigationItem.title = self.exampleNames[example];
}

- (UIViewController *)viewControllerForExample:(TATLayoutViewControllerExample)example
{
    switch (example) {
        case TATLayoutViewControllerExampleConstraintFactory:
            return [TATConstraintFactoryViewController new];
        case TATLayoutViewControllerExampleViewConstraints:
            return [TATViewConstraintsViewController new];
        case TATLayoutViewControllerExampleLayoutManager:
            return [TATLayoutManagerViewController new];
    }
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentExample = TAT_LAYOUT_INIT_EXAMPLE;
    UIViewController *initialViewController = [self viewControllerForExample:self.currentExample];
    [self showViewController:initialViewController];
    [initialViewController didMoveToParentViewController:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    [self dismissExampleSelectorAnimated:NO];
}

#pragma mark - Navigation

- (void)showViewController:(UIViewController *)viewController
{
    [self addChildViewController:viewController];
    viewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:viewController.view];
    NSDictionary *views = @{@"content": viewController.view};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[content]|"
                                                                      options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[content]|"
                                                                      options:0 metrics:nil views:views]];
}

- (void)cycleFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    [fromViewController willMoveToParentViewController:nil];
    [self showViewController:toViewController];
    
    toViewController.view.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        toViewController.view.alpha = 1;
        fromViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
    }];
}

#pragma mark - Example selector

- (IBAction)showExampleSelector:(UIBarButtonItem *)sender
{
    if (!self.exampleSelector) {
        self.exampleSelector = [[UIActionSheet alloc] initWithTitle:@"Show example"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:self.exampleNames[0], self.exampleNames[1], self.exampleNames[2], nil];
        [self.exampleSelector showFromBarButtonItem:sender animated:YES];
    } else {
        [self dismissExampleSelectorAnimated:YES];
    }
}

- (void)dismissExampleSelectorAnimated:(BOOL)animated
{
    [self.exampleSelector dismissWithClickedButtonIndex:[self.exampleNames count] animated:animated];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)example
{
    if (example != self.currentExample && example != actionSheet.cancelButtonIndex) {
        [self cycleFromViewController:[[self childViewControllers] lastObject] toViewController:[self viewControllerForExample:example]];
        self.currentExample = example;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.exampleSelector = nil;
}

@end
