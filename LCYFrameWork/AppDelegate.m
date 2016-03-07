//
//  AppDelegate.m
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/5.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MainTabBarViewController.h"
#import "LeftSideDrawerViewController.h"
#import "MMNavigationController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import <QuartzCore/QuartzCore.h>
@interface AppDelegate ()
@property (nonatomic, strong) MMDrawerController *drwawerController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainTabBarViewController *mainTabVC = [[MainTabBarViewController alloc] init];
    LeftSideDrawerViewController *leftVC = [[LeftSideDrawerViewController alloc] init];
    UINavigationController *navigationController = [[MMNavigationController alloc] initWithRootViewController:mainTabVC];
    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationController"];
    UINavigationController *leftNavigationController = [[MMNavigationController alloc] initWithRootViewController:leftVC];
    [leftNavigationController setRestorationIdentifier:@"MMExampleLeftNavigationController"];
    self.drwawerController = [[MMDrawerController alloc] initWithCenterViewController:navigationController leftDrawerViewController:leftNavigationController];
    [self.drwawerController setShowsShadow:NO];
    [self.drwawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drwawerController setMaximumRightDrawerWidth:200.0];
    [self.drwawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drwawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drwawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController, drawerSide, percentVisible);
        }
        
    }];
    self.window.rootViewController = self.drwawerController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder{
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder{
    return YES;
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    NSString *key = [identifierComponents lastObject];
    if ([key isEqualToString:@"MMDrawer"]) {
        return self.window.rootViewController;
    }else if ([key isEqualToString:@"MMExampleCenterNavigationController"]){
        return ((MMDrawerController *)self.window.rootViewController).centerViewController;
    }else if ([key isEqualToString:@"MMExampleLeftNavigationController"]){
        return ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
    }else if ([key isEqualToString:@"MMExampleLeftSideDrawerController"]){
        UIViewController *leftVC = ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
        if ([leftVC isKindOfClass:[UINavigationController class]]) {
            return [(UINavigationController *)leftVC topViewController];
        }else{
            return leftVC;
        }
    }
    return nil;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
