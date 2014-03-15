//
//  TATHelpers.m
//  TATLayout
//

#import "TATHelpers.h"

BOOL TATDeviceIsPad() {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

BOOL TATDeviceIsPhone() {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}
