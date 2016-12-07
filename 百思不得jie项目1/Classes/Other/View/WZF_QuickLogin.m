//
//  WZF_QuickLogin.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/21.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_QuickLogin.h"

@implementation WZF_QuickLogin

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//设置快速登录按钮的布局
-(void)awakeFromNib{
    [super awakeFromNib];
//    self.imageView.backgroundColor=[UIColor blueColor];
//    self.titleLabel.backgroundColor=[UIColor grayColor];
//    self.backgroundColor=[UIColor redColor];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.wzf_y=0;
    self.imageView.wzf_centerX = self.wzf_width * 0.5;
    
    self.titleLabel.wzf_x=0;
    self.titleLabel.wzf_y=CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.wzf_width=self.wzf_width;
    self.titleLabel.wzf_height=self.frame.size.height-self.titleLabel.wzf_y;
}

@end
