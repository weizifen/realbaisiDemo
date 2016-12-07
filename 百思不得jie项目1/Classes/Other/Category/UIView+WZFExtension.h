//
//  UIView+WZFExtension.h
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/20.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WZFExtension)

@property(nonatomic,assign)CGFloat wzf_width;
@property(nonatomic,assign)CGFloat wzf_height;
@property(nonatomic,assign)CGFloat wzf_x;
@property(nonatomic,assign)CGFloat wzf_y;
@property(nonatomic,assign)CGFloat wzf_centerX;
@property(nonatomic,assign)CGFloat wzf_centerY;
-(BOOL)intersectWithView:(UIView*)view;

//@property(nonatomic,assign)CGFloat wzf_right;
//@property(nonatomic,assign)CGFloat wzf_bottom;


@end
