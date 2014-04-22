//
//  TATLayoutUtilities.m
//  TATLayout
//

#import "TATLayoutUtilities.h"

#pragma mark - Checking the Device Idiom

BOOL TATLayoutDeviceIsPad() {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

BOOL TATLayoutDeviceIsPhone() {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

#pragma mark - Deactivating the view's autoresizing mask

/**
 Sets `translatesAutoresizingMaskIntoConstraints = NO` in a given view.
 @param view The view to set `translatesAutoresizingMaskIntoConstraints` to `NO`.
 */
static void TATLayoutDeactivateAutoresizingMaskInView(id view) {
    if ([view isKindOfClass:[UIView class]]) {
        ((UIView *)view).translatesAutoresizingMaskIntoConstraints = NO;
    }
}

void TATLayoutDeactivateAutoresizingMaskInNilTerminatedViews(id firstView, ...) {
    if (firstView) {
        TATLayoutDeactivateAutoresizingMaskInView(firstView);
        id nextView;
        va_list argumentList;
        va_start(argumentList, firstView);
        while ((nextView = va_arg(argumentList, id))) {
            TATLayoutDeactivateAutoresizingMaskInView(nextView);
        }
        va_end(argumentList);
    }
}

#pragma mark - Creating arrays containing visual format and options

NSArray *TATLayoutArrayWithVisualFormatAndOptions(NSString *visualFormat, NSLayoutFormatOptions formatOptions) {
    NSCParameterAssert(visualFormat);
    return @[visualFormat, @(formatOptions)];
}
