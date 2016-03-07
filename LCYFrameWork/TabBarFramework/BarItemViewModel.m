//
//  BarItemViewModel.m
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import "BarItemViewModel.h"

@implementation BarItemViewModel

- (instancetype)initWithUnselectIcon:(NSString *)unselect selectedIcon:(NSString *)selected uiviewController:(NSString *)uiviewController
{
    self = [super init];
    if (self) {
        _selectedIcon = selected;
        _unselectIcon = unselect;
        _uiviewControllName = uiviewController;
    }
    return self;
}

@end
