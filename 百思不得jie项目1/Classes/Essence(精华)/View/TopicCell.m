//
//  TopicCell.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/26.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "TopicCell.h"
#import <UIImageView+WebCache.h>
#import "WZF_commentModel.h"
#import "WZF_userModel.h"
#import "WZF_TopPictureView.h"
#import "WZF_TopVoiceView.h"
#import "WZF_TopicVideoView.h"


@interface TopicCell()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *created_atLabel;

@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
//热门相关
@property (weak, nonatomic) IBOutlet UIView *TopCmtView;
@property (weak, nonatomic) IBOutlet UILabel *TopCmtContentLabel;
@property(nonatomic,weak)WZF_TopPictureView*picutureView;
@property(nonatomic,weak)WZF_TopVoiceView*VoidceView;
@property(nonatomic,weak)WZF_TopicVideoView*VideoView;

@end
@implementation TopicCell


+(instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;

}
-(WZF_TopPictureView *)picutureView
{
    if (_picutureView==nil) {
        WZF_TopPictureView*picutureView=[WZF_TopPictureView picture];
        [self.contentView addSubview:picutureView];
        _picutureView=picutureView;
    }
    return _picutureView;
}
-(WZF_TopVoiceView *)VoidceView
{
    if (_VoidceView==nil) {
        WZF_TopVoiceView*VoidceView=[WZF_TopVoiceView voiceView];
        [self.contentView addSubview:VoidceView];
        _VoidceView=VoidceView;
    }
    return _VoidceView;
}
-(WZF_TopicVideoView *)VideoView
{
    if (_VideoView==nil) {
        WZF_TopicVideoView*VideoView=[WZF_TopicVideoView videoView];
        [self.contentView addSubview:VideoView];
        _VideoView=VideoView;
    }
    return _VideoView;
}

- (IBAction)More:(id)sender {
    
    UIAlertController*controller=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil]];
      [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:nil]];
      [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}



-(void)setModel:(ALLModel *)model
{
    _model=model;
//    设置头像方法1
//    [self.profile_imageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon" ]];
    //--------圆图设置
//    [self.profile_imageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:nil options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
////        //开启图形上下文对象
////        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
////        //描述裁剪区域
////        UIBezierPath*path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
////        //设置裁剪区域
////        [path addClip];
////        //画图片
////        [image drawAtPoint:CGPointZero];
////        //取图片
////        image=UIGraphicsGetImageFromCurrentImageContext();
////        //关闭图形上下文
////        UIGraphicsEndPDFContext();
////        self.profile_imageView.image=image;
//        
//        //*---------------------------*//
//        //--同过类扩展  实现联动
//        self.profile_imageView.image=[image circleImage];
//        
//    }];
    //设置头像  ----优化
    [self.profile_imageView setHeader:model.profile_image];
    
    
    
    self.nameLabel.text=model.name;
    self.created_atLabel.text=model.created_at;
    self.text_label.text=model.text;
//    if (model.ding>=10000) {
//        [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",model.ding/10000.0] forState:UIControlStateNormal];
//    }else if(model.ding>0)
//    {
//    [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",model.ding] forState:UIControlStateNormal];
//    }else
//    
//    [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",model.ding] forState:UIControlStateNormal];
//    [self.caiButton setTitle:[NSString stringWithFormat:@"%zd",model.cai] forState:UIControlStateNormal];
//    [self.repostButton setTitle:[NSString stringWithFormat:@"%zd",model.repost] forState:UIControlStateNormal];
//    [self.commentButton setTitle:[NSString stringWithFormat:@"%zd",model.comment] forState:UIControlStateNormal];
    [self setNumber:model.ding andBtn:self.dingButton other:@"顶"];
   [self setNumber:model.cai andBtn:self.caiButton other:@"踩"];
    [self setNumber:model.repost andBtn:self.repostButton other:@"转发"];
    [self setNumber:model.comment andBtn:self.commentButton other:@"评论"];

//    判断热门评论是否有数值
    if (model.top_cmt.count) {
        self.TopCmtView.hidden=NO;
        //面向字典开发- - - -不好
//        NSDictionary*dict=model.top_cmt.lastObject;
//        NSString*user=dict[@"user"][@"username"];
//        NSString*content=dict[@"content"];
//        self.TopCmtContentLabel.text=[NSString stringWithFormat:@"%@ :%@",user,content];
        
        //面向模型开发
               WZF_commentModel*W_model=model.top_cmt.lastObject;

                NSString*user=W_model.user.username;
                NSString*content=W_model.content;
        NSLog(@"%@:%@",user,content);
                self.TopCmtContentLabel.text=[NSString stringWithFormat:@"%@:%@",user,content];
        
    }else
    {
        self.TopCmtView.hidden=YES;

    }
    //判断帖子类型 = =  帖子类型还可以确定cell的排布
    if (model.type==WZF_TopicTypeWord) {
        self.VoidceView.hidden=YES;
        self.picutureView.hidden=YES;
        self.VideoView.hidden=YES;
    }else if(model.type==WZF_TopicTypeVideo)//视频
    {   self.VideoView.hidden=NO;
        self.VideoView.frame=model.contentF;
        self.VideoView.model=model;
        self.VoidceView.hidden=YES;
        self.picutureView.hidden=YES;
        
    }else if (model.type==WZF_TopicTypeVoice)//声音
    {
        self.VoidceView.hidden=NO;
        self.VoidceView.frame=model.contentF;

        self.VoidceView.model=model;
        self.VideoView.hidden=YES;
        self.picutureView.hidden=YES;
        
    }else if(model.type==WZF_TopicTypePicture)//图片
    {
        self.picutureView.hidden=NO;
        self.picutureView.frame=model.contentF;

        self.picutureView.model=model;
        self.VoidceView.hidden=YES;
        self.VideoView.hidden=YES;
    }


    
}

//提取出方法 放地下四个按钮
-(void)setNumber:(NSInteger)number andBtn:(UIButton*)btn other:(NSString*)placeholder
{
    if (number>=10000) {
        [btn setTitle:[NSString stringWithFormat:@"%.1f万",number/10000.0] forState:UIControlStateNormal];
    }else if(number>0)
    {
        [btn setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else
        [btn setTitle:placeholder forState:UIControlStateNormal];

}






-(void)setFrame:(CGRect)frame
{
    frame.origin.y+=10;
    frame.size.height-=10;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
