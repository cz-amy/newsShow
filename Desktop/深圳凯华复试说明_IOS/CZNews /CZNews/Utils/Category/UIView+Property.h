//
//  UIView+Property.h
//  TapShow
//
//  Created by XQSoft Game on 2017/7/18.
//  Copyright © 2017年 Richard. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
@interface UIView (Property)
//定义的属性，根据自身属性而来，也不是自定义属性，如果纯粹的自定义属性，就要用runtime来关联了
@property (readonly) CGFloat x;
@property (readonly) CGFloat y;
@property (readonly) CGFloat maxX;
@property (readonly) CGFloat maxY;
@property CGFloat width;
@property CGFloat height;
@property CGFloat top;
@property CGFloat bottom;
@end
