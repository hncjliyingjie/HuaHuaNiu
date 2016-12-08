//
//  ViewController.m
//  demo
//
//  Created by 张燕 on 2016/11/26.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ARSViewController.h"
#import "ReleaseTaskOneCell.h"
#import "ReleaseTaskSecondCell.h"
#import "ReleaseTaskThirdCell.h"
#import "ReleaseTaskfourthCell.h"
#import "DatePickerView.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "XZPTViewController.h"
#import "Toast+UIView.h"
@interface ARSViewController ()<UITableViewDelegate,UITableViewDataSource,DatePickerViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,TZImagePickerControllerDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,assign)BOOL isCustom;
@property(nonatomic,strong)DatePickerView* datePickerView;
@property(nonatomic,assign)BOOL isBeginDate;
@property(nonatomic,assign)BOOL islink;
@property(nonatomic,strong)NSMutableArray* picText_selectedPhotos;
@property(nonatomic,strong)NSMutableArray* picText_selectedAssets;
@property(nonatomic,strong)NSMutableArray *link_selectedPhotos;
@property(nonatomic,strong)NSMutableArray *link_selectedAssets;
@property (nonatomic,strong)UIImagePickerController *imagePickerVc;
@property(nonatomic,strong)NSMutableArray* array;

@property(nonatomic,strong)NSString* link;
@property(nonatomic,strong)NSString* linkText;
@property(nonatomic,strong)NSString* picText;

@property(strong,nonatomic)NSMutableArray *link_pic;//服务器返回的图片地址数组
@property(strong,nonatomic)NSMutableArray *pict_pic;

@end

#define PicText_Max 9
#define Link_Max 1

@implementation ARSViewController

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布任务";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor =[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelKeyboard)];
    tap.delegate = self;
    [self.tableView addGestureRecognizer:tap];
    
    self.islink = YES;
    
    self.array = [[NSMutableArray alloc]init];
    
    _linkText = @"";
    _link = @"";
    _picText = @"";
    _link_selectedPhotos = [[NSMutableArray alloc]init];
    _picText_selectedPhotos = [[NSMutableArray alloc]init];
    _link_selectedAssets = [[NSMutableArray alloc]init];
    _picText_selectedAssets = [[NSMutableArray alloc]init];
     _link_pic = [[NSMutableArray alloc]init];
     _pict_pic = [[NSMutableArray alloc]init];
}

