//
//  FBViewController.m
//  HuaHuaNiu
//
//  Created by wcs on 16/1/17.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "FBViewController.h"
#import "AFNetworking.h"
#import "PostProgressView.h"

@interface FBViewController ()<UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    PostProgressView *_postProgressView;
    UIImageView *img;
}
@property (weak, nonatomic) IBOutlet UIButton *buttonimage;
- (IBAction)imagebutton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *addresstext;
@property (weak, nonatomic) IBOutlet UITextField *phonetext;
@property (weak, nonatomic) IBOutlet UITextField *moneytext;
@property (weak, nonatomic) IBOutlet UITextView *texttext;
@property (weak, nonatomic) IBOutlet UITextField *titletexe;

@property (weak, nonatomic) IBOutlet UIButton *tianJianTuPian;
@property (weak, nonatomic) IBOutlet UIButton *xuanZeButton;

@property (nonatomic,copy) NSString *file_id;
@property (nonatomic,copy) NSString *img_id;



@end

@implementation FBViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_titletexe resignFirstResponder];
    [_texttext resignFirstResponder];
    [_moneytext resignFirstResponder];
    [_phonetext resignFirstResponder];
    [_addresstext resignFirstResponder];
    [self.view setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"发布"] style:(UIBarButtonItemStylePlain) target:self action:@selector(loadup)];
    
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_titletexe]) {
        [self.view setFrame:CGRectMake(0, -50, ScreenWidth, ScreenHeight)];
    }
    if ([textField isEqual:_texttext]) {
        [self.view setFrame:CGRectMake(0, -70, ScreenWidth, ScreenHeight)];
    }
    if ([textField isEqual:_moneytext]) {
        [self.view setFrame:CGRectMake(0, -150, ScreenWidth, ScreenHeight)];
    }if ([textField isEqual:_addresstext]) {
        [self.view setFrame:CGRectMake(0, -251, ScreenWidth, ScreenHeight)];
    }if ([textField isEqual:_phonetext]) {
        [self.view setFrame:CGRectMake(0, -230, ScreenWidth, ScreenHeight)];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    return YES;
}
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    NSLog(@"%i",height);
//    [self.view setFrame:CGRectMake(0, -50, ScreenWidth, ScreenHeight)];
}
-(void)loadup
{
    [_addresstext resignFirstResponder];
    [_phonetext resignFirstResponder];
    [_texttext resignFirstResponder];
    [_moneytext resignFirstResponder];
    [_titletexe resignFirstResponder];
     [self.view setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
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
    
    UIImageView *image = img;
    
    NSData *imageData =  UIImagePNGRepresentation(image.image);
    
    
    
    
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
            
            NSString * str1 =[[NSString stringWithFormat:@"%@",_texttext.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            
            NSString *str = [NSString stringWithFormat:@"http://daiyancheng.cn/appinfo/%@_add.do?token=test&member_id=%@&title=%@&price=%@&phone=%@&address=%@&content=%@&img_id=%@",_fabuleixing,[Userdefaults objectForKey:@"Useid"],[_titletexe.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_moneytext.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_phonetext.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_addresstext.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_texttext.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_file_id];
            
            NSString* UrlStr=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)imageChouseButton:(UIButton *)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
}




- (IBAction)imagebutton:(id)sender {
    
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
    img = [[UIImageView alloc]init];
    img.image = sender;
//    [self.buttonimage.imageView insertSubview:img atIndex:0];
    
    [self.buttonimage setImage:sender forState:UIControlStateNormal];
    
}
@end
