//
//  WZF_SettingTableViewCell.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/24.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_SettingTableViewCell.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>
#define WZF_MP3Cache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"MP3"]
@implementation WZF_SettingTableViewCell

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
        self.textLabel.text=@"清理缓存,计算大小中";
        //设置cell右侧显示菊花
        UIActivityIndicatorView*loadView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadView startAnimating];
        self.accessoryView=loadView;
        self.userInteractionEnabled=NO;
       
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //为了看出大小设置停留时间 因为太快了/
            [NSThread sleepForTimeInterval:3];
             unsigned long long size=0;
             size+=WZF_MP3Cache.fileSize;
            size+=[SDImageCache sharedImageCache].getSize;
            NSString*sizeText=nil;
            if (size>pow(10, 9)) {
            
                sizeText=[NSString stringWithFormat:@"%.2fGB",size/pow(10, 9)];
                
            }else if (size>pow(10, 6))
            {
                sizeText=[NSString stringWithFormat:@"%.2fMB",size/pow(10, 6)];

            }
            else if (size>pow(10, 3))
            {
                sizeText=[NSString stringWithFormat:@"%.2fKB",size/pow(10, 3)];
                
            }
            else  {
                sizeText=[NSString stringWithFormat:@"%.2lluB",size];
                
            }
            NSString*text=[NSString stringWithFormat:@"缓存大小%@",sizeText];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textLabel.text=text;
                self.accessoryView=nil;
                self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
               
               
                [self addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clean)]];
                self.userInteractionEnabled=YES;
            });
            
        });
       
        //计算缓存大小

//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            unsigned long long size=0;
//            NSString*path=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//            NSString*subPath=[path stringByAppendingPathComponent:@"MP3"];
//            NSFileManager*manger=[NSFileManager defaultManager];
//            NSArray*arr=[manger contentsOfDirectoryAtPath:subPath error:nil];
//            for (NSString*sun in arr) {
//               
//                NSString*full=[subPath stringByAppendingPathComponent:sun];
//                
//                size+=[manger attributesOfItemAtPath:full error:nil].fileSize;
//                
//                
//            }
////            WZF_MP4File
//       
//            NSLog(@"%zd",size);
//            
//
//            
//        });
        
        
        
    }
    return self;
}
-(void)clean{
    
    if ([self.textLabel.text isEqualToString:@"清理完毕(0B)"]) {
        
       
        //为了看效果设置延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [SVProgressHUD showWithStatus:@"内容清理完毕"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        });
        

    }else{
    
    

        
            [SVProgressHUD showWithStatus:@"正在清理缓存"];

  //        为了看效果设置延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [[SDImageCache sharedImageCache] cleanDiskWithCompletionBlock:^{
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    NSFileManager*mgr=[NSFileManager defaultManager];
                    [mgr removeItemAtPath:WZF_MP3Cache error:nil];
                    [mgr createDirectoryAtPath:WZF_MP3Cache withIntermediateDirectories:YES attributes:nil error:nil];
                    
                    
                });
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    self.textLabel.text=@"清理完毕(0B)";
                });
                
            }];
            

        });
        
    }
    
}




@end
