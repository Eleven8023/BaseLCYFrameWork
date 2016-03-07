//
//  TabBarViewModel.m
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import "TabBarViewModel.h"
#import "BarItemViewModel.h"
#import "TabBarModel.h"
#define TABBAR_PLIST_FILENAME @"TabBar"
@implementation TabBarViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:TABBAR_PLIST_FILENAME ofType:@"plist"];
        NSDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NSError *error;
        TabBarModel *barModel = [[TabBarModel alloc] initWithDictionary:dic error:&error];
        _title = barModel.title;
        _currentIndex = barModel.selectIndex;
        _color = barModel.color;
        _style = barModel.style;
        _height = barModel.height;
        NSMutableArray *array = [[NSMutableArray array] init];
        for (TabBarItemModel *tabbarModel in barModel.tabBarItems) {
            BarItemViewModel *itemViewModel = [[BarItemViewModel alloc] initWithUnselectIcon:tabbarModel.unselectedIconName selectedIcon:tabbarModel.selectedIconName uiviewController:tabbarModel.uiviewControllName];
            [array addObject:itemViewModel];
        }
        _barItemViewModels = [NSArray arrayWithArray:array];
    }
    return self;
}

- (void)selectItem:(NSUInteger)index
{
    self.currentIndex = index;
}

@end
