//
//  SheZhiViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "SheZhiViewController.h"
#import "XiuGaiMMAViewController.h"


@interface SheZhiViewController ()

@end

@implementation SheZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BackColor;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title=@"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;

}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ChangeMImAAction:(id)sender {
    XiuGaiMMAViewController *Xvc =[[XiuGaiMMAViewController alloc]init];
    [self.navigationController pushViewController:Xvc animated:YES];
   
}



- (IBAction)ClealerAction:(id)sender {
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       //(@"files :%d",[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    
   }

-(void)clearCacheSuccess
{
    NSArray *aar =self.view.subviews;
    for (id dd in aar) {
        if ([dd isKindOfClass:[UIAlertView class]]) {
            [dd removeFromSuperview];
        }
    }
    AlView =[[UIAlertView alloc]initWithTitle:@"缓存清理" message:@"清理完成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [AlView show];
    
  }
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
 }


@end
