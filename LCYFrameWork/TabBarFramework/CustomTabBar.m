//
//  CustomTabBar.m
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//
#import "TabBarViewModel.h"
#import "CustomTabBar.h"
#import <Masonry/Masonry.h>
#import "BarItemViewModel.h"
#import "TabBarViewModel.h"
#import "UIColor+Hex.h"
#define KIndexCount 10
@implementation CustomTabBar{
    TabBarViewModel *_tabBarViewModel;
}

- (instancetype)initWithTabViewModel:(TabBarViewModel *)tabViewModel
{
    self = [super init];
    if (self) {
        _tabBarViewModel = tabViewModel;
        self.backgroundColor = [UIColor_Hex colorWithHexString:tabViewModel.color alpha:1];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    // 添加毛玻璃效果
    if ([_tabBarViewModel.style isEqualToString:@"UIVisualEffectView"]) {
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEffectView.frame = self.bounds;
        visualEffectView.alpha = 1.0;
        [self addSubview:visualEffectView];
    }
    for (NSInteger i = 0; i < _tabBarViewModel.barItemViewModels.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        BarItemViewModel *barItemViewModel = _tabBarViewModel.barItemViewModels[i];
        [button setImage:[UIImage imageNamed:barItemViewModel.unselectIcon] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:barItemViewModel.selectedIcon] forState:UIControlStateSelected];
        button.tag = i + KIndexCount;
        [button addTarget:self action:@selector(customButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.masksToBounds = YES;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset([UIScreen mainScreen].bounds.size.width /  _tabBarViewModel.barItemViewModels.count * i+ (([UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width /  _tabBarViewModel.barItemViewModels.count * ( _tabBarViewModel.barItemViewModels.count - 1) - 50) / 2));
            make.height.equalTo(@50);
            make.width.equalTo(@50);
        }];
    }
    [self customButtonAction:(UIButton *)[self viewWithTag:_tabBarViewModel.currentIndex + KIndexCount]];
}

- (void)customButtonAction:(UIButton *)button
{
    UIButton *btn = (UIButton *)[self viewWithTag:_tabBarViewModel.currentIndex + KIndexCount];
    btn.selected = NO;
    button.selected = YES;
    [self selectedItem:button.tag - KIndexCount];
}

- (void)selectedItem:(NSInteger)index
{
    [_tabBarViewModel selectItem:index];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
