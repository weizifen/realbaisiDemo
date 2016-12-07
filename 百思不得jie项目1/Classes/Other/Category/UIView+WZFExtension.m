//
//  UIView+WZFExtension.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/20.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "UIView+WZFExtension.h"

@implementation UIView (WZFExtension)

-(CGFloat)wzf_width
{
    return self.frame.size.width;
}
-(void)setWzf_width:(CGFloat)wzf_width
{
    CGRect frame=self.frame;
   frame.size.width=wzf_width;
    self.frame=frame;
}
-(CGFloat)wzf_height
{
    return self.frame.size.height;
}
-(void)setWzf_height:(CGFloat)wzf_height
{
    CGRect frame=self.frame;
    frame.size.height=wzf_height;
    self.frame=frame;
}
-(CGFloat)wzf_x
{
    return self.frame.origin.x;
}
-(void)setWzf_x:(CGFloat)wzf_x
{
    CGRect frame=self.frame;
    frame.origin.x=wzf_x;
    self.frame=frame;
}
-(CGFloat)wzf_y
{
    return self.frame.origin.y;
}
-(void)setWzf_y:(CGFloat)wzf_y
{
    CGRect frame=self.frame;
    frame.origin.y=wzf_y;
    self.frame=frame;
    
}

-(CGFloat)wzf_centerX
{
    
    return self.center.x;
}
-(void)setWzf_centerX:(CGFloat)wzf_centerX
{
    CGPoint center=self.center;
    center.x=wzf_centerX;
    self.center=center;
    
}


-(CGFloat)wzf_centerY
{
    return self.center.y;
}
-(void)setWzf_centerY:(CGFloat)wzf_centerY
{
    CGPoint center=self.center;
    center.y=wzf_centerY;
    self.center=center;
    
}


-(BOOL)intersectWithView:(UIView*)view
{
    //查看scrollview与主窗口是否在同一个窗口上
    UIWindow*windows=[UIApplication sharedApplication].keyWindow;
    CGRect selfRect=[self convertRect:self.bounds toView:windows];
    CGRect viewR=[view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect,viewR);

}


@end
