//
//  WZF-CommentHeaderView.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/12/2.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF-CommentHeaderView.h"

@implementation WZF_CommentHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithReuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    设置组头字体
    self.textLabel.font=[UIFont systemFontOfSize:15];
//    设置label的x
    self.textLabel.wzf_x=Margin*0.5;
//
    self.textLabel.textColor=[UIColor whiteColor];
    
}

@end
