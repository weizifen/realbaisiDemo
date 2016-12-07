//
//  TopicCell.h
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/26.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALLModel.h"
@interface TopicCell : UITableViewCell

@property(nonatomic,strong)ALLModel*model;
+(instancetype)viewFromXib;
@end
