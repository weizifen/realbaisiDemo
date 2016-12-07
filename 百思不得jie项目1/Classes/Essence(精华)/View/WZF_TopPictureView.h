//
//  WZF_TopPictureView.h
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/28.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALLModel;
@interface WZF_TopPictureView : UIView

@property(nonatomic,strong)ALLModel*model;
+(instancetype)picture;
@end
