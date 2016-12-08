//
//  JDViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/16.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "JDViewController.h"
#import "FXTWView.h"
#import "Masonry.h"
#import "XZPTViewController.h"
#import "ZYQAssetPickerController.h"
#import <AVFoundation/AVFoundation.h>

#import "LocalPhotoViewController.h"

#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width

@interface JDViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,SelectPhotoDelegate,UITextFieldDelegate,UITextViewDelegate,ZYQAssetPickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic)UIImagePickerController * imagePikerViewController;//拍照，获取头像

@property (weak, nonatomic) IBOutlet UIButton *rightImgBtn;//自定义前面的btn
@property (weak, nonatomic) IBOutlet UIButton *leftImgBtn;//立即开始前面的btn
@property (weak, nonatomic) IBOutlet UIView *kjView;//加载所有控件的View
@property (weak, nonatomic) IBOutlet UIView *nameView;//任务名称view
@property (weak, nonatomic) IBOutlet UIView *timeView;//时间自定义的view
@property (weak, nonatomic) IBOutlet UIView *startView;//开始时间View
@property (weak, nonatomic) IBOutlet UIView *endView;//结束时间view
@property (weak, nonatomic) IBOutlet UIView *phoneView;//联系号码view
@property (weak, nonatomic) IBOutlet UIView *rwView;//任务要求view

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;//立即开始按钮
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;//时间自定义
@property (weak, nonatomic) IBOutlet UIView *circleView;//开始时间，结束时间的整体view
@property (weak, nonatomic) IBOutlet UIView *bottomView;//联系号码以下的整体view

@property (weak, nonatomic) IBOutlet UITextField *rwTextfield;//任务名称输入框

@property (weak, nonatomic) IBOutlet UILabel *startLbl;//开始时间

@property (weak, nonatomic) IBOutlet UILabel *endLbl;//结束时间

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;//下一步
@property (weak, nonatomic) IBOutlet UITextView *rwyqTextView;//任务要求
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;//输入号码
@property (weak, nonatomic) IBOutlet UILabel *yqtiLbl;//友情提示

@property (weak, nonatomic) IBOutlet UIView *shareView;//分享图文或链接的view

@property(strong,nonatomic)FXTWView *shareTWView;//分享图文的View

@property(strong,nonatomic)FXTWView *shareLJView;//分享链接的View


@end

@implementation JDViewController
{
    NSMutableArray *selectPhotos;
    NSUserDefaults *defaults;//保存上传的数据
    
//    UIView  *_editv;
//    UIButton             *_addPic;
//    NSMutableArray       *_imageArray;
//    UITextView           *_textView;
}
////定义展示的UICollectionViewCell的个数
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 30;
//}
////定义展示的Section的个数
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}
//
////每个UICollectionView展示的内容
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString * CellIdentifier = @"GradientCell";
//    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    
////    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
//    cell.backgroundColor=[UIColor redColor];
//    return cell;
//    
//}
//#pragma mark --UICollectionViewDelegateFlowLayout
////定义每个UICollectionView 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(96, 100);
//}
////定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}
//#pragma mark --UICollectionViewDelegate
////UICollectionView被选中时调用的方法
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
//}
//
////返回这个UICollectionView是否可以被选择
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//-(void)getSelectedPhoto:(NSMutableArray *)photos{
////    selectPhotos=photos;
////    NSLog(@"供选择%d张照片",[photos count]);
////    [self.tableView reloadData];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    defaults =[NSUserDefaults standardUserDefaults];
    //设置view中控件的各种样式
    [self viewWithStyle];
    //选择相册
    [self initImagePickerView];
    
   defaults =[NSUserDefaults standardUserDefaults];
    
}

-(void)initImagePickerView
{
    self.imagePikerViewController = [[UIImagePickerController alloc] init];
    self.imagePikerViewController.delegate = self;
    self.imagePikerViewController.allowsEditing = YES;
}

#pragma mark  UITextFieldDelegate
//输入完调用
- ( void )textFieldDidEndEditing:( UITextField *)textField

