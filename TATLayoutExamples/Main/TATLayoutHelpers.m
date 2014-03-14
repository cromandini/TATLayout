//
//  TATLayoutHelpers.m
//  TATLayout
//

#import "TATLayoutHelpers.h"

BOOL TATDeviceIsPad() {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

BOOL TATDeviceIsPhone() {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}
