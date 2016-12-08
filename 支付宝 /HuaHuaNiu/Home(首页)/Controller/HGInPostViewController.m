//
//  HGInPostViewController.m
//  视频模块
//
//  Created by wcs on 16/1/11.
//  Copyright © 2016年 Vking. All rights reserved.
//

#import "HGInPostViewController.h"
#import "AFNetworking.h"
#import "WechatShortVideoController.h"
#import "PostProgressView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import<MobileCoreServices/MobileCoreServices.h>


#define KCachesPath   \
[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]





@interface HGInPostViewController ()<UITextViewDelegate,WechatShortVideoDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
     PostProgressView *_postProgressView;//上传进度视图
    UIImagePickerController* Videopicker;
}
@property (weak, nonatomic) IBOutlet UILabel *uilabel;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (nonatomic,strong) WechatShortVideoController *wechatShortVideoController;

@property (nonatomic,strong) NSMutableArray        *groupArrays;
@property (strong, nonatomic) AFHTTPSessionManager *manager;

@property (nonatomic , copy) NSString *filepath;


@property (nonatomic,copy) NSString *file_id;
@property (nonatomic,copy) NSString *img_id;

@end

@implementation HGInPostViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textview resignFirstResponder];
}


- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
-(void)viewWillAppear:(BOOL)animated
{

    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithIcon:@"发布" highIcon:nil target:self action:@selector(upvideo)];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 初始化
    self.groupArrays = [NSMutableArray array];
    
    _textview.font = [UIFont systemFontOfSize:14];
 
    _textview.backgroundColor = [UIColor whiteColor];
    
    _textview.hidden = NO;
    _textview.delegate = self;
    //其次在UITextView上面覆盖个UILable,UILable设置为全局变量。
    
    _uilabel.text = @"想说点什么...";
    _uilabel.enabled = NO;//lable必须设置为不可用
    _uilabel.backgroundColor = [UIColor clearColor];
    
    
    
    
    NSLog(@"%@",_filepath);
    
}



-(void)upvideo
{
    [_textview resignFirstResponder];
    if (_filepath.length == 0 && _type == 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"代言城" message:@"还没有添加视频，请先添加视频再发布。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    
    //初始化_postProgressView
    if (!_postProgressView) {
        _postProgressView = [[PostProgressView alloc] initWithFrame:self.view.frame];
    }
    //显示上传进度
    [_postProgressView showInView:self.view];
    
    
    //初始化一个请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   
    //请求接口
    NSString *urlString = [NSString stringWithFormat:@"http://daiyancheng.cn/appfile/uploadfile.do?token=test&member_id=%@&type=video",_member];
  
    

    //发送POST请求
    AFHTTPRequestOperation *operation = [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (_type == 0)
        {
           [formData appendPartWithFileURL:[NSURL fileURLWithPath:_filepath] name:@"video" error:nil];
        }
        else
        {
            [formData appendPartWithFileURL:_fileurl name:@"video" error:nil];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"上传成功 %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] integerValue] == 1)
        {
            _file_id = [responseObject objectForKey:@"fileid"];
            _img_id = [responseObject objectForKey:@"img_id"];
            
            NSLog(@"%@",_file_id);
            
            NSString * str1 =[[NSString stringWithFormat:@"%@",_textview.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            
            NSString *a = [NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/video_add.do?token=test&member_id=%@&title=%@&file_id=%@&img_id=%@&type_id=1",_member,str1,_file_id,_img_id];
            
            NSString* UrlStr=[a stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",UrlStr);
            [manager POST:UrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                //隐藏上传视图
                [_postProgressView hide];
                
                NSString *message = [responseObject objectForKey:@"msg"];
                
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"代言城" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alter show];
                
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
                
                NSLog(@"%@",responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"失败");
                //隐藏上传视图
                [_postProgressView hide];
            }];

        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"代言城" message:@"上传失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alter show];
        }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败 %@",error);
        //隐藏上传视图
        [_postProgressView hide];
    }];
    
    //设置进度
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        //设置上传进度
        [_postProgressView updateWithProgress:(CGFloat)totalBytesWritten/totalBytesExpectedToWrite];
        
    }];

    

    
}


//实现UITextView的代理
-(void)textViewDidChange:(UITextView *)textView
{
    //self.examineText = textView.text;
    if (textView.text.length == 0) {
        _uilabel.text = @"想说点什么...";
    }else{
        _uilabel.text = @"";
    } 
}

- (IBAction)uploadvideo:(id)sender {
    _type = 1;
    if (Videopicker == nil) {
        Videopicker = [[UIImagePickerController alloc] init];
        Videopicker.delegate = self;
        [Videopicker setEditing:NO];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == YES) {
        Videopicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        Videopicker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
        [self.navigationController presentModalViewController:Videopicker animated:YES];
    } else {
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"不支持视频库" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
        
    }

    
}
- (IBAction)lushipin:(id)sender {
    
    _type = 0;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"video/%@/",self.member]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    _wechatShortVideoController = [[WechatShortVideoController alloc] init];
    _wechatShortVideoController.groupID = _member;
    
    _wechatShortVideoController.delegate = self;
    [self presentViewController:_wechatShortVideoController animated:YES completion:^{}];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishWechatShortVideoCapture:(NSString *)filePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath1 = [[paths objectAtIndex:0] stringByAppendingPathComponent:filePath];
    
    _filepath = filePath1;
    
    NSArray *arr = [[NSUserDefaults standardUserDefaults] arrayForKey:@"videolist"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:arr];
    [array addObject:filePath];
    arr = [NSArray arrayWithArray:array];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"videolist"];
    
    [_wechatShortVideoController dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%@",filePath);
    
    
    
}






#pragma mark  imagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"%@",[info valueForKey:UIImagePickerControllerMediaURL]);
    
    _fileurl = [info valueForKey:UIImagePickerControllerMediaURL];
    
    [picker dismissModalViewControllerAnimated:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}







@end