-(void)cancelKeyboard
{
    [self.view endEditing:YES];//隐藏所有的键盘
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return YES;
    }
    return  NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 40;
            break;
        case 1:
        {
            if (self.islink) {
                return [ReleaseTaskSecondCell getHeight:_islink imageUrlsCount:_link_selectedPhotos.count];
            }
            else{
                return [ReleaseTaskSecondCell getHeight:_islink imageUrlsCount:_picText_selectedPhotos.count];
            }
        }
            break;
        case 2:
            return [ReleaseTaskThirdCell getHeight:_isCustom];
            break;
        case 3:
            return [ReleaseTaskfourthCell getHeight];
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ReleaseTaskOneCell* cell = nil;
        if (_array.count > 0) {
            cell = (ReleaseTaskOneCell*)_array[0];
        }
        else{
            cell = [[ReleaseTaskOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"one"];
            [_array addObject:cell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        
        return cell;
    }
    else if (indexPath.row == 1){
        ReleaseTaskSecondCell* cell = nil;
        if (_array.count > 1) {
            cell = (ReleaseTaskSecondCell*)_array[1];
        }
        else{
            cell = [[ReleaseTaskSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"two"];
            [_array addObject:cell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isLink = _islink;
        cell.link_imageUrls = _link_selectedPhotos;
        cell.picText_imageUrls = _picText_selectedPhotos;
        cell.link_assetsImageUrls = _link_selectedAssets;
        cell.picText_assetsImageUrls = _picText_selectedAssets;
        cell.view_link.textView.text = _linkText;
        cell.view_picText.textView.text = _picText;
        cell.view_link.textField.text = _link;
        
        __weak typeof(cell) weakCell = cell;
        cell.addBlock = ^(BOOL isLink){
            self.islink = isLink;
            if (isLink) {
                self.link = weakCell.view_link.textField.text;
                self.linkText = weakCell.view_link.textView.text;
            }
            else{
                self.picText = weakCell.view_picText.textView.text;
            }
            [self showPicker];
        };
        
        cell.exampleBlock = ^(BOOL isLink){
            self.islink = isLink;
            if (isLink) {
                self.link = weakCell.view_link.textField.text;
                self.linkText = weakCell.view_link.textView.text;
            }
            else{
                self.picText = weakCell.view_picText.textView.text;
            }
            [self showExample];
        };
        
        cell.shareBlock = ^(BOOL isLink){
            self.islink = isLink;
            if (!isLink) {
                self.link = weakCell.view_link.textField.text;
                self.linkText = weakCell.view_link.textView.text;
            }
            else{
                self.picText = weakCell.view_picText.textView.text;
            }
            [self reloadRowIndexInSection:0 row:1];
        };
        
        cell.heigthBlock = ^(BOOL isLink, NSMutableArray *selectedPhotos,NSMutableArray *selectedAssets){
            self.islink = isLink;
            if (isLink) {
                self.link_selectedAssets = selectedAssets;
                self.link_selectedPhotos = selectedPhotos;
            }
            else{
                self.picText_selectedAssets = selectedAssets;
                self.picText_selectedPhotos = selectedPhotos;
            }
            if (isLink) {
                self.link = weakCell.view_link.textField.text;
                self.linkText = weakCell.view_link.textView.text;
            }
            else{
                self.picText = weakCell.view_picText.textView.text;
            }
            [self reloadRowIndexInSection:0 row:1];
        };
        cell.contentView.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        return cell;
    }
    else if (indexPath.row == 2){
        ReleaseTaskThirdCell* cell = nil;
        if (_array.count > 2) {
            cell = (ReleaseTaskThirdCell*)_array[2];
            if (cell.isCustom != self.isCustom) {
                cell = [[ReleaseTaskThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"three"];
                [_array replaceObjectAtIndex:2 withObject:cell];
            }
        }
        else{
            cell = [[ReleaseTaskThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"three"];
            [_array addObject:cell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isCustom = _isCustom;
        
        cell.instantlyBlock = ^(){
            self.isCustom = NO;
            [self reloadRowIndexInSection:0 row:2];
        };
        
        cell.customBlock = ^(){
            self.isCustom = YES;
            [self reloadRowIndexInSection:0 row:2];
        };
        
        cell.beginTimeBlock = ^(){
            self.isBeginDate = YES;
            [self showDatePicker];
        };
        
        cell.endTimeBlock = ^(){
            self.isBeginDate = NO;
            [self showDatePicker];
        };
        cell.contentView.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        NSDateFormatter* format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm"];
        cell.beginTime = [format stringFromDate:[NSDate date]];
        cell.endTime = [format stringFromDate:[NSDate dateWithTimeIntervalSinceNow:86400 * 2]];
        return cell;
    }
    else{
        ReleaseTaskfourthCell* cell = nil;
        if (_array.count > 3) {
            cell = (ReleaseTaskfourthCell*)_array[3];
        }
        else{
            cell = [[ReleaseTaskfourthCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"four"];
            [_array addObject:cell];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nextBlock = ^(){
            [self goToNext];
        };
        cell.contentView.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        return cell;
    }
}

//点击下一步
-(void)goToNext
{
    NSLog(@"%ld",self.tableView.visibleCells.count);
    
    ReleaseTaskOneCell* one = (ReleaseTaskOneCell*)_array[0];
    NSString* name = one.textField.text; //任务名称
    
    //分享链接 link
    //分享链接要传的文字 linkText
    //分享图文 picText
    
    //分享图文图片 picText_selectedPhotos
    //分享链接图片 link_selectedPhotos
    ReleaseTaskSecondCell* two = (ReleaseTaskSecondCell*)_array[1];
    if ([_link isEqualToString:@""]) {
        _link = two.view_link.textField.text;
    }
    if ([_linkText isEqualToString:@""]) {
        _linkText = two.view_link.textView.text;
    }
    if ([_picText isEqualToString:@""]) {
        _picText = two.view_picText.textView.text;
    }
    
    ReleaseTaskThirdCell* third = (ReleaseTaskThirdCell*)_array[2];
    NSString* beginTime = third.beginTime; //开始时间
    NSString* endTime = third.endTime; //结束时间
    
    ReleaseTaskfourthCell* four = (ReleaseTaskfourthCell*)_array[3];
    NSString* phone = four.textField_phone.text; //联系电话
    NSString* taskRequest = four.textView_taskRequest.text; //任务要求
    
//    NSDictionary* dic = @{@"name" : name,
//                          @"link" : _link,
//                          @"linkText" : _linkText,
//                          @"picText" : _picText,
//                          @"picText_selectedPhotos" : _picText_selectedPhotos,
//                          @"link_selectedPhotos" : _link_selectedPhotos,
//                          @"beginTime" : beginTime,
//                          @"endTime" : endTime,
//                          @"phone" : phone,
//                          @"taskRequest" : taskRequest};
//    
    //判断自定义时间
    NSDateFormatter* format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* beginDate = [format dateFromString:beginTime];
    NSDate* endDate = [format dateFromString:endTime];
    NSDate* earilerDate = [beginDate earlierDate:endDate];
    if (earilerDate != beginDate) {
        // 时间选择有错
    }
    //分型链接判断
    if(_islink){
        if([name isEqualToString:@""] || [_link isEqualToString:@""] || [_linkText isEqualToString:@""] || [phone isEqualToString:@""]){
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"信息未填写完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            
            
        }
        else{
            NSDictionary* dic = @{@"name" : name,
                                  @"link" : _link,
                                  @"content" : _linkText,
                                  @"images" : _link_pic,
                                  @"beginTime" : beginTime,
                                  @"endTime" : endTime,
                                  @"phone" : phone,
                                  @"taskRequest" : taskRequest};
            //跳转
            XZPTViewController *xzptVC=[[XZPTViewController alloc]initWithNibName:@"XZPTViewController" bundle:nil];
            [xzptVC initWithYonghuXinxi:dic];
            
            [self.navigationController pushViewController:xzptVC animated:YES];
        }
    }
    else{
        //分享图文判断
        if([name isEqualToString:@""] || [_picText isEqualToString:@""] || [phone isEqualToString:@""] ){
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"信息未填写完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }
        else{
            NSDictionary* dic = @{@"name" : name,
                                  @"content" : _picText,
                                  @"images" : _pict_pic,
                                  @"beginTime" : beginTime,
                                  @"endTime" : endTime,
                                  @"phone" : phone,
                                  @"taskRequest" : taskRequest};
            

            //跳转
            XZPTViewController *xzptVC=[[XZPTViewController alloc]initWithNibName:@"XZPTViewController" bundle:nil];
             [xzptVC initWithYonghuXinxi:dic];
            [self.navigationController pushViewController:xzptVC animated:YES];
        }
    }
    
}

//示例
-(void)showExample
{
    if (_islink) {
        
    }
    else{
        
    }
}

- (void)reloadRowIndexInSection:(NSInteger)section row:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

-(void)showDatePicker
{
    if (_datePickerView == nil) {
        self.datePickerView = [[DatePickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height ,self.view.frame.size.width, [DatePickerView getHeight])];
        self.datePickerView.delegate = self;
        [self.view addSubview:_datePickerView];
        [UIView animateWithDuration:0.2 animations:^{
            CGRect f = _datePickerView.frame;
            f.origin.y = self.view.frame.size.height - [DatePickerView getHeight];
            _datePickerView.frame = f;
        }];
    }
}

-(void)cancelDatePicker
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect f = _datePickerView.frame;
        f.origin.y = self.view.frame.size.height;
        _datePickerView.frame = f;
    } completion:^(BOOL finished) {
        [_datePickerView removeFromSuperview];
        _datePickerView = nil;
    }];
}

#pragma mark - DatePickerViewDelegate
-(void)hitSureCallBack:(NSString*)string
{
    ReleaseTaskThirdCell* cell = (ReleaseTaskThirdCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (_isBeginDate) {
        cell.beginTime = string;
    }
    else{
        cell.endTime = string;
    }
    
    [self cancelDatePicker];
}

-(void)hitCancelCallBack
{
    [self cancelDatePicker];
}

#pragma mark - add
-(void)showPicker
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
#pragma clang diagnostic pop
    [sheet showInView:self.view];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
        // 拍照之前还需要检查相册权限
    } else if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        if (self.islink) {
                            [_link_selectedAssets addObject:assetModel.asset];
                            [_link_selectedPhotos addObject:image];
                        }
                        else{
                            [_picText_selectedAssets addObject:assetModel.asset];
                            [_picText_selectedPhotos addObject:image];
                        }
                        [self reloadRowIndexInSection:0 row:1];
                    }];
                }];
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIActionSheetDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    int num = _islink ? Link_Max : PicText_Max;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:num columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.selectedAssets = _islink ? _link_selectedAssets : _picText_selectedAssets;
    
    //控制是否可以选择原图，yes为不能
    imagePickerVc.allowPickingOriginalPhoto = YES;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //分享链接上传的图片
        if (_islink) {
            //获取选中图片
            //            [[TZImageManager manager] getOriginalPhotoWithAsset:photos completion:^(UIImage *photo,NSDictionary *info){
            //
            //            }];
            [self addPictures:photos];
        }
        //分享图文上传的图片
        else{
            
            //获取选中图片
            //            [[TZImageManager manager] getOriginalPhotoWithAsset:photos completion:^(UIImage *photo,NSDictionary *info){
            
            //            }];
            [self addScoundPictures:photos];
            
        }
        
    }];
    
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark 分享链接上传图片
-(void)addPictures:(NSArray *)imageArray{
    
    [self.view makeToastActivity];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    
    [manager POST:PICTUREURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i=0; i<imageArray.count; i++) {
            UIImage *img=[imageArray objectAtIndex:i];
            //对于图片进行压缩
            //UIImage *image = [UIImage imageNamed:@"111"];
            NSData *data = UIImageJPEGRepresentation(img, 0.1);
            //NSData *data = UIImagePNGRepresentation(image);
            [formData appendPartWithFileData:data name:@"Filedata"fileName:@"test.jpg"mimeType:@"image/jpg"];
        } //第一个代表文件转换后data数据，第二个代表图片的名字，第三个代表图片放入文件夹的名字，第四个代表文件的类型
    }success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"请求成功%@",responseObject);
        
        [self.view hideToastActivity];
        //保存分享链接上传的图片地址
        NSString *str=[responseObject objectForKey:@"files"];
        [_link_pic addObject:str];
        
        // upload succ
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"图片上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        NSLog(@"#######upload error%@", error);
    }];
}
#pragma mark 分享图文上传图片
-(void)addScoundPictures:(NSArray *)imageArray{
    [self.view makeToastActivity];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    
    [manager POST:PICTUREURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i=0; i<imageArray.count; i++) {
            UIImage *img=[imageArray objectAtIndex:i];
            //对于图片进行压缩
            //UIImage *image = [UIImage imageNamed:@"111"];
            NSData *data = UIImageJPEGRepresentation(img, 0.1);
            //NSData *data = UIImagePNGRepresentation(image);
            NSString *namestr=[NSString stringWithFormat:@"%d",i];
            [formData appendPartWithFileData:data name:namestr fileName:@"test.jpg"mimeType:@"image/jpg"];
        } //第一个代表文件转换后data数据，第二个代表图片的名字，第三个代表图片放入文件夹的名字，第四个代表文件的类型
    }success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"分享图文请求成功%@",responseObject);
        [self.view hideToastActivity];
        //保存分享图文上传的图片地址
        NSArray *strArray=[responseObject objectForKey:@"files"];
        for (int i=0; i<strArray.count; i++) {
            NSString *str=[strArray objectAtIndex:i];
            [_pict_pic addObject:str];

        }
        
       
//        _picText_selectedPhotos=[NSMutableArray arrayWithObject:str];
        
        // upload succ
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"图片上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        NSLog(@"#######upload error%@", error);
    }];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    if (self.islink) {
        _link_selectedPhotos = [NSMutableArray arrayWithArray:photos];
        _link_selectedAssets = [NSMutableArray arrayWithArray:assets];
    }
    else{
        _picText_selectedPhotos = [NSMutableArray arrayWithArray:photos];
        _picText_selectedAssets = [NSMutableArray arrayWithArray:assets];
    }
    
    [self reloadRowIndexInSection:0 row:1];
}

//imagePickerController状态栏修复
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

@end
