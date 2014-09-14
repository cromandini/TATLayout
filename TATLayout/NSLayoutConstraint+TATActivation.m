//
//  NSLayoutConstraint+TATActivation.m
//  TATLayout
//
//  Created by Claudio Romandini on 9/13/14.
//  Copyright (c) 2014 Claudio Romandini. All rights reserved.
//

#import "NSLayoutConstraint+TATActivation.h"
#import "NSLayoutConstraint+TATContainer.h"
#import "NSLayoutConstraint+TATFactory.h"

static NSString * const TATActivationErrorContainerNotFound = @"Unable to install constraint: %@\nCannot find a common ancestor of the views participating. Please ensure the following views are part of the same view hierarchy before attempting to install the constraint:\n%@\n%@";

@implementation NSLayoutConstraint (TATActivation)

#pragma mark - Activating and Deactivating Constraints

- (BOOL)tat_isActive
{
    if ([self respondsToSelector:@selector(isActive)]) {
        return self.isActive;
    }
    return self.tat_container && [[self.tat_container constraints] containsObject:self];
}

- (void)setTat_active:(BOOL)tat_active
{
    if ([self respondsToSelector:@selector(active)]) {
        self.active = tat_active;
        return;
    }
    if (tat_active) {
        [self tat_activate];
    } else {
        [self tat_deactivate];
    }
}

- (void)tat_activate
{
    UIView *container = self.tat_container;
    if (!container) {
        container = [self tat_closestAncestorSharedByItems];
        if (!container) {
            NSString *reason = [NSString stringWithFormat:TATActivationErrorContainerNotFound, self, self.firstItem, self.secondItem];
            @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
        }
        self.tat_container = container;
    }
    [container addConstraint:self];
}

- (void)tat_deactivate
{
    UIView *container = self.tat_container;
    if (!container) {
        container = [self tat_closestAncestorSharedByItems];
    }
    self.tat_container = nil;
    [container removeConstraint:self];
}

+ (void)tat_activateConstraints:(NSArray *)constraints
{
    if ([self respondsToSelector:@selector(activateConstraints:)]) {
        [self activateConstraints:constraints];
        return;
    }
    for (id constraint in constraints) {
        NSParameterAssert([constraint isKindOfClass:[NSLayoutConstraint class]]);
        [constraint tat_activate];
    }
}

+ (void)tat_deactivateConstraints:(NSArray *)constraints
{
    if ([self respondsToSelector:@selector(deactivateConstraints:)]) {
        [self deactivateConstraints:constraints];
        return;
    }
    for (id constraint in constraints) {
        NSCParameterAssert([constraint isKindOfClass:[NSLayoutConstraint class]]);
        [constraint tat_deactivate];
    }
}

#pragma mark - Creating and Activating Constraints in the Same Operation

+ (NSLayoutConstraint *)tat_activateConstraintWithEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSLayoutConstraint *constraint = [self tat_constraintWithEquationFormat:format metrics:metrics views:views];
    constraint.tat_active = YES;
    return constraint;
}

+ (NSArray *)tat_activateConstraintsWithEquationFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:[formats count]];
    for (id format in formats) {
        NSParameterAssert([format isKindOfClass:[NSString class]]);
        NSLayoutConstraint *constraint = [self tat_activateConstraintWithEquationFormat:format metrics:metrics views:views];
        [constraints addObject:constraint];
    }
    return [constraints copy];
}

+ (NSArray *)tat_activateConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:views];
    [self tat_activateConstraints:constraints];
    return constraints;
}

@end
