//
//  DQQupdataViewController.m
//  HuaHuaNiu
//
//  Created by Vking on 16/1/27.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "DQQupdataViewController.h"
#import "AFNetworking.h"
#import "PostProgressView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import<MobileCoreServices/MobileCoreServices.h>


#define KCachesPath   \
[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]


@interface DQQupdataViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    PostProgressView *_postProgressView;//上传进度视图
    UIImagePickerController* Videopicker;
}

@property (weak, nonatomic) IBOutlet UILabel *uilabel;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIImageView *buttonimage;
@property (nonatomic,strong) NSMutableArray        *groupArrays;
@property (strong, nonatomic) AFHTTPSessionManager *manager;

@property (nonatomic , copy) NSString *filepath;


@property (nonatomic,copy) NSString *file_id;
@property (nonatomic,copy) NSString *img_id;


@end

@implementation DQQupdataViewController

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
    
    
    _member = [[NSUserDefaults standardUserDefaults] objectForKey:@"Useid"];
    
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
    
    
    
    //初始化_postProgressView
    if (!_postProgressView) {
        _postProgressView = [[PostProgressView alloc] initWithFrame:self.view.frame];
    }
    //显示上传进度
    [_postProgressView showInView:self.view];
    
    
    //初始化一个请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //请求接口
    NSString *urlString = [NSString stringWithFormat:@"http://daiyancheng.cn/appfile/uploadfile.do?token=test&member_id=%@&type=pic",[[NSUserDefaults standardUserDefaults] objectForKey:@"Useid"]];
    
    UIImage *image = self.buttonimage.image;
    
    NSData *imageData =  UIImagePNGRepresentation(image);
    
    
    
    
    
    AFHTTPRequestOperation *operation = [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"image%d.png",arc4random() % 5] mimeType:@"image/png"];
        
       // [formData appendPartWithFormData:imageData name:@"image"];

    } success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"上传成功 %@",responseObject);
        
        
        if ([[responseObject objectForKey:@"result"] integerValue] == 1)
        {
            _file_id = [responseObject objectForKey:@"fileid"];
            _img_id = [responseObject objectForKey:@"img_id"];
            
            NSLog(@"%@",_file_id);
            
            NSString * str1 =[[NSString stringWithFormat:@"%@",_textview.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            
            NSString *a = [NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/video_add.do?token=test&member_id=%@&title=%@&file_id=&img_id=%@&type_id=0",_member,str1,_file_id];
            
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
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
}



- (IBAction)photo:(id)sender

{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentModalViewController:picker animated:YES];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    
}
-(void)saveImage:(id)sender
{

    self.buttonimage.image = sender;
     
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
