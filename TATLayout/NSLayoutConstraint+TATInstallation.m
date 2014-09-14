//
//  NSLayoutConstraint+TATInstallation.m
//  TATLayout
//

#import "NSLayoutConstraint+TATInstallation.h"
#import "NSLayoutConstraint+TATActivation.h"

@implementation NSLayoutConstraint (TATInstallation)

#pragma mark - Installing and Uninstalling Constraints

- (void)tat_install
{
    self.tat_active = YES;
}

+ (void)tat_installConstraints:(NSArray *)constraints;
{
    [self tat_activateConstraints:constraints];
}

- (void)tat_uninstall
{
    self.tat_active = NO;
}

+ (void)tat_uninstallConstraints:(NSArray *)constraints
{
    [self tat_deactivateConstraints:constraints];
}

#pragma mark - Creating and Installing Constraints in the Same Operation

+ (NSLayoutConstraint *)tat_installConstraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    return [self tat_activateConstraintWithEquationFormat:format metrics:metrics views:views];
}

+ (NSArray *)tat_installConstraintsWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    return [self tat_activateConstraintsWithEquationFormats:formats metrics:metrics views:views];
}

+ (NSArray *)tat_installConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    return [self tat_activateConstraintsWithVisualFormat:format options:options metrics:metrics views:views];
}

@end
