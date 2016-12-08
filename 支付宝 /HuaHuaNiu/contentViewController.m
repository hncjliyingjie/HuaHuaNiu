//
//  contentViewController.m
//  MeiPinJie
//
//  Created by mac on 15/11/19.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "contentViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Reachability.h"
#import "commentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "commentTableViewCell.h"
#import "commentModel.h"
#import "ZQW_AppTools.h"
#import "doneTextView.h"
#import "HMFileManager.h"
#import "LCDownloadManager.h"
#import "ImagePickerViewController.h"
#import "ShareManger.h"
#import "FourViewController.h"
#define Krecultcaterypath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@interface contentViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
{
    
    CGFloat contentOffsetY;
    
    CGFloat oldContentOffsetY;
    
    CGFloat newContentOffsetY;
    
    int keyHeight;
    
    int textViewHeight;
    
    int discrepantHeight;
    
    int preferNumber;
    
    int pinglunlabel;
   // ASIHTTPRequest *videoRequest;
    unsigned long long Recordull;
    
    int offcount;
    BOOL isPlay;
    
    
}
@property (nonatomic, strong) AFHTTPRequestOperation *operation1;
@property (nonatomic,strong)UIScrollView *scrollview;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UIView *playView;
@property (nonatomic,strong)UIView *userView;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UIButton *headerButton;
@property (nonatomic,strong)UIButton *guanzhuButton;
@property (nonatomic,strong)UIView *guanzhuView;
@property (nonatomic,strong)UIView *preferView;
@property (nonatomic,strong)UIButton *preferButton;
@property (nonatomic,strong)UIView *shareView;
@property (nonatomic,strong)UIButton *shareButton;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *playTimes;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *preferLabel;
@property (nonatomic,strong)UILabel *pinglunLabel;
@property (nonatomic,strong)UILabel *fabulabel;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *text;
@property (nonatomic,strong)UIView *textBackground;
@property (nonatomic,strong)UIView *nimingView;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UITextView *backgroundTextView;
@property (nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVPlayerItem *playerItem; // 播放属性
@property(nonatomic,strong)UIProgressView *progress; // 缓冲条
@property(nonatomic,strong)UIButton *nimingButton;
@property(nonatomic,strong)UIImageView *like;
@property(nonatomic,strong)UIImageView *pinglun;
@property(nonatomic,strong)UIImageView *photoVideo;
@property(nonatomic,strong)UILabel *zuixinpinglun;
@property(nonatomic,strong)UIView *fengeView;
@property(nonatomic,strong)UIView *userViewxian;
@property(nonatomic,strong)UIImageView *preferanimation;
@end

@implementation contentViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
}


- (UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollview];
        
    }
    return _scrollview;
}




- (UIView *)contentView{
    if (!_contentView) {
        if (self.width > self.height) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDH, VIEW_HEIGHT - 120)];
        
        }else{
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDH, VIEW_HEIGHT - 64)];
       
        }
     //   _contentView.backgroundColor = [UIColor lightGrayColor];
        UITapGestureRecognizer* doubleRecognizer1;
        doubleRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTap)];
        doubleRecognizer1.delegate=self;
        doubleRecognizer1.numberOfTapsRequired = 1; // 单击
        [_contentView addGestureRecognizer:doubleRecognizer1];
        [_scrollview addSubview:_contentView];
        
    }
    return _contentView;
}



- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDH, VIEW_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.tableHeaderView = _contentView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
   //     _tableView.cellLayoutMarginsFollowReadableWidth = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     //   [_tableView setSeparatorInset:UIEdgeInsetsZero];
        [_tableView registerClass:[commentTableViewCell class] forCellReuseIdentifier:@"cell"];
        [_scrollview addSubview:_tableView];
        
    }
    return _tableView;
}

- (UIView *)playView{
    if (!_playView) {
        if (self.width > self.height) {
            _playView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_WIDH * 0.15, VIEW_WIDH, VIEW_WIDH * self.height / self.width)];
       //     NSLog(@"height %f",_playView.frame.size.height);
        }else{
        _playView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDH *0.15, 0, VIEW_WIDH * 0.85, VIEW_WIDH * 3.4 / 3)];
        }
        
        UITapGestureRecognizer* doubleRecognizer;
        doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dubleTap)];
        doubleRecognizer.delegate=self;
        doubleRecognizer.numberOfTapsRequired = 2; // 双击
        [_playView addGestureRecognizer:doubleRecognizer];
     //   _playView.backgroundColor = [UIColor grayColor];
        UITapGestureRecognizer* doubleRecognizer1;
        doubleRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTap)];
        doubleRecognizer1.delegate=self;
        doubleRecognizer1.numberOfTapsRequired = 1; // 单击
        [_playView addGestureRecognizer:doubleRecognizer1];
        
        [_contentView addSubview:_playView];
    }
    return _playView;
}

- (UIImageView *)photoVideo{
    if (!_photoVideo) {
        if (self.width > self.height) {
            _photoVideo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDH, VIEW_WIDH * self.height / self.width - 5)];
            
            //     NSLog(@"height %f",_playView.frame.size.height);
        }else{
            _photoVideo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDH * 0.85, VIEW_WIDH * 3.4 / 3 - 5)];
        }
        
        [_playView addSubview:_photoVideo];
        
    }
    return _photoVideo;
}

- (UIProgressView *)progress{
    if (!_progress) {
        _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, _playView.frame.size.height - 5, _playView.frame.size.width, 5)];
        _progress.progressTintColor = UIColorFromRGB(0xdd127b);
     //   NSLog(@"progress %f",_progress.frame.origin.y);
        [_playView addSubview:_progress];
    }
    return _progress;
}

- (UIView *)userView{
    if (!_userView) {
        
        if (self.width > self.height) {
            _userView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDH, VIEW_WIDH *0.15)];
            discrepantHeight = _userView.frame.size.height;
        }else{
        _userView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDH*0.15,   _playView.frame.size.height)];
            discrepantHeight = 0;
        }
        
        [_contentView addSubview:_userView];
        
    }
    return _userView;
}

- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (UIView *)text{
    if (!_text) {
        _text = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT, VIEW_WIDH, 60)];
         _text.backgroundColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDH, 0.5)];
        view.backgroundColor = UIColorFromRGB(0xe4e4e4);
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(59, 0, 0.5, _text.frame.size.height + 80)];
        view2.backgroundColor = UIColorFromRGB(0xe4e4e4);
        [_text addSubview:view2];
        [_text addSubview:view];
        [self.view addSubview:_text];
        
    }
    return _text;
}

- (UIView *)nimingView{
    if (!_nimingView) {
        _nimingView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 59, 60)];
        _nimingView.backgroundColor = [UIColor whiteColor];
        [_text addSubview:_nimingView];
    }
    return _nimingView;
}

