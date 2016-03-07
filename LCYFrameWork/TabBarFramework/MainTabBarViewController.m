//
//  MainTabBarViewController.m
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/5.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import "MainTabBarViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "TabBarViewModel.h"
#import "BarItemViewModel.h"
#import "CustomTabBar.h"
#import <Masonry/Masonry.h>
@interface MainTabBarViewController ()
@property (strong, nonatomic) TabBarViewModel *viewModel;
@property (strong, nonatomic) CustomTabBar *customTabBar;
@end

@implementation MainTabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _viewModel = [[TabBarViewModel alloc] init];
        NSMutableArray *viewControllerArray = [[NSMutableArray alloc] initWithCapacity:_viewModel.barItemViewModels.count];
        for (BarItemViewModel *item in self.viewModel.barItemViewModels) {
            Class class = NSClassFromString(item.uiviewControllName);
            [viewControllerArray addObject:[[class alloc] init]];
        }
        self.viewControllers = viewControllerArray;
        [self.tabBar setHidden:TRUE];
        [self layOutSubView];
        self.selectedIndex = self.viewModel.currentIndex;
        RAC(self, selectedIndex ) = RACObserve(self.viewModel, currentIndex);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark Layout
- (void)layOutSubView{
    self.customTabBar = [[CustomTabBar alloc] initWithTabViewModel:self.viewModel];
    // 实现模糊效果
    [self.view addSubview:self.customTabBar];
    NSLog(@"dada %ld ", self.viewModel.height);
    [self.customTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(self.view.frame.size.height - self.viewModel.height);
    }];
}

#pragma mark Private
- (void)selectedItem:(id)notification{
    UIButton *button = (UIButton *)[notification object];
    [self.viewModel selectItem:button.tag];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
