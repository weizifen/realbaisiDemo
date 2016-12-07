//
//  wzfTabBar.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/20.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "wzfTabBar.h"

@interface wzfTabBar ()
@property(nonatomic,strong)UIButton*publishButton;

@end
@implementation wzfTabBar
-(UIButton *)publishButton
{
    if (_publishButton==nil) {
        _publishButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
      
//        _publishButton.backgroundColor=RandomColor;
      
        
    }
    return _publishButton;
}

//通过自定义tabar 从而调整每个item的占位

-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置尺寸
    CGFloat width=self.frame.size.width/5;
    CGFloat height=self.frame.size.height;
    CGFloat y=0;
    //设置索引
    NSInteger index=0;
//    遍历所有子控件
    for (UIView*subView in self.subviews) {
        CGFloat x=width*index;
        //由NSLog(@"%@",subView);可以知道加载的子空间除了uitarbaritem还有UIBarBackground等控件,在这里我们需要做过滤,是uitarbaritem才对他进行配置frame
        if (subView.class !=NSClassFromString(@"UITabBarButton")) continue;
        if (index>1) {
            x=x+width;
            
            subView.frame=CGRectMake(x, y, width, height );

        }else{
        subView.frame=CGRectMake(x, y, width, height );
        }
        
        index++;
        
        
    }
    [self.publishButton addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.publishButton.wzf_x=0;
    self.publishButton.wzf_y=0;
    self.publishButton.wzf_width=self.wzf_width/5;
    self.publishButton.wzf_height=self.wzf_height;
    self.publishButton.wzf_centerX=self.wzf_width/2;
    self.publishButton.wzf_centerY=self.wzf_height/2;
    [self addSubview:self.publishButton];
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    }
    return self;
}


-(void)action{
    wzfNSlog;
}

@end
