//
//  TATLayoutHelper.m
//  TATLayout
//

#import "TATLayoutHelper.h"

/**
 Sets `translatesAutoresizingMaskIntoConstraints = NO` in a given object.
 */
static void TATLayoutSetViewToNotTranslateAutoresizingMaskIntoConstraints(id view);

#pragma mark - Checking the Device Idiom

BOOL TATLayoutDeviceIsPad() {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

BOOL TATLayoutDeviceIsPhone() {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

#pragma mark - Settings views to not translate autoresizing mask into constraints

void TATLayoutSetViewsToNotTranslateAutoresizingMaskIntoConstraints(id firstView, ...) {
    if (firstView) {
        TATLayoutSetViewToNotTranslateAutoresizingMaskIntoConstraints(firstView);
        id nextView;
        va_list argumentList;
        va_start(argumentList, firstView);
        while ((nextView = va_arg(argumentList, id))) {
            TATLayoutSetViewToNotTranslateAutoresizingMaskIntoConstraints(nextView);
        }
        va_end(argumentList);
    }
}

#pragma mark - Private

static void TATLayoutSetViewToNotTranslateAutoresizingMaskIntoConstraints(id view) {
    if ([view isKindOfClass:[UIView class]]) {
        ((UIView *)view).translatesAutoresizingMaskIntoConstraints = NO;
    }
}
