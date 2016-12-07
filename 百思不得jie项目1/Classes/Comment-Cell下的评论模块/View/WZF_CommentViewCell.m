//
//  WZF_CommentViewCell.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/12/2.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_CommentViewCell.h"
#import <UIImageView+WebCache.h>
#import "WZF_commentModel.h"
#import "WZF_userModel.h"
@interface WZF_CommentViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countenLabel;

@property (weak, nonatomic) IBOutlet UIButton *VoiceButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end
@implementation WZF_CommentViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}
-(void)setModel:(WZF_commentModel *)model
{
    _model=model;
    //设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:model.user.profile_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.profileImageView.image=[image circleImage];

    }];
    //设置名字
    self.usernameLabel.text=model.user.username;
//    设置性别
    NSString *sexImageName = [model.user.sex isEqualToString:@"m"] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexView.image=[UIImage imageNamed:sexImageName];
//    设置内容
    self.countenLabel.text=model.content;
    
    if (model.voiceuri.length) {
        self.VoiceButton.hidden = NO;
        [self.VoiceButton setTitle:[NSString stringWithFormat:@"%zd''", model.voicetime] forState:UIControlStateNormal];
    } else {
        self.VoiceButton.hidden = YES;
    }
    self.likeCountLabel.text=[NSString stringWithFormat:@"%ld",(long)self.model.like_count];


    
    

}
@end