- (UIButton *)nimingButton{
    if (!_nimingButton) {
        _nimingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nimingButton setFrame:CGRectMake(15, 15, 30, 30)];
        [_nimingButton setBackgroundImage:[UIImage imageNamed:@"quanzi-5"] forState:UIControlStateNormal];
        [_nimingButton addTarget:self action:@selector(niming) forControlEvents:UIControlEventTouchUpInside];
        [_nimingView addSubview:_nimingButton];
        
    }
    return _nimingButton;
}

- (NSDictionary *)resultDic{
    if (!_resultDic) {
        _resultDic = [[NSDictionary alloc] init];
    }
    return _resultDic;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(60, 10, VIEW_WIDH - 60, 40)];
      //  _textView.text = @"请输入...";
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = [UIColor lightGrayColor];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.returnKeyType = UIReturnKeySend;
    
        _textView.scrollEnabled = YES;
        _textView.delegate = self;
        
        [_text addSubview:_textView];
        
    }
    return _textView;
}

- (UIView *)textBackground{
    if (!_textBackground) {
        _textBackground = [[UIView alloc] initWithFrame:CGRectMake(60, 10, VIEW_WIDH - 60, 40)];
        _textBackground.backgroundColor = [UIColor whiteColor];
        [_text addSubview:_textBackground];
    }
    return _textBackground;
}


- (UITextView *)backgroundTextView{
    if (!_backgroundTextView) {
        _backgroundTextView = [[UITextView alloc] initWithFrame:CGRectMake(60, 10, VIEW_WIDH - 60, 40)];
        _backgroundTextView.text = @"请输入...";
        _backgroundTextView.textColor = [UIColor lightGrayColor];
        _backgroundTextView.font = [UIFont systemFontOfSize:16];
        _backgroundTextView.textAlignment = NSTextAlignmentLeft;
        _backgroundTextView.backgroundColor = [UIColor clearColor];
        [_text addSubview:_backgroundTextView];
    }
    return _backgroundTextView;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    [self scrollview];
    [self contentView];
    [self playView];
    [self progress];
    [self timeLabel];
    [self showUI];
    [self tableView];
    [self textBackground];
    [self text];
    [self nimingView];
    [self backgroundTextView];
    [self textView];
    [self nimingButton];
    NSLog(@"userid === %@",self.UserId);
    offcount = 1;
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
   
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
           NSLog(@"网络可用");
            [self getAFNetWorkingData];
            
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"网络不可用");
            NSString *fileName = [NSString stringWithFormat:@"resultDic%@.txt",self.ID];
            NSString *filename2 = [Krecultcaterypath stringByAppendingPathComponent:fileName];
            _resultDic = [NSDictionary dictionaryWithContentsOfFile:filename2];
            [self dataforView];
            
        });
    };
    [reach startNotifier];
   
 // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    if (self.VideoUrl.length == 0) {
        NSLog(@"不是视频，是图片%@",self.ThumbUrl);
        [self photoView];
        
        
        
        
    }else{
        [self photoVideo];
    NSString *url1 = [NSString stringWithFormat:@"%@%@",@"http://test.cdn2.p.meilianbao.net",self.ThumbUrl];
        UIColor *color1 = UIColorFromRGB(0x898992);
        UIColor *color2 = UIColorFromRGB(0x6b5b5c);
        UIColor *color3 = UIColorFromRGB(0x67695c);
        UIColor *color4 = UIColorFromRGB(0x676a5a);
        UIColor *color5 = UIColorFromRGB(0x655a6d);
        UIColor *color6 = UIColorFromRGB(0x52616e);
        NSArray *array = [NSArray arrayWithObjects:color1,color2,color3,color4,color5,color6, nil];
        int i =  arc4random() % 6;
        //  NSLog(@"imageurl == %@",imageurl);
     _photoVideo.backgroundColor = array[i];
    [_photoVideo sd_setImageWithURL:[NSURL URLWithString:url1]];
    _shareImage = _photoVideo.image;
    NSLog(@"share image == %@",_shareImage);
    
    NSString *url = [NSString stringWithFormat:@"%@%@",@"http://test.cdn2.p.meilianbao.net",self.VideoUrl];
    NSLog(@"url1111111 == %@",url);
    _fileName = [NSString stringWithFormat:@"video%@.mp4",self.ID];
    _fileUrl = [Krecultcaterypath stringByAppendingPathComponent:_fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:_fileUrl]){
        [self playVideo];
        self.downloadisSuccess = @"1";

        
    }else{
    self.operation1 = [LCDownloadManager downloadFileWithURLString:url cachePath:_fileName progress:^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
        
        NSLog(@"Task1 -> progress: %.2f -> download: %fMB -> all: %fMB", progress, totalMBRead, totalMBExpectedToRead);
        self.progress.progress = progress;
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Task1 -> Download finish");
      //  [_progress setHidden:YES];
        self.downloadisSuccess = @"1";
        [_photoVideo removeFromSuperview];
        [self playVideo];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error.code == -999) NSLog(@"Task1 -> Maybe you pause download.");
        
        NSLog(@"Task1 -> %@", error);
    }];

    }
    }
    
    [self addfooder];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
  //  self.navigationController.interactivePopGestureRecognizer.delegate = self;
}









- (void)playVideo{
    
  //  self.progress.progress = 1;
    NSString *videoFile = [NSString stringWithFormat:@"%@%@",@"file://",_fileUrl];
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:videoFile]];
    NSLog(@"存在 %@",_fileUrl);
    NSLog(@"playeritem == %@",self.playerItem);
    self.player = [AVPlayer playerWithPlayerItem:_playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame = CGRectMake(0, 0,_playView.frame.size.width, _playView.frame.size.height-5);
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    [_playView.layer addSublayer:playerLayer];
    [_player play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)photoView{
    NSString *url = [NSString stringWithFormat:@"%@%@",@"http://test.cdn2.p.meilianbao.net",self.ThumbUrl];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _playView.frame.size.width, _playView.frame.size.height)];
    UIColor *color1 = UIColorFromRGB(0x898992);
    UIColor *color2 = UIColorFromRGB(0x6b5b5c);
    UIColor *color3 = UIColorFromRGB(0x67695c);
    UIColor *color4 = UIColorFromRGB(0x676a5a);
    UIColor *color5 = UIColorFromRGB(0x655a6d);
    UIColor *color6 = UIColorFromRGB(0x52616e);
    NSArray *array = [NSArray arrayWithObjects:color1,color2,color3,color4,color5,color6, nil];
    int i =  arc4random() % 6;
    //  NSLog(@"imageurl == %@",imageurl);
    image.backgroundColor = array[i];
    [image sd_setImageWithURL:[NSURL URLWithString:url]];
    _shareImage = image.image;
    NSLog(@"share image == %@",_shareImage);
    [self.playView addSubview:image];
    
}

