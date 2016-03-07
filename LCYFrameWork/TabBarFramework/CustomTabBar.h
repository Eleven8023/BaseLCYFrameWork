//
//  CustomTabBar.h
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBar : UIView
- (instancetype)initWithTabViewModel:(TabBarViewModel *)tabViewModel;
- (instancetype)init __unavailable;
- (instancetype)initWithFrame:(CGRect)frame __unavailable;
@end
