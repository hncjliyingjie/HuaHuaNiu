//
//  PlayVideoViewController.m
//  视频模块
//
//  Created by Vking on 16/1/6.
//  Copyright © 2016年 Vking. All rights reserved.
//

#import "PlayVideoViewController.h"
#import "KrVideoPlayerController.h"
#import "HGFindModel.h"
#import "HGHttpTool.h"

@interface PlayVideoViewController ()
@property (nonatomic, strong) KrVideoPlayerController  *videoController;
@end

@implementation PlayVideoViewController


-(void)viewWillAppear:(BOOL)animated
{
    
    [HGHttpTool getWirhUrl:[NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/video_detail.do?token=test&member_id=%@&video_id=%@",_member,_video.findModel.video_id] parms:nil success:^(id json) {
        
        NSLog(@"==========%@",json);
       
    } failture:^(id error) {
        
    }];
    
    [HGHttpTool getWirhUrl:[NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/video_comments.do?token=test&member_id=%@&video_id=%@&currentPage=1&showCount=5",_member,_video.findModel.video_id] parms:nil success:^(id json) {
        
        NSLog(@"-=-=-=-=-=-=-=-=-=%@",json);
        
    } failture:^(id error) {
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //播放视频
    [self playVideo];
    
    //显示评论
    
    [self memberList];
    

}

-(void)memberList
{
    
    NSLog(@"这里显示评论！");
    
    
}


- (void)playVideo{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://101.200.90.192:8090/%@",_video.findModel.path]];

    NSLog(@"%@",url);
    [self addVideoPlayerWithURL:url];
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0, 64, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
      
        [self.view addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.videoController stop];
}
- (void)didReceiveMemoryWarning {
    [super popoverPresentationController];
    // Dispose of any resources that can be recreated.
}

//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool{
    self.navigationController.navigationBar.hidden = Bool;
    self.tabBarController.tabBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}


@end
