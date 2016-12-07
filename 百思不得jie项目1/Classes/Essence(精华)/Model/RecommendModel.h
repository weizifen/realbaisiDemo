//
//  RecommendModel.h
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/12/1.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
@end
