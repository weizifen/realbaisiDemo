//
//  footView_button.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/24.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "footView_button.h"
#import <UIButton+WebCache.h>
@implementation footView_button

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
//        设置文字居中
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
//        设置文字大小
        self.titleLabel.font=[UIFont systemFontOfSize:15];
//        设置文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
    
    }
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片位置
    self.imageView.wzf_y=self.wzf_height*0.15;
    self.imageView.wzf_height=self.wzf_height*0.5;
    self.imageView.wzf_width=self.imageView.wzf_height;
    self.imageView.wzf_centerX=self.wzf_width*0.5;
    
    //设置文字位置
    self.titleLabel.wzf_x=0;
    self.titleLabel.wzf_y=CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.wzf_width=self.wzf_width;
    self.titleLabel.wzf_height=self.wzf_height-self.imageView.wzf_height;

}

-(void)setSquares:(WZF_MeModel *)squares
{
    _squares=squares;
    [self setTitle:squares.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:squares.icon] forState:UIControlStateNormal];
}

@end
