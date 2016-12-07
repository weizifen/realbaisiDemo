//
//  WZF_SeeBigPictureViewController.m
//  百思不得jie项目1
//
//  Created by 韦自奋 on 16/11/29.
//  Copyright © 2016年 韦自奋. All rights reserved.
//

#import "WZF_SeeBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "ALLModel.h"
#import <SVProgressHUD.h>
#import <Photos/Photos.h>
@interface WZF_SeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *save;
@property(nonatomic,weak)UIImageView*image;
@end

@implementation WZF_SeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //创建scrollview
    UIScrollView*scrollView=[[UIScrollView alloc]init];
    scrollView.frame=[UIScreen mainScreen].bounds;
//    scrollView.backgroundColor=[UIColor redColor];
    [self.view insertSubview:scrollView atIndex:0];
    //imageView
    NSLog(@"%@",self.model.large_image);
    UIImageView*image=[[UIImageView alloc]init];
    [image sd_setImageWithURL:[NSURL URLWithString:self.model.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            return ;
        }
        self.save.enabled=YES;
        
    }];
    image.wzf_width=scrollView.wzf_width;
    image.wzf_x=0;
    image.wzf_height=(image.wzf_width*self.model.height)/self.model.width;
    if (image.wzf_height>[UIScreen mainScreen].bounds.size.height) {
        image.wzf_y=0;
        scrollView.contentSize=CGSizeMake(0, image.wzf_height);
        
        
    }else
    {
        image.wzf_centerY=[UIScreen mainScreen].bounds.size.height*0.5;
        
    }
    [scrollView addSubview:image];
    //图片缩放
CGFloat maxScale=self.model.width/image.wzf_width;

    if(maxScale>1)
{
    scrollView.maximumZoomScale=maxScale;
    scrollView.delegate=self;
    self.image=image;
    
}

}
//从scrollview获取缩放的子控制器
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.image;
}








- (IBAction)back:(id)sender {
    [self back];
}

-(void)back
{
    [self dismissViewControllerAnimated:self completion:nil];
}






- (PHFetchResult<PHAsset *> *)createdAssets
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    
    // 保存图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //这里面有传入相册的照片 ,并从那个uiimageveiw上取,修改即可
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.image.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 获取刚才保存的相片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}
/**
 *  保存图片到相册
 */
- (void)saveImageIntoAlbum
{
    // 获得相片
    PHFetchResult<PHAsset *> *createdAssets = self.createdAssets;
    if (createdAssets == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
        return;
    }
    
    // 获得相册
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建或者获取相册失败！"];
        return;
    }
    
    // 添加刚才保存的图片到【自定义相册】
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    // 最后的判断
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功！"];
    }
}

#pragma mark - 获得当前App对应的自定义相册
- (PHAssetCollection *)createdCollection
{
    // 获得软件名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    
    // 抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查找当前App对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    /** 当前App对应的自定义相册没有被创建过 **/
    // 创建一个【自定义相册】
    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 根据唯一标识获得刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}


- (IBAction)save:(id)sender {
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    // 请求\检查访问权限 :
    // 如果用户还没有做出选择，会自动弹框，用户对弹框做出选择后，才会调用block
    // 如果之前已经做过选择，会直接执行block
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前App访问相册
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                  //提醒用户打开开关,可以modal一个控制器uiew上告诉用户
                }
            } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前App访问相册
                [self saveImageIntoAlbum];
            } else if (status == PHAuthorizationStatusRestricted) { // 无法访问相册
                [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
            }
        });
    }];

 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
