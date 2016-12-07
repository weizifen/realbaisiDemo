//
//  WZF_PullRefresh.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/26.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_PullRefresh.h"

@implementation WZF_PullRefresh

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/** 初始化 */
- (void)prepare
{
    [super prepare];
    //根据数据来决定下拉块隐藏还是显示;
    self.automaticallyHidden=YES;
    
    [self setBackgroundColor:[UIColor whiteColor]];

}

@end
