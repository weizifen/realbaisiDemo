//
//  WZF_TopVoiceView.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/28.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_TopVoiceView.h"
#import "ALLModel.h"
#import <UIImageView+WebCache.h>
@interface WZF_TopVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *count;

@property (weak, nonatomic) IBOutlet UILabel *time;


@end
@implementation WZF_TopVoiceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)voiceView
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

-(void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
}

-(void)setModel:(ALLModel *)model
{
    _model=model;
    //获取点击次数
    self.count.text=[NSString stringWithFormat:@"%zd",model.playcount];
//    获取时间
    NSInteger minute=model.voicetime/60;
    NSInteger second=model.voicetime%60;
    self.time.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.large_image]];
    
}
@end
