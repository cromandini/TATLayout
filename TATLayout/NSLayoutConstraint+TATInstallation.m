//
//  NSLayoutConstraint+TATInstallation.m
//  TATLayout
//

#import "NSLayoutConstraint+TATInstallation.h"
#import "NSLayoutConstraint+TATFactory.h"
#import "UIView+TATHierarchy.h"

static NSString * const TATInstallationErrorClosestAncestorSharedByItemsNotFound = @"Unable to install constraint: %@\nCannot find the closest ancestor shared by the views participating. Please ensure the following views are part of the same view hierarchy before attempting to install the constraint:\n%@\n%@";

@implementation NSLayoutConstraint (TATInstallation)

#pragma mark - Installing Constraints

- (void)tat_install
{
    UIView *closestAncestor = [self tat_closestAncestorSharedByItems];
    if (!closestAncestor) {
        NSString *reason = [NSString stringWithFormat:TATInstallationErrorClosestAncestorSharedByItemsNotFound,
                            self, self.firstItem, self.secondItem];
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
    }
    [closestAncestor addConstraint:self];
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
    return nil;
}

#pragma mark - Uninstalling Constraints

- (void)tat_uninstall
{
    UIView *closestAncestor = [self tat_closestAncestorSharedByItems];
    [closestAncestor removeConstraint:self];
}

+ (void)tat_uninstallConstraints:(NSArray *)constraints
{
    for (id constraint in constraints) {
        NSCParameterAssert([constraint isKindOfClass:[NSLayoutConstraint class]]);
        [(NSLayoutConstraint *)constraint tat_uninstall];
    }
}

#pragma mark - Private

/**
 The receiver's first view.
 @return The first object participating in the constraint casted to `UIView`.
 */
- (UIView *)tat_firstView
{
    return self.firstItem;
}

/**
 The receiver's second view.
 @return The second object participating in the constraint casted to `UIView` or `nil` if there’s no such object.
 */
- (UIView *)tat_secondView
{
    return self.secondItem;
}

/**
 The closest ancestor shared by the views participating.
 @return The closest ancestor or `nil` if there’s no such object. Returns the first view if there's only one view participating.
 */
- (UIView *)tat_closestAncestorSharedByItems
{
    if (!self.secondItem) {
        return [self tat_firstView];
    }
    return [self.tat_firstView tat_closestAncestorSharedWithView:self.tat_secondView];
}

@end