- (void)niming{
   
    _nimingButton.selected = !_nimingButton.selected;
    if (_nimingButton.selected) {
        [_nimingButton setBackgroundImage:[UIImage imageNamed:@"quanzi1-3"] forState:UIControlStateNormal];
        self.isAnonymous = @"1";
    }else{
        [_nimingButton setBackgroundImage:[UIImage imageNamed:@"quanzi-5"] forState:UIControlStateNormal];
        self.isAnonymous = @"0";
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = [UIColor whiteColor];
    [self datasource];
    [self getDatesourceForCell];
    
    [_player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain",nil];
    NSString *url = @"http://stat.meilianbao.net/re/ipage.ashx?userId=%@&url=/ios/HairShow/Detail/%@";
    NSString *urlstr = [NSString stringWithFormat:url,self.UserId,self.ID];
    [manager POST:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *tongji = responseObject[@"pid"];
        _tongji = tongji;
        NSLog(@"responseObject== %@",_tongji);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail == %@",error);
    }];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logininback:) name:@"haishowLogin" object:nil];
    

    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
 //   [_player replaceCurrentItemWithPlayerItem:nil];
    if (![self.downloadisSuccess isEqualToString:@"1"] && self.VideoUrl.length != 0) {
         NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *videoFile = [NSString stringWithFormat:@"%@%@",@"file://",_fileUrl];
        [fileManager removeItemAtURL:[NSURL URLWithString:videoFile] error:nil];
       
    }
    
}

- (void)logininback:(NSNotification *)sender{
    [_player play];
    self.UserId = sender.userInfo[@"UserId"];
  
}

- (void)keyboardWillHide:(NSNotification *)aNotification{
    [_text setFrame:CGRectMake(0, VIEW_HEIGHT - 60, VIEW_WIDH, 60)];
    _textView.text = @"";
    [_textView setFrame:CGRectMake(60, 10, VIEW_WIDH - 60, 40)];
    
    [_backgroundTextView setFrame:CGRectMake(60, 10, VIEW_WIDH - 60, 40)];
    [_backgroundTextView setHidden:NO];
    [_nimingView setFrame:CGRectMake(0, 1, 59, 60)];
    _backgroundTextView.text = @"请输入...";
    textViewHeight = 0;
    self.replyUserid = @"0";
    
    self.isWrite =@"0";
}

- (void)dubleTap{
    int userId = [self.UserId intValue];
    if (userId == 0 || userId == -1) {
        SecondViewController *second = [[SecondViewController alloc] init];
        second.currentUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",USER_URL,@"login"]];
        second.isHairShow = @"1";
        [_player pause];
        [self presentViewController:second animated:YES completion:^{
            
        }];
    }else{
    _preferanimation = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"show2-2"]];
    [_preferanimation setFrame:CGRectMake(_playView.frame.size.width/2 - 5, _playView.frame.size.height/2 - 5, 10, 10)];
    [_playView addSubview:_preferanimation];
    [UIView animateWithDuration:0.1 animations:^{
        [_preferanimation setFrame:CGRectMake(_playView.frame.size.width/2 - 75, _playView.frame.size.height/2 - 75, 150, 150)];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            [_preferanimation setFrame:CGRectMake(_playView.frame.size.width/2 - 65, _playView.frame.size.height/2 - 65, 130, 130)];
            
        } completion:^(BOOL finished) {
            
//            [imageiew removeFromSuperview];
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            animation.fromValue = [NSNumber numberWithFloat:1.0f];
            animation.toValue = [NSNumber numberWithFloat:0.0f];
            animation.autoreverses = YES;
            animation.duration = 0.6f;
            animation.repeatCount = 0.5;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            [_preferanimation.layer addAnimation:animation forKey:nil];
            
        }];
    }];
   
    
    NSString *string = [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/HairShow/SetUpCollect/"];
    NSString *post = [NSString stringWithFormat:@"%@%@",string,self.ID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",nil];
    if (_preferButton.selected == NO) {
       NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.UserId, @"UserId",@"1",@"isCollect", nil];
        [manager POST:post parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            preferNumber = preferNumber + 1;
            NSString *prefer = [NSString stringWithFormat:@"%d",preferNumber];
            [_preferButton setBackgroundImage:[UIImage imageNamed:@"show2-2"] forState:UIControlStateNormal];
            _preferLabel.text = [NSString stringWithFormat:@"%@%@",prefer,@"人喜欢"];
            _preferButton.selected = YES;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }
    
    }
}

- (void)oneTap{
    if (![self.isWrite isEqualToString:@"1"]) {
        NSLog(@"单击playerview");
    }else{
        [self.textView resignFirstResponder];
    }
    
}


//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    [_player pause];
   self.isWrite = @"1";
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyHeight = keyboardRect.size.height;
    NSLog(@"keyheight == %d",keyHeight);
    [UIView animateWithDuration:.25 animations:^{
        if (iPhone6Plus) {
            [_text setFrame:CGRectMake(0, 410, VIEW_WIDH, _text.frame.size.height)];
        }else{
        [_text setFrame:CGRectMake(0, keyHeight+5, VIEW_WIDH, _text.frame.size.height)];
        }
    }];
    
}

#pragma mark -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
      //  NSLog(@"进度%f",timeInterval);
        //        NSLog(@"Time Interval:%f",timeInterval);
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        
        [self.progress setProgress:timeInterval / totalDuration animated:NO];
        if (self.progress.progress == 1) {
            NSLog(@"缓存完成%@",self.playerItem);
            [_progress setHidden:YES];
            [_photoVideo removeFromSuperview];
            
            
            }
    }
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
  
    NSLog(@"start  %f",startSeconds);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSLog(@"dur == %f",durationSeconds);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (void)moviePlayDidEnd:(NSNotification *)sender
{
      
    AVPlayerItem *p = [sender object];
    [p seekToTime:kCMTimeZero];
    [_player play];
    
    
}


-(void)setupUI{
    //创建播放器层
    AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame=CGRectMake(0, 0, VIEW_WIDH, VIEW_HEIGHT);
    //playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;//视频填充模式
    [self.view.layer addSublayer:playerLayer];
}



