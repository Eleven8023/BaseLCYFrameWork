//
//  BarItemViewModel.h
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BarItemViewModel : NSObject
@property (copy, nonatomic, readonly) NSString *unselectIcon;
@property (copy, nonatomic, readonly) NSString *selectedIcon;
@property (copy, nonatomic, readonly) NSString *uiviewControllName;

- (instancetype)initWithUnselectIcon:(NSString *)unselect
                        selectedIcon:(NSString *)selected
                    uiviewController:(NSString *)uiviewController;


@end
