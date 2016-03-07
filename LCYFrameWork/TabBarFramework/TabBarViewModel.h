//
//  TabBarViewModel.h
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabBarViewModel : NSObject
@property (strong, nonatomic, readonly) NSArray *barItemViewModels;
@property (assign, nonatomic) NSUInteger currentIndex;
@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSString *style;
@property (copy, nonatomic) NSString *color;
@property (assign, nonatomic) NSInteger height;

/**
 * @brief 选择控制器
 */
- (void)selectItem:(NSUInteger )index;
@end
