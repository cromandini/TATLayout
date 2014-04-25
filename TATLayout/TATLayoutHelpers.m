//
//  TATLayoutHelpers.m
//  TATLayout
//

#import "TATLayoutHelpers.h"

/**
 Sets `translatesAutoresizingMaskIntoConstraints = NO` in a given view.
 @param view The view to set `translatesAutoresizingMaskIntoConstraints` to `NO`.
 */
static void TATDisableAutoresizingConstraintsInView(id view) {
    if ([view isKindOfClass:[UIView class]]) {
        ((UIView *)view).translatesAutoresizingMaskIntoConstraints = NO;
    }
}

void TATDisableAutoresizingConstraintsInNilTerminatedViews(id firstView, ...) {
    if (firstView) {
        TATDisableAutoresizingConstraintsInView(firstView);
        id nextView;
        va_list argumentList;
        va_start(argumentList, firstView);
        while ((nextView = va_arg(argumentList, id))) {
            TATDisableAutoresizingConstraintsInView(nextView);
        }
        va_end(argumentList);
    }
}
