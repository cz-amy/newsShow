//
//  UIView+Property.m
//  TapShow
//
//  Created by XQSoft Game on 2017/7/18.
//  Copyright © 2017年 Richard. All rights reserved.
//

#import "UIView+Property.h"


CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

@implementation UIView (Property)
-(CGFloat)x{
    
    return self.frame.origin.x;
}
-(CGFloat)y{
    return self.frame.origin.y;
    
}

-(CGFloat)maxX{
    
    return self.frame.origin.x+self.frame.size.width;
}
-(CGFloat)maxY{
    return self.frame.origin.y+self.frame.size.height;
}

- (void) setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

-(CGFloat)width{
    return self.frame.size.width;
}

- (void) setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

-(CGFloat)height{
    
   return  self.frame.size.height;
}

@end