{
    //任务名称
    [defaults setObject:self.rwTextfield.text forKey:@"name"];
    //分享链接下的输入分享链接
    [defaults setObject:self.shareLJView.fxljTextField.text forKey:@"fxName"];
    NSLog(@"%@",self.shareLJView.fxljTextField.text);
    //输入号码
    [defaults setObject:self.phoneTextField.text forKey:@"phoneName"];
//    [defaults synchronize];
    
}
//结束编辑
-(void)textViewDidEndEditing:(UITextView *)textView
{

    //分享链接下的代言人分享链接
    [defaults setObject:self.shareLJView.fxljTextView.text forKey:@"ljName"];
     //分享图文下的输入直发内容
    [defaults setObject: self.shareTWView.fxtwTextFiled.text forKey:@"zyName"];
    //任务要求
    [defaults setObject: self.rwyqTextView.text forKey:@"wryqName"];
//    [defaults synchronize];
    
}

#pragma mark 点击按钮action

//下一步跳转
-(void)nextDo:(id)sender{
    XZPTViewController *xzptVC=[[XZPTViewController alloc]initWithNibName:@"XZPTViewController" bundle:nil];
//    [xzptVC initWithData:defaults];
    [self.navigationController pushViewController:xzptVC animated:YES];
    
}
//点击分享链接，分享图文按钮时
-(void)share:(UIButton *)sender{
    UIButton *btn=sender;
    //当点击分享链接按钮
    if (btn.tag==1) {
        [self.shareTWView removeFromSuperview];
        [self.shareView  addSubview:self.shareLJView];
         [self addViewConstraints:self.shareLJView];
        [defaults setFloat:btn.tag forKey:@"fx_rw"];
      

       
        
    }
    //当点击分享图文按钮
    if (btn.tag==2) {
        [self.shareLJView removeFromSuperview];
        [self.shareView  addSubview:self.shareTWView];
         [self addViewConstraints:self.shareTWView];
         [defaults setFloat:btn.tag forKey:@"fx_rw"];
        
    }
    
}
//选择立即开始还是时间自定义
-(void)whichChoose:(id)sender{
    UIButton *btn=sender;
    if (btn.tag==1) {
        self.circleView.frame=CGRectMake(0, -500, ConentViewWidth, 90);
        self.bottomView.frame=CGRectMake(0, 320, ConentViewWidth, 500);
         [self.leftImgBtn setImage:[UIImage imageNamed:@"se.png"] forState:UIControlStateNormal];
        [self.rightImgBtn setImage:[UIImage imageNamed:@"quan.png"] forState:UIControlStateNormal];
        
        NSInteger dis = 2; //前后的天数
        NSDate*nowDate = [NSDate date];
        NSDate* theDate;
        if(dis!=0)
        {
            NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
            
            theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis ];
           
        }
        else
        {
            theDate = nowDate;
        }
        
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        
            NSString *NowTime = [formatter stringFromDate:nowDate];
        
            NSString *DateTime = [formatter stringFromDate:theDate];
        
            NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
            NSLog(@"%@============年-月-日  时：分：秒=====================",NowTime);
        
        
      
    }
    if (btn.tag==2) {
        self.circleView.hidden=NO;
        self.circleView.frame=CGRectMake(0, 310, ConentViewWidth, 90);
        self.bottomView.frame=CGRectMake(0, 400, ConentViewWidth, 500);
         [self.leftImgBtn setImage:[UIImage imageNamed:@"quan.png"] forState:UIControlStateNormal];
         [self.rightImgBtn setImage:[UIImage imageNamed:@"se.png"] forState:UIControlStateNormal];
        
        //开始时间
        NSString *startStr=self.startLbl.text;
        [defaults setObject:startStr forKey:@"startTime"];
        //结束时间
        NSString *endStr=self.endLbl.text;
         [defaults setObject:endStr forKey:@"endTime"];

    }
    
}
//添加示例图片
-(void)photoDo:(id)sender{
    
    [self takephoto];

}
#pragma mark 添加的view的约束
-(void)addViewConstraints:(FXTWView *)vc{
    
    [vc mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo(ConentViewWidth-20);
        make.left.mas_equalTo(self.shareView.mas_left).offset(0);
        make.top.mas_equalTo(self.shareView.mas_top).with.offset(0);
        make.bottom.mas_equalTo(self.shareView.mas_bottom).with.offset(0);
    }];
}

