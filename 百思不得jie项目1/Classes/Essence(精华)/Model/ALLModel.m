//
//  ALLModel.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/26.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "ALLModel.h"
#import <MJExtension.h>
#import "WZF_commentModel.h"
#import "WZF_userModel.h"
@implementation ALLModel

//告诉我们数组中装的是什么对象类型
+(NSDictionary *)mj_objectClassInArray
{
    //告诉top_cmt数组   里面装的是[WZF_commentModel class](对象类型)
    return @{@"top_cmt":[WZF_commentModel class]};
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"top_cmt" : @"top_cmt[0]",
             @"small_image" : @"image0",
             @"middle_image" : @"image2",
             @"large_image" : @"image1",
             @"ID":@"id"
             };
}


#pragma mark  ---艰辛无比的设置对比日期
-(NSString*)created_at
{
    
//    // 时间字符串
//    NSString *string = @"2015-11-20 09:33:22";
//    
//    // 日期格式化类
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    // 设置日期格式(为了转换成功)
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString*created=_created_at;
//    NSLog(@"%@",_created_at);
    NSDateFormatter*fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSDate*date=[fmt dateFromString:created];
    NSDate*currentdate=[NSDate date];//有值
    NSCalendar*calendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
   NSDateComponents*cmps= [calendar components:unit fromDate:date toDate:currentdate options:0];
   
    cmps.year=0;
    
    if (cmps.year==0) {
        if ([calendar isDateInToday:date]) {//如果帖子是今天的

            if (cmps.hour>1) {//如果帖子是几小时前
                
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];

                
            }
            else if (cmps.minute>1)
            {//如果帖子是几分钟前的
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
                
            }else
            {
                //如果帖子是一分钟内的
                return @"刚刚";

            }
        }
       else if(cmps.day==1)
       {
           fmt.dateFormat = @"昨天 HH:mm:ss";
           
           return [fmt stringFromDate:date];

       }
       else{
           fmt.dateFormat = @"MM-dd HH:mm:ss";
           
           return [fmt stringFromDate:date];
       }
    }
    else{
        // 非今年
        return _created_at;

    }

}
-(CGFloat)cellHeight
{
    //1头像图片高度
    _cellHeight=55;
    
    //文字高度
    
    CGFloat textWidth=[UIScreen mainScreen].bounds.size.width-2*Margin;
    CGSize textMAXSize=CGSizeMake(textWidth, MAXFLOAT);
    //获取文字宽高
    CGSize textSize=[self.text boundingRectWithSize:textMAXSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    //2获取文字的高度
    _cellHeight+=textSize.height+Margin;
    //获取中间东西的高度
    if (self.type!=WZF_TopicTypeWord) {//如果中间不是文字加上去
        //中间图片宽高计算 355(屏幕宽度)  宽(真实)
                        // 求高度      高(真实)
        CGFloat contentH=textWidth*self.height/self.width;
        if (contentH>[UIScreen mainScreen].bounds.size.height) {
             contentH=200;
            self.bigPicture=YES;
        }
        CGRect contentF=CGRectMake(Margin, _cellHeight, textWidth, contentH);
        self.contentF=contentF;
        _cellHeight+=contentH+Margin;
        
    }
    //热门评论高度--标题
    _cellHeight+=20;
    //热门评论高度--内容
    
    if (self.top_cmt.count) {
       NSString *topCmtContent = [NSString stringWithFormat:@"%@:%@",self.top_cmt[0].user.username,self.top_cmt[0].content];
        NSLog(@"%@",topCmtContent);
        CGSize topSize=[topCmtContent boundingRectWithSize:textMAXSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        
        
        _cellHeight+=topSize.height+Margin;
       
        
    }
    _cellHeight+=35+Margin+30;
    
    return _cellHeight;
    
    
}

@end