- (void)showUserView{
    [self userView];
    _userViewxian = [[UIView alloc] init];
    if (self.width > self.height) {
        if (iPhone6Plus) {
           [_userViewxian setFrame:CGRectMake(20, VIEW_WIDH * 0.075, 290, 1)];
        }else{
        [_userViewxian setFrame:CGRectMake(20, VIEW_WIDH * 0.075, 250, 1)];
        }
    }else{
        if (iPhone6Plus) {
             [_userViewxian setFrame:CGRectMake(VIEW_WIDH * 0.075, 20, 1, 350)];
        }else{
      [_userViewxian setFrame:CGRectMake(VIEW_WIDH * 0.075, 20, 1, 250)];
        }
    }
    _userViewxian.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_userView addSubview:_userViewxian];
    
    if (self.width > self.height) {
    _headView = [[UIView alloc] initWithFrame:CGRectMake(20, VIEW_WIDH * 0.025, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
    }else{
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.025, 20, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
    }
    
    _headView.backgroundColor = UIColorFromRGB(0xefefef);
    _headView.layer.masksToBounds = YES;
    _headView.layer.cornerRadius = VIEW_WIDH * 0.055;
    _headView.layer.borderWidth = 1;
    _headView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    
    
    
    _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headerButton setFrame:CGRectMake(3, 3, VIEW_WIDH * 0.11 - 6, VIEW_WIDH * 0.11 - 6)];
    [_headerButton addTarget:self action:@selector(UserViewAction:) forControlEvents:UIControlEventTouchUpInside];
    _headerButton.tag = 1;
    _headerButton.layer.masksToBounds = YES;
    _headerButton.layer.cornerRadius = (VIEW_WIDH * 0.11 - 6)/2;
    _headerButton.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:_headerButton];
    [_userView addSubview:_headView];
    
    if (self.width > self.height) {
        if (iPhone6Plus) {
            _guanzhuView = [[UIView alloc] initWithFrame:CGRectMake( 110,VIEW_WIDH * 0.025, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11 )];
        }else{
        _guanzhuView = [[UIView alloc] initWithFrame:CGRectMake( 95,VIEW_WIDH * 0.025, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11 )];
        }
    }else{
        if (iPhone6Plus) {
            _guanzhuView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.025, 130, VIEW_WIDH * 0.11 , VIEW_WIDH * 0.11 )];
        }else{
    _guanzhuView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.025, 95, VIEW_WIDH * 0.11 , VIEW_WIDH * 0.11 )];
        }
    }
    _guanzhuView.backgroundColor = UIColorFromRGB(0xefefef);
    _guanzhuView.layer.masksToBounds = YES;
    _guanzhuView.layer.cornerRadius = (VIEW_WIDH * 0.11 )/2;
    _guanzhuView.layer.borderColor =  UIColorFromRGB(0xe5e5e5).CGColor;
    
    _guanzhuView.layer.borderWidth = 1;
    
    _guanzhuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_guanzhuButton setFrame:CGRectMake(3, 3, VIEW_WIDH * 0.11 - 6, VIEW_WIDH * 0.11 - 6)];
    [_guanzhuButton setBackgroundImage:[UIImage imageNamed:@"haishowguanzhu"] forState:UIControlStateNormal];
    [_guanzhuButton addTarget:self action:@selector(UserViewAction:) forControlEvents:UIControlEventTouchUpInside];
    _guanzhuButton.tag = 2;
    _guanzhuButton.layer.masksToBounds = YES;
    _guanzhuButton.layer.cornerRadius = (VIEW_WIDH * 0.11 - 6)/2;
   
    [_guanzhuView addSubview:_guanzhuButton];
    [_userView addSubview:_guanzhuView];
    
    if (self.width > self.height) {
        if (iPhone6Plus) {
           _preferView = [[UIView alloc] initWithFrame:CGRectMake( 200, VIEW_WIDH * 0.025,VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
        }else{
         _preferView = [[UIView alloc] initWithFrame:CGRectMake( 170, VIEW_WIDH * 0.025,VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
        }
    }else{
        if (iPhone6Plus) {
            _preferView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.025, 240, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
        }else{
    _preferView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.025, 170, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
        }
    }
    _preferView.backgroundColor = UIColorFromRGB(0xefefef);
    _preferView.layer.masksToBounds = YES;
    _preferView.layer.cornerRadius = VIEW_WIDH * 0.055;
    _preferView.layer.borderColor =  UIColorFromRGB(0xe5e5e5).CGColor;
    
    _preferView.layer.borderWidth = 1;
    
    _preferButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_preferButton setFrame:CGRectMake(3, 3, VIEW_WIDH * 0.11 - 6, VIEW_WIDH * 0.11 - 6)];
    [_preferButton addTarget:self action:@selector(UserViewAction:) forControlEvents:UIControlEventTouchUpInside];
    _preferButton.tag = 3;
    _preferButton.layer.masksToBounds = YES;
    _preferButton.layer.cornerRadius = (VIEW_WIDH * 0.11 - 6)/2;
    
    
    [_preferView addSubview:_preferButton];
    [_userView addSubview:_preferView];
    
    if (self.width > self.height) {
        if (iPhone6Plus) {
            _shareView = [[UIView alloc] initWithFrame:CGRectMake( 290, VIEW_WIDH * 0.025,VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
        }else{
        _shareView = [[UIView alloc] initWithFrame:CGRectMake( 250, VIEW_WIDH * 0.025,VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
        }
    }else{
        if (iPhone6Plus) {
            _shareView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.025, 350, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
        }else{
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.025, 250, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
        }
    }
    _shareView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    _shareView.layer.masksToBounds = YES;
    _shareView.layer.cornerRadius = VIEW_WIDH * 0.055;
    _shareView.layer.borderColor =  UIColorFromRGB(0xe5e5e5).CGColor;
    
    _shareView.layer.borderWidth = 1;
    
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareButton setFrame:CGRectMake(4, 4, VIEW_WIDH * 0.11 - 8, VIEW_WIDH * 0.11 - 8)];
    [_shareButton addTarget:self action:@selector(UserViewAction:) forControlEvents:UIControlEventTouchUpInside];
    _shareButton.tag = 4;
//    _shareButton.layer.masksToBounds = YES;
//    _shareButton.layer.cornerRadius = (VIEW_WIDH * 0.11 - 6)/2;
    [_shareButton setBackgroundImage:[UIImage imageNamed:@"show2-5"] forState:UIControlStateNormal];
    [_shareView addSubview:_shareButton];
    [_userView addSubview:_shareView];
    
    
}

- (void) showUI{
    
    [self showUserView];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDH - 140, _playView.frame.size.height + discrepantHeight, 130, 17)];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.textAlignment = UITextAlignmentRight;
    [_contentView addSubview:_timeLabel];
    
    _playTimes = [[UILabel alloc] initWithFrame:CGRectMake(_playView.frame.origin.x + 10 , _playView.frame.size.height + discrepantHeight, 130, 17)];
    _playTimes.backgroundColor = [UIColor clearColor];
    _playTimes.textAlignment = UITextAlignmentLeft;
    _playTimes.font = [UIFont systemFontOfSize:14];
    _playTimes.textColor = [UIColor lightGrayColor];
    [_contentView addSubview:_playTimes];
    
    
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _nameLabel.textAlignment = UITextAlignmentLeft;
    _nameLabel.numberOfLines = 0;
    [_nameLabel setFont:[UIFont systemFontOfSize:14]];
    _nameLabel.textColor = [UIColor lightGrayColor];
    
    
    
    _nameLabel.backgroundColor = [UIColor whiteColor];
  //  _nameLabel.textColor = UIColorFromRGB(0xdd127b);
    [_contentView addSubview:_nameLabel];
    
    _fengeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _fengeView.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_contentView addSubview:_fengeView];
 
    
    UIImageView *nameimage = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.075 - 7, _playView.frame.size.height + 25 + discrepantHeight, 20, 20)];
    nameimage.image = [UIImage imageNamed:@"show2-6"];
    
    _like = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.075 - 7,_playView.frame.size.height  + 55 + discrepantHeight, 20, 20)];
    _like.image = [UIImage imageNamed:@"show2-7"];
    
    _pinglun = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.077 - 7, _playView.frame.size.height + 80  +  discrepantHeight, 20, 20)];
    _pinglun.image = [UIImage imageNamed:@"show2-8"];
    
    [_contentView addSubview:nameimage];
    [_contentView addSubview:_like];
    [_contentView addSubview:_pinglun];
    
    
    
    _preferLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.15, _playView.frame.size.height + 70 + discrepantHeight, 200, 20)];
    _preferLabel.textAlignment = UITextAlignmentLeft;
    [_preferLabel setFont:[UIFont systemFontOfSize:14]];
    _preferLabel.textColor = UIColorFromRGB(0xdd127b);
    [_contentView addSubview:_preferLabel];
    
    _pinglunLabel= [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDH * 0.15, _playView.frame.size.height + 100 + discrepantHeight, 80, 20)];
    _pinglunLabel.textAlignment = UITextAlignmentLeft;
    [_pinglunLabel setFont:[UIFont systemFontOfSize:14]];
  //  _pinglunLabel.text = @"0 评论";
  //  _pinglunLabel.textColor = [UIColor whiteColor];
    [_contentView addSubview:_pinglunLabel];
    
    _scrollview.contentSize = CGSizeMake(0, _contentView.frame.size.height + _tableView.frame.size.height);
   
}

