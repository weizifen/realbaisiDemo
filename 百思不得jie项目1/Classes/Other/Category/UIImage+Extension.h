//
//  UIImage+Extension.h
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/12/1.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 返回圆形
对圆角裁剪进行封装
 */
- (instancetype)circleImage;

+ (instancetype)circleImage:(NSString *)name;

@end
