//
//  CYTabBarConfig.m
//  CYTabBarDemo
//
//  Created by 张 春雨 on 2017/5/5.
//  Copyright © 2017年 张春雨. All rights reserved.
//

#import "CYTabBarConfig.h"

@implementation CYTabBarConfig
+ (instancetype)shared{
    static CYTabBarConfig *config = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        config = [[CYTabBarConfig alloc]init];
        //设置文字颜色
        config.textColor = [UIColor colorWithRed:113/255.0 green:109/255.0 blue:104/255.0 alpha:1];

        //设置文字选中颜色
        config.selectedTextColor = config.textColor;
        
        //背景颜色
        config.backgroundColor = [UIColor colorWithRed:254/255.0 green:254/255.0 blue:254/255.0 alpha:1];
        
        //指定的初始化控制器(<0时为默认)
        config.selectIndex = -1;
        
        //是否存在bar底部分割线
        config.haveBorder = YES;
        
        //bar的底部分割线颜色
        config.bordergColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        
        //bar底部分割线的高度
        config.borderHeight = 1.0;
    });
    return config;
}
@end
