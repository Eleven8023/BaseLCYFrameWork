//
//  MMExampleDrawerVisualStateManager.h
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMDrawerVisualState.h"

typedef NS_ENUM(NSInteger, MMDrawerAnimationType) {
    MMDrawerAnimationTypeNone,
    MMDrawerAnimationTypeSlider,
    MMDrawerAnimationTypeSliderAndScale,
    MMDrawerAnimationTypeSwingingDoor,
    MMDrawerAnimationTypeParallax,
};
@interface MMExampleDrawerVisualStateManager : NSObject

@property (nonatomic, assign) MMDrawerAnimationType leftDrawerAnimationType;
@property (nonatomic, assign) MMDrawerAnimationType rightDrawerAnimationType;

+ (MMExampleDrawerVisualStateManager *)sharedManager;
- (MMDrawerControllerDrawerVisualStateBlock)drawerVisualStateBlockForDrawerSide:(MMDrawerSide)drawerSide;


@end
