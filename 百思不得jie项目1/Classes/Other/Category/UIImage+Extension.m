//
//  UIImage+Extension.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/12/1.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "UIImage+Extension.h"
#import <AFNetworking.h>
@implementation UIImage (Extension)
-(instancetype)circleImage
{
    //开启图形上下文对象
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //描述裁剪区域
    UIBezierPath*path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //设置裁剪区域
    [path addClip];
    //画图片
    [self drawAtPoint:CGPointZero];
    //取图片
    UIImage*image=UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndPDFContext();
    
    return image;
}

+ (instancetype)circleImage:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}

@end
