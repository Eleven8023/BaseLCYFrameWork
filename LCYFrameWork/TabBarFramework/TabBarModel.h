//
//  TabBarModel.h
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@class TabBarItemModel;
@protocol TabBarItemModel <NSObject>
@end

@interface TabBarItemModel : JSONModel
@property (copy, nonatomic)NSString *uiviewControllName;
@property (copy, nonatomic)NSString *unselectedIconName;
@property (copy, nonatomic)NSString *selectedIconName;
@end

@interface TabBarModel : JSONModel
@property (assign, nonatomic)NSUInteger selectIndex;
@property (strong, nonatomic)NSArray<TabBarItemModel> *tabBarItems;
@property (copy, nonatomic)NSString *color;
@property (copy, nonatomic)NSString <Optional>*title;
@property (assign, nonatomic)NSInteger height;
@property (copy, nonatomic)NSString <Optional>*style;
@end
