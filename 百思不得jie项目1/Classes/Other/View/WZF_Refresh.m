//
//  WZF_Refresh.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/26.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_Refresh.h"

@implementation WZF_Refresh

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
    [self setTitle:@"亲!下拉刷新哦😯" forState:MJRefreshStateIdle];
    [self setTitle:@"放开我,啊啊啊" forState:MJRefreshStatePulling];
    [self setTitle:@"拼命加载中,略略略" forState:MJRefreshStateRefreshing];
    //设置颜色
    [self setBackgroundColor:[UIColor whiteColor]];
    
    //设置透明状态,不动则透明
    self.automaticallyChangeAlpha=YES;
    //普通状态中的图片
    NSMutableArray*eatImages=[NSMutableArray array];
    for (NSUInteger i =1; i<=60; i++) {
        UIImage*image=[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd",i]];
        [eatImages addObject:image];
    }
//    即将刷新
    NSMutableArray*refreshingImage=[NSMutableArray array];
    for (NSUInteger i=1; i<=3; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd",i]];
        [refreshingImage addObject:image];
    }
    [self setImages:eatImages forState:MJRefreshStateIdle];
    [self setImages:refreshingImage forState:MJRefreshStatePulling];
    


}
@end
