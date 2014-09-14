//
//  NSLayoutConstraint+TATInstallationSpec.m
//  TATLayoutTests
//

#import <Kiwi/Kiwi.h>
#import "NSLayoutConstraint+TATInstallation.h"
#import "NSLayoutConstraint+TATActivation.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

SPEC_BEGIN(NSLayoutConstraint_TATInstallationSpec)

describe(@"Installation Category", ^{
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint new];
    NSLayoutConstraint *c2 = [NSLayoutConstraint new];
    NSArray *constraints = @[c1, c2];
    NSString *format = @"the format";
    NSDictionary *metrics = @{@"the": @"metrics"};
    NSDictionary *views = @{@"the": @"views"};
    NSLayoutFormatOptions options = NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight;
    
    context(@"maps to Activation Category", ^{
        
        describe(@"-tat_install", ^{
            it(@"maps to tat_active=YES", ^{
                [[[c1 should] receive] setTat_active:YES];
                [c1 tat_install];
            });
        });
        
        describe(@"+tat_installConstraints:", ^{
            it(@"maps to tat_activateConstraints:", ^{
                [[[NSLayoutConstraint should] receive] tat_activateConstraints:constraints];
                [NSLayoutConstraint tat_installConstraints:constraints];
            });
        });
        
        describe(@"-tat_uninstall", ^{
            it(@"maps to tat_active=NO", ^{
                [[[c1 should] receive] setTat_active:NO];
                [c1 tat_uninstall];
            });
        });
        
        describe(@"+tat_uninstallConstraints:", ^{
            it(@"maps to tat_deactivateConstraints:", ^{
                [[[NSLayoutConstraint should] receive] tat_deactivateConstraints:constraints];
                [NSLayoutConstraint tat_uninstallConstraints:constraints];
            });
        });
        
        describe(@"+tat_installConstraintWithEquationFormat:metrics:views:", ^{
            it(@"maps to tat_activateConstraintWithEquationFormat:metrics:views:", ^{
                [[[NSLayoutConstraint should] receive] tat_activateConstraintWithEquationFormat:format metrics:metrics views:views];
                [NSLayoutConstraint tat_installConstraintWithEquationFormat:format metrics:metrics views:views];
            });
        });
        
        describe(@"+tat_installConstraintsWithEquationFormats:metrics:views:", ^{
            it(@"maps to tat_activateConstraintsWithEquationFormats:metrics:views:", ^{
                NSArray *formats = @[format, format, format];
                [[[NSLayoutConstraint should] receive] tat_activateConstraintsWithEquationFormats:formats metrics:metrics views:views];
                [NSLayoutConstraint tat_installConstraintsWithEquationFormats:formats metrics:metrics views:views];
            });
        });
        
        describe(@"+tat_installConstraintsWithVisualFormat:options:metrics:views:", ^{
            it(@"maps to tat_activateConstraintsWithVisualFormat:options:metrics:views:", ^{
                [[[NSLayoutConstraint should] receive] tat_activateConstraintsWithVisualFormat:format options:options metrics:metrics views:views];
                [NSLayoutConstraint tat_installConstraintsWithVisualFormat:format options:options metrics:metrics views:views];
            });
        });
    });
});

#pragma clang diagnostic pop

SPEC_END