-(void)addPhotoView:(UIView *)vc{
    
    [vc mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo(ConentViewWidth-20);
        make.left.mas_equalTo(self.shareView.mas_left).offset(0);
        make.top.mas_equalTo(self.shareView.mas_top).with.offset(170);
        make.bottom.mas_equalTo(self.shareView.mas_bottom).with.offset(0);
    }];
}
//自定义时间
-(void)addViewsConstraints:(UIView *)vc{
    
    [vc mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo(ConentViewWidth);
        make.left.mas_equalTo(self.kjView.mas_left).offset(0);
        make.top.mas_equalTo(self.timeView.mas_bottom).with.offset(10);
        make.bottom.mas_equalTo(self.kjView.mas_bottom).with.offset(0);
    }];
}

#pragma mark 懒加载
//分享图文view
-(FXTWView *)shareTWView{
    if (_shareTWView==nil) {
        _shareTWView=[FXTWView creatView];
//        _shareTWView.tag=2;
        [_shareTWView.fxljBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        //分享图文view中的分享链接按钮
        [_shareTWView styleWithBtn];
        //分享图文时的图标
        [_shareTWView.twImgBtn addTarget:self action:@selector(photoDo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareTWView;
    
}
//分享链接view
-(FXTWView *)shareLJView{
    if (_shareLJView==nil) {
        _shareLJView=[FXTWView creatFirstView];
//         _shareLJView.tag=1;
        [_shareLJView.fxtwBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [_shareLJView.ljImgBtn addTarget:self action:@selector(photoDo:) forControlEvents:UIControlEventTouchUpInside];
        [_shareLJView styleWithOtherBtn];
        _shareLJView.collectView.delegate=self;
        
    }
    return _shareLJView;
}
-(void)viewWithStyle{
    
    self.title=@"发布任务";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    
    [self.shareView addSubview:self.shareLJView];
//    self.shareLJView.frame=CGRectMake(0, 0, ConentViewWidth-20, 220);
    [self addViewConstraints:self.shareLJView];
//    [self.shareLJView.fxtwBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
//    [self.shareLJView.ljImgBtn addTarget:self action:@selector(photoDo:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rwyqTextView.text=@"1、请仔细阅读分享规则及任务要求，确保任务准确分享。\r\n2、成功分享2小时后上传分享截图。\r\n3、至少手机一条非发布者的赞和评论。\r\n ";
    self.yqtiLbl.text=@"友情提示:\r\n1、请仔细阅读分享规则及任务要求，确保任务准确分享。\r\n2、成功分享2小时后上传分享截图。\r\n3、至少手机一条非发布者的赞和评论。";
    
    self.nextBtn.layer.cornerRadius=15;
    [self.nextBtn  addTarget:self action:@selector(nextDo:) forControlEvents:UIControlEventTouchUpInside];
    
    //任务名称的view
    self.nameView.layer.cornerRadius=5;
    self.nameView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.nameView.layer.borderWidth=0.5;
    
    //分享链接图文的view
    self.shareView.layer.cornerRadius=5;
    self.shareView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.shareView.layer.borderWidth=0.5;
    
    //立即开始的view
    self.timeView.layer.cornerRadius=5;
    self.timeView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.timeView.layer.borderWidth=0.5;
    
    
    //开始时间的view
    self.startView.layer.cornerRadius=5;
    self.startView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.startView.layer.borderWidth=0.5;
    
    //结束时间的view
    self.endView.layer.cornerRadius=5;
    self.endView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.endView.layer.borderWidth=0.5;
    
    //联系号码的view
    self.phoneView.layer.cornerRadius=5;
    self.phoneView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.phoneView.layer.borderWidth=0.5;
    
    //任务要求的view
    self.rwView.layer.cornerRadius=5;
    self.rwView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.rwView.layer.borderWidth=0.5;
    
    
    //立即开始，自定义时间按钮
    [self.leftBtn addTarget:self action:@selector(whichChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(whichChoose:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.tag=1;
    self.rightBtn.tag=2;
    [self addViewsConstraints:self.bottomView];
    //任务名称
    self.rwTextfield.delegate=self;
    //输入分享链接
    self.shareLJView.fxljTextField.delegate=self;
    //输入代言人分享时说的话
    self.shareLJView.fxljTextView.delegate=self;
    //分享图文下的输入直发内容
    self.shareTWView.fxtwTextFiled.delegate=self;
    //任务要求
    self.rwyqTextView.delegate=self;
    //输入号码
     self.phoneTextField.delegate=self;
    
//    _imageArray = [NSMutableArray array];
//    // 评论 + 照片
//    _editv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ConentViewWidth-20, ConentViewHeight)];
//    _editv.backgroundColor = [UIColor blueColor];
//    [self.shareView addSubview:_editv];
//    [ self addPhotoView:_editv];
//    _addPic = [UIButton buttonWithType:UIButtonTypeCustom];
//    _addPic.frame = CGRectMake(15, 15, 30, 30);
//    [_addPic setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
//    [_addPic addTarget:self action:@selector(addPicEvent) forControlEvents:UIControlEventTouchUpInside];
//    [_editv addSubview:_addPic];
//    _editv.frame = CGRectMake(15, 50, ScreenWidth-15*2, CGRectGetMaxY(_addPic.frame)+20);
//    [ self addPhotoView:_editv];

    
}
#pragma mark ---点击头像，弹出照相选择器
-(void)takephoto
{
    UIActionSheet *actionSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消"  destructiveButtonTitle:nil otherButtonTitles:@"拍照" ,@"从手机相册选取", nil];
    [actionSheet showInView:self.view];
}

#pragma mark --- UIActionSheetDelegate <NSObject>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if(buttonIndex == 2)
        return;
    
    //来源于相机
    if(buttonIndex == 0)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];  // 获取对摄像头的访问权限
        
        if(authStatus != AVAuthorizationStatusDenied && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            self.imagePikerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePikerViewController.showsCameraControls = YES;
            
            [self presentViewController:self.imagePikerViewController animated:YES completion:NULL];
            
        }else{
//            [self showHint:ERROR_Camera_NoPermission];
            //应该给出相应提示
        }
        
    }
    else if(buttonIndex == 1)
    {
//                //点击分享图文下的照片选择
//        if (_shareLJView.tag==1) {
//            LocalPhotoViewController *pick=[[LocalPhotoViewController alloc] init];
//            pick.selectPhotoDelegate=self;
//            pick.selectPhotos=selectPhotos;
//            [self.navigationController pushViewController:pick animated:YES];
//
//        }
//        if (_shareTWView.tag==2) {
//            LocalPhotoViewController *pick=[[LocalPhotoViewController alloc] init];
//            pick.selectPhotoDelegate=self;
//            pick.selectPhotos=selectPhotos;
//            [self.navigationController pushViewController:pick animated:YES];
//            
//        }

        
//        //来源于相册
//        self.imagePikerViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:self.imagePikerViewController animated:YES completion:NULL];
      
//        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:nil action:nil];
       

    }
    
}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [self dismissViewControllerAnimated:YES completion:NULL];
//    
//    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera ||
//        picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary ||
//        picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum){
//        
//        NSData *data;
//        
//        //切忌不可直接使用originImage，因为这是没有经过格式化的图片数据，可能会导致选择的图片颠倒或是失真等现象的发生，从UIImagePickerControllerOriginalImage中的Origin可以看出，很原始，哈哈
//        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//        
//        //图片压缩，因为原图都是很大的，不必要传原图
//        UIImage *scaleImage = [self scaleImage:originImage toScale:0.3];
//        
//        //以下这两步都是比较耗时的操作，最好开一个HUD提示用户，这样体验会好些，不至于阻塞界面
//        if (UIImagePNGRepresentation(scaleImage) == nil) {
//            //将图片转换为JPG格式的二进制数据
//            data = UIImageJPEGRepresentation(scaleImage, 1);
//        } else {
//            //将图片转换为PNG格式的二进制数据
//            data = UIImagePNGRepresentation(scaleImage);
//        }
//        
//        //将二进制数据生成UIImage
//        UIImage *image = [UIImage imageWithData:data];
//        [self requestUploadImage:image];
//        
//        UIImage *images = [info objectForKey:UIImagePickerControllerOriginalImage];
////        self.headImage.image = images;
//        [self.shareLJView.ljImgBtn setImage:images forState:UIControlStateNormal];
//        [self.shareTWView.twImgBtn setImage:images forState:UIControlStateNormal];
//    }
//    
//}

#pragma mark ---向服务器上传头像图片
-(void)requestUploadImage:(UIImage *)image
{
    //    [[TTIHttpClient sharedClient]  uploadSinglePicturesRequestWithphotoFile:image
    //                                                                 folderName:@"folderName"
    //                                                               successBlock:^(TTIRequest *request, TTIResponse *response)
    //     {
    //         _photoImgView.image  = image;
    //         PictureModel *model = response.responseModel;
    //         photoUrl  = model.picturePath;
    //
    //     } failedBlock:^(TTIRequest *request, TTIResponse *response)
    //     {
    //     }];
    
}

#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
#pragma mark - UIbutton event

//- (void)addPicEvent
//{
//    if (_imageArray.count >= 9) {
//        NSLog(@"最多只能上传9张图片");
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"最多只能上传9张图" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//        [alert show];
//    } else {
//        [self selectPictures];
//    }
//}
//
//// 本地相册选择多张照片
//- (void)selectPictures
//{
//    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
//    picker.maximumNumberOfSelection = 9-_imageArray.count;
//    picker.assetsFilter = [ALAssetsFilter allPhotos];
//    picker.showEmptyGroups = NO;
//    picker.delegate = self;
//    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings)
//                              {
//                                  if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
//                                  {
//                                      NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
//                                      
//                                      return duration >= 5;
//                                  } else {
//                                      return YES;
//                                  }
//                              }];
//    [self addPhotoView:_editv];
//    [self presentViewController:picker animated:YES completion:NULL];
//}
//// 9宫格图片布局
//- (void)nineGrid
//{
//    for (UIImageView *imgv in _editv.subviews)
//    {
//        if ([imgv isKindOfClass:[UIImageView class]]) {
//            [imgv removeFromSuperview];
//        }
//    }
//    
//    CGFloat width = 70;
//    CGFloat widthSpace = (ScreenWidth - 15*4 - 70*4) / 3.0;
//    CGFloat heightSpace = 10;
//    
//    NSInteger count = _imageArray.count;
//    _imageArray.count > 9 ? (count = 9) : (count = _imageArray.count);
//    
//    for (int i=0; i<count; i++)
//    {
//        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15+(width+widthSpace)*(i%4), (i/4)*(width+heightSpace) + CGRectGetMaxY(_textView.frame)+15, width, width)];
//        imgv.image = _imageArray[i];
//        imgv.userInteractionEnabled = YES;
//        [_editv addSubview:imgv];
//        
//        UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
//        delete.frame = CGRectMake(width-16, 0, 16, 16);
//        delete.backgroundColor = [UIColor greenColor];
//        [delete addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
//        delete.tag = 10+i;
//        [imgv addSubview:delete];
//        
//        if (i == _imageArray.count - 1)
//        {
//            if (_imageArray.count % 4 == 0) {
//                _addPic.frame = CGRectMake(15, CGRectGetMaxY(imgv.frame) + heightSpace, 70, 70);
//            } else {
//                _addPic.frame = CGRectMake(CGRectGetMaxX(imgv.frame) + widthSpace, CGRectGetMinY(imgv.frame), 70, 70);
//            }
//            
//             [self addPhotoView:_editv];
//            _editv.frame = CGRectMake(15, 50, ScreenWidth-15*2, CGRectGetMaxY(_addPic.frame)+20);
//            
//        }
//    }
//}
//
//// 删除照片
//- (void)deleteEvent:(UIButton *)sender
//{
//    UIButton *btn = (UIButton *)sender;
//    [_imageArray removeObjectAtIndex:btn.tag-10];
//    
//    [self nineGrid];
//    
//    if (_imageArray.count == 0)
//    {
//        _addPic.frame = CGRectMake(15, CGRectGetMaxY(_textView.frame)+15, 70, 70);
//        _editv.frame = CGRectMake(15, 50, ScreenWidth-15*2, CGRectGetMaxY(_addPic.frame)+20);
//        [self addPhotoView:_editv];
//    }
//}
//#pragma mark - ZYQAssetPickerController Delegate
//
//- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
//                   {
//                       for (int i=0; i<assets.count; i++)
//                       {
//                           ALAsset *asset = assets[i];
//                           UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//                           [_imageArray addObject:tempImg];
//                           
//                           dispatch_async(dispatch_get_main_queue(), ^{
//                               [self nineGrid];
//                           });
//                       }
//                   });
//}
//
//
@end
