//
//  TATLayoutHelper.m
//  TATLayout
//

#import "TATLayoutHelper.h"

/**
 Sets `translatesAutoresizingMaskIntoConstraints = NO` in a given view.
 @param view The view to set `translatesAutoresizingMaskIntoConstraints` to `NO`.
 */
static void TATDisableAutoresizingConstraintsInObject(id object) {
    if ([object isKindOfClass:[UIView class]]) {
        UIView *view = object;
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
}

void TATDisableAutoresizingConstraintsInNilTerminatedViews(id firstView, ...) {
    if (firstView) {
        TATDisableAutoresizingConstraintsInObject(firstView);
        id nextView;
        va_list argumentList;
        va_start(argumentList, firstView);
        while ((nextView = va_arg(argumentList, id))) {
            TATDisableAutoresizingConstraintsInObject(nextView);
        }
        va_end(argumentList);
    }
}