-(void)createNav{
    UIView * navView ;
    if (IOS6) {
        navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDH, 44)];
    }else{
        navView =[[UIView alloc]initWithFrame:CGRectMake(0, 20, VIEW_WIDH, 44)];
    }
    
    navView.backgroundColor =UIColorFromRGB(0xdd127b);
    
    //标题
    self.titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(55, 7, VIEW_WIDH-55*2, 30)];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.titleLabel.textColor =[UIColor whiteColor];
    self.titleLabel.text =@"美发师秀";
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    [navView addSubview:self.titleLabel];
    
    
    //左btn
    UIButton * leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.tag =BTN_TAG+1;
    leftBtn.frame =CGRectMake(0, 0, 44, 44);
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //左IV
    UIImageView * leftIV =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 34, 34)];
    [leftIV setImage:[UIImage imageNamed:@"back"]];
    
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(VIEW_WIDH - 64, 0, 54, 44);
//    [rightButton addTarget:self action:@selector(paisheController) forControlEvents:UIControlEventTouchUpInside];
//    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
//    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [navView addSubview:rightButton];
    [navView addSubview:leftIV];
    [navView addSubview:leftBtn];
    
    [self.view addSubview:navView];
    
}

- (void)UserViewAction:(UIButton *)sender{
    int userId = [self.UserId intValue];
    if (sender.tag == 1) {
        NSLog(@"个人主页");
        FourViewController *four = [[FourViewController alloc] init];
        four.currentUrl =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",QUANZI_URL,@"/User/Index/",_resultDic[@"UserId"]]];
        [_player pause];
        four.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:four animated:YES];
        
        
    }else if (sender.tag == 2){
        if (userId == 0 || userId == -1) {
            NSString *string = @"您未登录，请先登录";
            ALERT_MSG(string);
            return;
        }
        NSString *string = [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/Other/SetUpFocus/"];
        NSString *writerID = [NSString stringWithFormat:@"%@",_resultDic[@"UserId"]];
        NSString *post = [NSString stringWithFormat:@"%@%@",string,writerID];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",nil];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.UserId,@"userId", nil];
        [manager POST:post parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"关注成功");
            if (self.width > self.height) {
                [_guanzhuView setHidden:YES];
                [UIView animateWithDuration:0.3f animations:^{
                    if (iPhone6Plus) {
                        [_preferView setFrame:CGRectMake( 110,VIEW_WIDH * 0.025, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                        [_shareView setFrame:CGRectMake( 200, VIEW_WIDH * 0.025,VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                        [_userViewxian setFrame:CGRectMake(20, VIEW_WIDH * 0.075, 200 , 1)];
                    }else{
                    [_preferView setFrame:CGRectMake( 95,VIEW_WIDH * 0.025, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                    [_shareView setFrame:CGRectMake( 170, VIEW_WIDH * 0.025,VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                    [_userViewxian setFrame:CGRectMake(20, VIEW_WIDH * 0.075, 170 , 1)];
                    }
                }];
                
            }else{
                [_guanzhuView setHidden:YES];
                [UIView animateWithDuration:0.3f animations:^{
                    if (iPhone6Plus) {
                        [_preferView setFrame:CGRectMake(VIEW_WIDH * 0.025, 130, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                        [_shareView setFrame:CGRectMake(VIEW_WIDH * 0.025, 240, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                        [_userViewxian setFrame:CGRectMake(VIEW_WIDH * 0.075, 20, 1, 240)];
                    }else{
                    
                    
                    [_preferView setFrame:CGRectMake(VIEW_WIDH * 0.025, 95, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                    [_shareView setFrame:CGRectMake(VIEW_WIDH * 0.025, 170, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                    [_userViewxian setFrame:CGRectMake(VIEW_WIDH * 0.075, 20, 1, 170)];
                    }
                    
                }];
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }else if (sender.tag == 3){
        
        if (userId == 0 || userId == -1) {
            SecondViewController *second = [[SecondViewController alloc] init];
            second.currentUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",USER_URL,@"login"]];
            second.isHairShow = @"1";
            [_player pause];
            [self presentViewController:second animated:YES completion:^{
                
            }];
        }else{
        sender.selected = !sender.selected;
        NSString *string = [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/HairShow/SetUpCollect/"];
        NSString *post = [NSString stringWithFormat:@"%@%@",string,self.ID];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",nil];
        if (sender.selected) {
            NSLog(@"我就是大事 ");
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.UserId, @"UserId",@"1",@"isCollect", nil];
            [manager POST:post parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                preferNumber = preferNumber + 1;
                NSString *prefer = [NSString stringWithFormat:@"%d",preferNumber];
                [_preferButton setBackgroundImage:[UIImage imageNamed:@"show2-2"] forState:UIControlStateNormal];
                 _preferLabel.text = [NSString stringWithFormat:@"%@%@",prefer,@"人喜欢"];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            
        }else{
            preferNumber = preferNumber - 1;
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.UserId, @"UserId",@"0",@"isCollect", nil];
            [manager POST:post parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [_preferButton setBackgroundImage:[UIImage imageNamed:@"show2-7"] forState:UIControlStateNormal];
                _preferLabel.text = [NSString stringWithFormat:@"%d%@",preferNumber,@"人喜欢"];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            [_preferButton setBackgroundImage:[UIImage imageNamed:@"show2-7"] forState:UIControlStateNormal];
        }
        }
        
        
    }else if (sender.tag == 4) {
        NSLog(@"image = %@",_shareImage);
        NSData *data;
        if (UIImagePNGRepresentation(_shareImage) == nil) {
            
            data = UIImageJPEGRepresentation(_shareImage, 1);
            
        } else {
            
            data = UIImagePNGRepresentation(_shareImage);
        }
        NSString *string = [NSString stringWithFormat:@"%@",_shareUrl];
        NSLog(@"shareurl == %@",string);
       // NSString *string = _resultDic[]
        NSString *context;
        if ([_resultDic[@"Description"] isEqualToString:@""]) {
            context = @"移动掌上学院，美发行业电子百科全书，边学习边赚钱的超级平台!";
        }else{
            context = _resultDic[@"Description"];
        }
        
        [[ShareManger share] shareWithTitle:@"美发师秀" context:context imagePath:nil imageData:data  url:string viewcontroller:self];
    }
}


- (void)back{
    [_player pause];
    [_player replaceCurrentItemWithPlayerItem:nil];
    [_playView removeFromSuperview];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain",nil];
    NSString *url = @"http://stat.meilianbao.net/re/ipage.ashx?id=%@";
    NSString *urlstr = [NSString stringWithFormat:url,self.tongji];
    [manager POST:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"回调成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"回调失败");
    }];

    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getAFNetWorkingData
{
    NSString *urlStr = @"/HairShow/GetHairShow/%@?userId=%@";
    NSString *str = [NSString stringWithFormat:@"%@%@",MAIN_URL,urlStr];
    NSLog(@"self.userid ==== %@",self.UserId);
    if (!self.UserId) {
        self.UserId = @"0";
    }
    NSString *url = [NSString stringWithFormat:str,self.ID,self.UserId];
   // NSLog(@"url == %@",url);
    [ZQW_AppTools getMessage:url Block:^(id result) {
        NSLog(@"result111 == %@",result[@"Data"]);
        NSLog(@"trips == %@",result[@"Tips"]);
        _shareUrl = result[@"Tips"];
        _resultDic = result[@"Data"];
     //   _pinglunLabel.text = [NSString stringWithFormat:@"%d%@",pinglunlabel,@" 评论"];
        [self dataforView];
        
        
        
    } and:^(id result1) {
        NSLog(@"result === %@",result1);
        
    }];
    
}


- (void)dataforView{
    NSLog(@"isfocus === %@",_resultDic[@"IsFocus"]);
    NSString *isfocus = _resultDic[@"IsFocus"];
    
    NSLog(@"commentcount === %@",_resultDic[@"CommentCount"]);
    if (![self.ispinglun isEqualToString:@"1"]) {
        pinglunlabel = [_resultDic[@"CommentCount"] intValue];
        _pinglunLabel.text = [NSString stringWithFormat:@"%d%@",pinglunlabel,@" 评论"];
        NSLog(@"focus === %@",isfocus);
    }
    self.ispinglun = @"0";
    int a = [isfocus intValue];
    if (a == 1) {
        
        if (self.width > self.height) {
            [_guanzhuView setHidden:YES];
            [UIView animateWithDuration:0.3f animations:^{
                if (iPhone6Plus) {
                    [_preferView setFrame:CGRectMake( 110,VIEW_WIDH * 0.025, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                    [_shareView setFrame:CGRectMake( 200, VIEW_WIDH * 0.025,VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                    [_userViewxian setFrame:CGRectMake(20, VIEW_WIDH * 0.075, 200 , 1)];
                }else{
                [_preferView setFrame:CGRectMake( 95,VIEW_WIDH * 0.025, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                [_shareView setFrame:CGRectMake( 170, VIEW_WIDH * 0.025,VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                [_userViewxian setFrame:CGRectMake(20, VIEW_WIDH * 0.075, 170 , 1)];
                }
            }];
            
        }else{
            [_guanzhuView setHidden:YES];
            [UIView animateWithDuration:0.3f animations:^{
                if (iPhone6Plus) {
                    [_preferView setFrame:CGRectMake(VIEW_WIDH * 0.025, 130, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                    [_shareView setFrame:CGRectMake(VIEW_WIDH * 0.025, 240, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                    [_userViewxian setFrame:CGRectMake(VIEW_WIDH * 0.075, 20, 1, 240)];
                }else{
                [_preferView setFrame:CGRectMake(VIEW_WIDH * 0.025, 95, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                [_shareView setFrame:CGRectMake(VIEW_WIDH * 0.025, 170, VIEW_WIDH * 0.11, VIEW_WIDH * 0.11)];
                [_userViewxian setFrame:CGRectMake(VIEW_WIDH * 0.075, 20, 1, 170)];
                }
            }];
            
        }
    }
    
    
    
    
    NSString *fileName = [NSString stringWithFormat:@"resultDic%@.txt",self.ID];
    NSString *filename2 = [Krecultcaterypath stringByAppendingPathComponent:fileName];
    [_resultDic writeToFile:filename2 atomically:YES];
    NSString *user = [NSString stringWithFormat:@"%@%@%@%@",MAIN_URL,@"upload/",_resultDic[@"UserId"],@"/avator.png"];
    UIImageView *image = [[UIImageView alloc] init];
    [image sd_setImageWithURL:[NSURL URLWithString:user] placeholderImage:[UIImage imageNamed:@"hairshow_default_icon"]];
    
    [_headerButton setBackgroundImage:image.image forState:UIControlStateNormal];
    
    
    _timeLabel.text = _resultDic[@"CreateTimeStr"];
    NSString *playTimes = [NSString stringWithFormat:@"%@%@",_resultDic[@"PlayCount"],@"次播放"];
    _playTimes.text = playTimes;
    NSString *name = _resultDic[@"Description"];
    NSString *length = [NSString stringWithFormat:@"%@%@",_resultDic[@"UserName"],@" :"];
    NSInteger range = length.length;
    NSString *nameText;
    if (name.length == 0) {
        nameText = [NSString stringWithFormat:@"%@%@%@",_resultDic[@"UserName"],@" : ",@"发布"];
    }else{
        nameText = [NSString stringWithFormat:@"%@%@%@",_resultDic[@"UserName"],@" : ",name];
    }
  //  NSInteger rangeEnd = nameText.length;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:nameText];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xdd127b) range:NSMakeRange(0,range)];
  //  NSInteger range1 = range + 1;
   // [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(range1, rangeEnd)];
    
    _nameLabel.attributedText = str;
    CGFloat height = [self contentHeight:_nameLabel];
    [_nameLabel setFrame:CGRectMake(VIEW_WIDH * 0.15, _playView.frame.size.height + 27 + discrepantHeight, VIEW_WIDH * 0.85, height)];
   
    _preferLabel.text = [NSString stringWithFormat:@"%@%@",_resultDic[@"PointCount"],@"人喜欢"];
    [_preferLabel setFrame: CGRectMake(VIEW_WIDH * 0.15, _playView.frame.size.height + height + 31 + discrepantHeight, 200, 20)];
    [_pinglunLabel setFrame: CGRectMake(VIEW_WIDH * 0.15, _playView.frame.size.height + 56 + height +  discrepantHeight, 80, 20)];
    
    [_like setFrame: CGRectMake(VIEW_WIDH * 0.075 - 7,_playView.frame.size.height + height + 31 + discrepantHeight, 20, 20)];
    
    [_pinglun setFrame: CGRectMake(VIEW_WIDH * 0.077 - 7, _playView.frame.size.height + 55 + height +  discrepantHeight, 20, 20)];
    
    
    
    if (self.width > self.height) {
        [_contentView setFrame: CGRectMake(0, 0, VIEW_WIDH, _playView.frame.size.height + 60 + height +  discrepantHeight + 70)];
        _tableView.tableHeaderView = _contentView;
       
    }else{
        [_contentView setFrame: CGRectMake(0, 0, VIEW_WIDH, _playView.frame.size.height + 60 + height +  discrepantHeight + 70)];
        _tableView.tableHeaderView = _contentView;
    }
   
     [_fengeView setFrame:CGRectMake(0, _contentView.frame.size.height - 45, VIEW_WIDH, 10)];
    [_zuixinpinglun setFrame:CGRectMake(10, _contentView.frame.size.height - 25, VIEW_WIDH, 20)];
   
    
    
    NSString *prefer = _resultDic[@"PointCount"];
    preferNumber = [prefer intValue];
    NSString *IsPoint = [NSString stringWithFormat:@"%@",_resultDic[@"IsPoint"]];
    NSLog(@"resultPoint ==== %@",IsPoint);
    if ([IsPoint isEqualToString:@"0"]) {
        
        [_preferButton setBackgroundImage:[UIImage imageNamed:@"show2-7"] forState:UIControlStateNormal];
    }else{
        [_preferButton setBackgroundImage:[UIImage imageNamed:@"show2-2"] forState:UIControlStateNormal];
        _preferButton.selected = YES;
    }
    
}

- (void)addfooder{
    [self.tableView addFooterWithCallback:^{
        offcount += 1;
        [self getDatesourceForCell];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            //   [self.collectionView reloadData];
            [self.tableView footerEndRefreshing];
        });
    }];
}


- (void)getDatesourceForCell{
    NSString *urlStr = @"/Other/LoadComment/%@?pageIndex=%d";
    NSString *str = [NSString stringWithFormat:@"%@%@",MAIN_URL,urlStr];
    NSString *url = [NSString stringWithFormat:str,self.ID,offcount];
    NSLog(@"URL == %@",url);
    [ZQW_AppTools getMessage:url Block:^(id result) {
        NSLog(@"result11111111111 == %@",result[@"Data"]);
        NSArray *array = result[@"Data"];
        if (array.count == 0) {
            offcount = 1;
        }
        
        for (NSDictionary *dic in result[@"Data"]) {
            
            commentModel *model = [commentModel new];
            [model initwithDictionary:dic];
            NSLog(@"%@",model.replyContent);
            [self.datasource addObject:model];
            }
    //    NSLog(@"self.datasourxe == %@",self.datasource);
    //    _pinglunLabel.text = [NSString stringWithFormat:@"%lu%@",(unsigned long)self.datasource.count,@" 评论"];
        
        self.ispinglun = @"0";
        if (self.datasource.count != 0) {
            _zuixinpinglun = [[UILabel alloc] initWithFrame:CGRectMake(10,_contentView.frame.size.height - 25, VIEW_WIDH/2, 20)];
            _zuixinpinglun.text = @"最新评论";
            [_zuixinpinglun setFont:[UIFont systemFontOfSize:15]];
            _zuixinpinglun.textColor = UIColorFromRGB(0xdd127b);
            _zuixinpinglun.textAlignment = UITextAlignmentLeft;
            [_contentView addSubview:_zuixinpinglun];
        }
        [self.tableView reloadData];
        
    } and:^(id result1) {
        
    }];
    
}






#pragma mark - tableViewdelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    commentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    commentModel *Model = self.datasource[indexPath.item];
    if (self.datasource.count > 0) {
        cell.UserLabel.text = Model.UserName;
    //    NSLog(@"username == %@",cell.UserLabel.text);
        cell.content.text = Model.Content;
    //    NSLog(@"concent == %@",cell.content.text);
        cell.timeLabel.text = Model.time;
      //  NSLog(@"timelabel = %@",Model.replyContent);
        if ([Model.replyContent isKindOfClass:[NSNull class]]) {
       //     NSLog(@"%ld,没有吗",(long)indexPath.row);
            
            [cell.replyContent removeFromSuperview];
            [cell.ReplyView removeFromSuperview];
            [cell.jianView removeFromSuperview];
        }else{
            [cell addSubview:cell.jianView];
            [cell addSubview:cell.ReplyView];
            [cell addSubview:cell.replyContent];
        //    NSLog(@"%ld,有",(long)indexPath.row);
        NSString *steing = [NSString stringWithFormat:@"%@%@%@",Model.replyUserName,@" : ",Model.replyContent];
      //  NSLog(@"string == %@",steing);
        cell.replyContent.text = steing;
        }
        
        NSString *user = [NSString stringWithFormat:@"%@%@%@%@",MAIN_URL,@"upload/",Model.UserImage,@"/avator.png"];
        [cell.UserImage sd_setImageWithURL:[NSURL URLWithString:user] placeholderImage:[UIImage imageNamed:@"hairshow_default_icon"]];
        
        
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    commentModel *Model = self.datasource[indexPath.item];
    
    return [commentTableViewCell cellHeightWithModel:Model];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 70;
//}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self.isWrite isEqualToString:@"1"]) {
        [self.textView becomeFirstResponder];
        commentModel *Model = self.datasource[indexPath.item];
        NSLog(@"datasourcr === %@",self.datasource[indexPath.item]);
        self.replyUserid = Model.userId;
        NSLog(@"self.replyuserid === %@",self.replyUserid);
        NSString *UserName = Model.UserName;
        NSString *context = [NSString stringWithFormat:@"%@%@%@",@"回复",UserName,@":"];
        _backgroundTextView.text = context;
    }else{
        [self.textView resignFirstResponder];
    }
    NSLog(@"点击");
    
}





#pragma mark -  ScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView

{
    
    contentOffsetY = scrollView.contentOffset.y;
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
     newContentOffsetY = scrollView.contentOffset.y;
    if (newContentOffsetY > oldContentOffsetY) {  // 向上滚动
        if (_text.frame.origin.y == VIEW_HEIGHT) {
            [UIView animateWithDuration:0.3f animations:^{
                [_text setFrame:CGRectMake(0, VIEW_HEIGHT - 60, VIEW_WIDH, 60)];
                [_tableView setFrame:CGRectMake(0, 0, VIEW_WIDH, VIEW_HEIGHT - 124)];
            }];
        }
    } else if (newContentOffsetY < oldContentOffsetY && oldContentOffsetY < contentOffsetY) { // 向下滚动
        if (_text.frame.origin.y == VIEW_HEIGHT - 60) {
            [UIView animateWithDuration:0.3f animations:^{
                [_text setFrame:CGRectMake(0, VIEW_HEIGHT, VIEW_WIDH, 60)];
                [_tableView setFrame:CGRectMake(0, 0, VIEW_WIDH, VIEW_HEIGHT - 64)];
            }];
        }
    }
    
    if (newContentOffsetY >= _playView.frame.size.height + 80) {
        [_player pause];
    }else{
        if (![self.isWrite isEqualToString:@"1"]) {
            [_player play];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    
    // NSLog(@"scrollViewDidEndDragging");
    
    oldContentOffsetY = scrollView.contentOffset.y;
}


#pragma mark -  UItextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    CGRect frame = textView.frame;
    
    CGSize size = [textView.text sizeWithFont:textView.font
                   
                            constrainedToSize:CGSizeMake(VIEW_WIDH - 60, 1000)
                   
                                lineBreakMode:UILineBreakModeTailTruncation];
    
    frame.size.height = size.height > 1 ? size.height + 20 : 64;
    
    textViewHeight = frame.size.height - 40;
  //  NSLog(@"textViewheight == %d",textViewHeight);
    if (frame.size.height > textView.frame.size.height && frame.size.height < 80) {
        
        [UIView animateWithDuration:0.25f animations:^{
            if (iPhone6Plus) {
                [_text setFrame:CGRectMake(0, 410 - textViewHeight   , VIEW_WIDH, 60 + textViewHeight)];
            }else{
            [_text setFrame:CGRectMake(0, keyHeight - textViewHeight +5  , VIEW_WIDH, 60 + textViewHeight)];
            }
            [_textView setFrame:frame];
            [_textBackground setFrame:frame];
            [_nimingView setFrame:CGRectMake(0, textViewHeight/2, 59, 60)];
            
         
            
            
        }];
    }
   
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if(![text isEqualToString:@""])
    {
        [_backgroundTextView setHidden:YES];
    }
    if([text isEqualToString:@""]&&range.length==1&&range.location==0){
        [_backgroundTextView setHidden:NO];
    }
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    
    
    if (1 == range.length) {//按下回格键
        return YES;
    }
    if ([text isEqualToString:@"\n"]) {//按下return键
        if (!self.replyUserid) {
            self.replyUserid = @"0";
        }
        if (!self.isAnonymous) {
            self.isAnonymous = @"0";
        }
        NSString *replyUserid = self.replyUserid;
        NSString *content = _textView.text;
         NSLog(@"发送键 %@",self.replyUserid);
        [_textView endEditing:YES];
       
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.UserId,@"UserId",content,@"content",replyUserid,@"replyId",self.isAnonymous,@"isAnonymous", nil];
        NSLog(@"dic == %@",dic);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",nil];
        NSString *string = [NSString stringWithFormat:@"%@%@",MAIN_URL,@"Other/Add/"];
        NSString *post = [NSString stringWithFormat:@"%@%@",string,self.ID];
        NSLog(@"self.dic === %@",dic);
        NSLog(@"url === %@",post);
        [manager POST:post parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSString *string = @"评论成功";
//            ALERT_MSG(string);
            pinglunlabel += 1;
            NSLog(@"pinglunlabeo ==== %d",pinglunlabel);
            _pinglunLabel.text = [NSString stringWithFormat:@"%d%@",pinglunlabel,@" 评论"];
            NSLog(@"%@",_pinglunLabel.text);
            self.ispinglun = @"1";
            [_nimingButton setBackgroundImage:[UIImage imageNamed:@"quanzi-5"] forState:UIControlStateNormal];
            self.isAnonymous = @"0";
            self.textView.text = @"";
            [self.textView  resignFirstResponder];
            [_nimingView setFrame:CGRectMake(0, 1, 59, 60)];
            [_text setFrame:CGRectMake(0, VIEW_HEIGHT, VIEW_WIDH, 60)];
            [_tableView setFrame:CGRectMake(0, 0, VIEW_WIDH, VIEW_HEIGHT - 64)];
            textViewHeight = 0;
            [_backgroundTextView setHidden:NO];
            _backgroundTextView.text = @"请输入...";
            [self.datasource removeAllObjects];
            [self getAFNetWorkingData];
            [self getDatesourceForCell];
      
            
            [self.tableView reloadData];
            
            NSLog(@"评论成功");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            self.isAnonymous = @"0";
            self.textView.text = @"";
            [self.textView  resignFirstResponder];
            [_nimingView setFrame:CGRectMake(0, 1, 59, 60)];
            [_text setFrame:CGRectMake(0, VIEW_HEIGHT, VIEW_WIDH, 60)];
            [_tableView setFrame:CGRectMake(0, 0, VIEW_WIDH, VIEW_HEIGHT - 64)];
            textViewHeight = 0;
            [_backgroundTextView setHidden:NO];
            _backgroundTextView.text = @"请输入...";
            [self.datasource removeAllObjects];
            [self getDatesourceForCell];
            [self.tableView reloadData];
           [SVProgressHUD showErrorWithStatus:@"评论失败,请稍候再试"];
            
        }];
        return YES;
    }else {
        if ([textView.text length] < 140) {//判断字符个数
            return YES;
        }
    }
    
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
   
    

    _textView.textColor = [UIColor blackColor];
    
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (CGFloat)contentHeight:(UILabel *)label {
    CGFloat height = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : label.font} context:nil].size.height;
    return height;
}



@end
