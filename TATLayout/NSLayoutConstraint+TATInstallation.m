//
//  NSLayoutConstraint+TATInstallation.m
//  TATLayout
//

#import "NSLayoutConstraint+TATInstallation.h"
#import "NSLayoutConstraint+TATFactory.h"
#import "NSLayoutConstraint+TATContainer.h"

static NSString * const TATInstallationErrorClosestAncestorSharedByItemsNotFound = @"Unable to install constraint: %@\nCannot find the closest ancestor shared by the views participating. Please ensure the following views are part of the same view hierarchy before attempting to install the constraint:\n%@\n%@";

@implementation NSLayoutConstraint (TATInstallation)

#pragma mark - Installing Constraints

- (void)tat_install
{
    UIView *container = self.tat_container;
    if (!container) {
        container = [self tat_closestAncestorSharedByItems];
        if (!container) {
            NSString *reason = [NSString stringWithFormat:TATInstallationErrorClosestAncestorSharedByItemsNotFound,
                                self, self.firstItem, self.secondItem];
            @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
        }
        self.tat_container = container;
    }
    [container addConstraint:self];
}

+ (void)tat_installConstraints:(NSArray *)constraints;
{
    for (id constraint in constraints) {
        NSParameterAssert([constraint isKindOfClass:[NSLayoutConstraint class]]);
        [constraint tat_install];
    }
}

#pragma mark - Creating and Installing Constraints in the Same Operation

+ (NSLayoutConstraint *)tat_installConstraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSLayoutConstraint *constraint = [self tat_constraintWithEquationFormat:format metrics:metrics views:views];
    [constraint tat_install];
    return constraint;
}

+ (NSArray *)tat_installConstraintsWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:[formats count]];
    for (id format in formats) {
        NSParameterAssert([format isKindOfClass:[NSString class]]);
        NSLayoutConstraint *constraint = [self tat_installConstraintWithEquationFormat:format metrics:metrics views:views];
        [constraints addObject:constraint];
    }
    return [constraints copy];
}

+ (NSArray *)tat_installConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:views];
    for (NSLayoutConstraint *constraint in constraints) {
        [constraint tat_install];
    }
    return constraints;
}

#pragma mark - Uninstalling Constraints

- (void)tat_uninstall
{
    UIView *container = self.tat_container;
    if (!container) {
        container = [self tat_closestAncestorSharedByItems];
    }
    [container removeConstraint:self];
}

+ (void)tat_uninstallConstraints:(NSArray *)constraints
{
    for (id constraint in constraints) {
        NSCParameterAssert([constraint isKindOfClass:[NSLayoutConstraint class]]);
        [constraint tat_uninstall];
    }
}

@end
