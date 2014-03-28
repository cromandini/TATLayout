//
//  TATLayoutManager.m
//  TATLayout
//

#import "TATLayoutManager.h"
#import "NSLayoutConstraint+TATConstraintData.h"
#import "NSLayoutConstraint+TATConstraintFactory.h"
#import "NSLayoutConstraint+TATConstraintInstall.h"

NSArray *TATLayoutManagerArrayWithVisualFormatAndOptions(NSString *visualFormat, NSLayoutFormatOptions formatOptions) {
    NSCParameterAssert(visualFormat);
    return @[visualFormat, @(formatOptions)];
}

@interface TATLayoutManager ()
@property (nonatomic, readwrite, getter=isActive) BOOL active;
@property (strong, nonatomic) NSMutableArray *mutableConstraints;
@end

@implementation TATLayoutManager

#pragma mark - Creating a Layout Manager

+ (instancetype)layoutManager
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        _active = YES;
    }
    return self;
}

#pragma mark - Activating and Deactivating the Layout Manager

- (void)activate
{
    self.active = YES;
}

- (void)deactivate
{
    self.active = NO;
}

#pragma mark - Constraining Layout Attributes

+ (NSLayoutConstraint *)constrainUsingEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:format metrics:metrics views:views];
    [constraint tat_install];
    return constraint;
}

+ (NSArray *)constrainUsingVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:views];
    [constraints makeObjectsPerformSelector:@selector(tat_install)];
    return constraints;
}

- (void)constrainUsingEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    [self constrainUsingEquationFormat:format metrics:metrics views:views named:nil];
}

- (void)constrainUsingEquationFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views named:(NSString *)name
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint tat_constraintWithEquationFormat:format metrics:metrics views:views];
    if (self.isActive) {
        [constraint tat_install];
    }
    [self.mutableConstraints addObject:constraint];
    constraint.tat_name = name;
}

- (void)constrainUsingVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    [self constrainUsingVisualFormat:format options:options metrics:metrics views:views named:nil];
}

- (void)constrainUsingVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views named:(NSString *)name
{
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:views];
    for (NSLayoutConstraint *constraint in constraints) {
        if (self.isActive) {
            [constraint tat_install];
        }
        constraint.tat_name = name;
    }
    [self.mutableConstraints addObjectsFromArray:constraints];
}

#pragma mark - Adding Constraints

- (void)addConstraintsWithMixedFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
//    [self addConstraintsWithMixedFormats:formats metrics:metrics views:views named:nil];
}

- (void)addConstraintsWithMixedFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views named:(NSString *)name
{
//    NSMutableArray *constraints = [NSMutableArray new];
//    NSString *format;
//    for (id item in formats) {
//        if ([item isKindOfClass:[NSString class]]) {
//            // equation format
//            format = item;
//            [constraints addObject:[NSLayoutConstraint tat_constraintWithEquationFormat:format metrics:metrics views:views]];
//        } else if ([item isKindOfClass:[NSArray class]]) {
//            // visual format
//            format = item[0];
//            NSLayoutFormatOptions options = [item[1] unsignedIntegerValue];
//            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:views]];
//        } else {
//            @throw [NSException exceptionWithName:@"some" reason:@"some" userInfo:nil];
//        }
//    }
//    [self addConstraints:constraints named:name];
}

#pragma mark - Removing Constraints

- (NSArray *)removeAllConstraints
{
    return nil;
}

- (NSArray *)removeConstraints:(NSArray *)constraints
{
    return nil;
}

- (NSArray *)removeConstraintsNamed:(NSString *)name
{
    return nil;
}

#pragma mark - Retrieving Constraints

- (NSMutableArray *)mutableConstraints
{
    if (!_mutableConstraints) {
        _mutableConstraints = [NSMutableArray new];
    }
    return _mutableConstraints;
}

- (NSArray *)constraints
{
    return [self.mutableConstraints copy];
}

- (NSLayoutConstraint *)constraintNamed:(NSString *)name
{
    NSUInteger index = [self.mutableConstraints indexOfObjectPassingTest:^BOOL(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        return [constraint.tat_name isEqualToString:name];
    }];
    if (index != NSNotFound) {
        return self.mutableConstraints[index];
    }
    return nil;
}

- (NSArray *)constraintsNamed:(NSString *)name
{
    return [self.mutableConstraints filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"tat_name == %@", name]];
}

@end
