//
//  WZF_TopPictureView.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/28.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_TopPictureView.h"
#import <UIImageView+WebCache.h>
#import "ALLModel.h"
#import <CircleProgressBar.h>
#import "WZF_SeeBigPictureViewController.h"
@interface WZF_TopPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet CircleProgressBar *progress;

@end
@implementation WZF_TopPictureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)picture
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    // 从xib中加载进来的控件的autoresizingMask默认是UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
    self.autoresizingMask=UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled=YES;
    [self.imageView addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigP)]];

    
}

-(void)seeBigP
{
    WZF_SeeBigPictureViewController*see=[[WZF_SeeBigPictureViewController alloc]init];
    see.model=self.model;
//    [self.window.rootViewController presentViewController:see animated:YES completion:nil];//这句会报未知错误,但是也能用
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:see animated:YES completion:0];
    
}

-(void)setModel:(ALLModel *)model
{
    _model=model;
    [self.imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:model.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progress.hidden=NO;
        CGFloat baifenbi=1.0*receivedSize/expectedSize;
        self.progress.progressBarProgressColor=[UIColor blueColor];
        [self.progress setProgress:baifenbi animated:YES];
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progress.hidden=YES;
    }];
    if ([model.large_image.pathExtension.lowercaseString isEqualToString:@"gif"]) {
        self.gifView.hidden=YES;
    }else
    {
        self.gifView.hidden=YES;
    }
    if (model.isBigPicture) {
        self.seeBigButton.hidden=NO;
        self.imageView.contentMode=UIViewContentModeTop;
        self.imageView.clipsToBounds=YES;///=====什么.?? 裁剪??
    }else
    {
        self.seeBigButton.hidden=YES;
        self.imageView.contentMode=UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds=NO;
    }
    
}

@end
