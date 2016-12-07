//
//  TitleBtn.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/25.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "TitleBtn.h"

@implementation TitleBtn

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
        
        //        设置普通状态颜色和选中状态颜色
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font=[UIFont systemFontOfSize:14];

    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}
@end
