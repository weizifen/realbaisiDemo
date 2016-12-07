//
//  RecommendCell.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/12/1.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "RecommendCell.h"
#import <UIImageView+WebCache.h>
@interface RecommendCell()
/** 图片 */

@property (weak, nonatomic) IBOutlet UIImageView *image_list;

/** 订阅数 */
@property (weak, nonatomic) IBOutlet UILabel *sub_number;
/**主题 */
@property (weak, nonatomic) IBOutlet UILabel *theme_name;

@end
@implementation RecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(RecommendModel *)model
{
    _model=model;
//    [self.image_list sd_setImageWithURL:[NSURL URLWithString:model.image_list] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        //修剪圆角
//        self.image_list.image=[image circleImage];
//    }];
    
    [self.image_list setHeader:model.image_list];
    
    
    //订阅人数
    self.theme_name.text=model.theme_name;
    if (model.sub_number >= 10000) {
        self.sub_number.text = [NSString stringWithFormat:@"%.1f万人订阅", model.sub_number / 10000.0];
    } else {
        self.sub_number.text = [NSString stringWithFormat:@"%zd人订阅", model.sub_number];
    }

    
    
}


//为cell从新赋值高度
-(void)setFrame:(CGRect)frame
{
    frame.size.height-=1;
    [super setFrame:frame];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
