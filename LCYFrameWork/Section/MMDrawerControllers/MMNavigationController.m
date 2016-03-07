//
//  MMNavigationController.m
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import "MMNavigationController.h"
#import "UIViewController+MMDrawerController.h"
@interface MMNavigationController ()

@end

@implementation MMNavigationController


- (UIStatusBarStyle)preferredStatusBarStyle{
    if (self.mm_drawerController.showsStatusBarBackgroundView) {
        return UIStatusBarStyleLightContent;
    }else{
        return UIStatusBarStyleDefault;
    }
}

@end
