//
//  WZF_TableViewCell.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/23.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_TableViewCell.h"

@implementation WZF_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        //设置cell内侧右边效果
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        //设置cell背景颜色
         self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}
-(void)layoutSubviews
{   [super layoutSubviews];
    if (self.imageView.image==nil) {
        return;
    }
    self.imageView.wzf_y=smallMargin;
    self.imageView.wzf_height=self.contentView.wzf_height-2*smallMargin;
    self.imageView.wzf_width=self.imageView.wzf_height;
    
    self.textLabel.wzf_x=self.imageView.wzf_x+self.imageView.wzf_width+Margin;
    
    
    
}
@end
