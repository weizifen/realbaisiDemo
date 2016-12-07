//
//  WZF_TopicVideoView.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/28.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_TopicVideoView.h"
#import <UIImageView+WebCache.h>
#import "ALLModel.h"
#import "PlayerVideoViewController.h"
@interface WZF_TopicVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *time;
@end
@implementation WZF_TopicVideoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)videoView
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
    
}



-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    //
       self.imageView.userInteractionEnabled=YES;
    [self.imageView addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigP)]];


}
-(void)seeBigP{
    PlayerVideoViewController*vc=[[PlayerVideoViewController alloc]init];
    vc.model=self.model;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    
    
}

-(void)setModel:(ALLModel *)model
{
    //获取点击次数
    self.count.text=[NSString stringWithFormat:@"%zd",model.playcount];
    //    获取时间
    NSInteger minute=model.videotime/60;
    NSInteger second=model.videotime%60;
    self.time.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    _model=model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.large_image]] ;
    
    
    
}


@end
