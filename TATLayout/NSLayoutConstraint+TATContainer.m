//
//  NSLayoutConstraint+TATContainer.m
//  TATLayout
//

@import ObjectiveC;
#import "NSLayoutConstraint+TATContainer.h"
#import "UIView+TATHierarchy.h"

@interface TATInstallationWeakAssociator : NSObject
@property (weak, nonatomic) id container;
@end

@implementation TATInstallationWeakAssociator
@end

@implementation NSLayoutConstraint (TATContainer)

- (UIView *)tat_container
{
    TATInstallationWeakAssociator *weakAssociation = objc_getAssociatedObject(self, @selector(tat_container));
    return weakAssociation.container;
}

- (void)setTat_container:(UIView *)container
{
    TATInstallationWeakAssociator *weakAssociator = objc_getAssociatedObject(self, @selector(tat_container));;
    if (!weakAssociator) {
        weakAssociator = [TATInstallationWeakAssociator new];
        objc_setAssociatedObject(self, @selector(tat_container), weakAssociator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    weakAssociator.container = container;
}

- (UIView *)tat_closestAncestorSharedByItems
{
    if (!self.secondItem) {
        return [self tat_firstView];
    }
    return [self.tat_firstView tat_closestAncestorSharedWithView:self.tat_secondView];
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

@end
