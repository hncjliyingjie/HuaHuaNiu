//
//  YHSheQuXQ.m
//  HuaHuaNiu
//
//  Created by YongHeng on 16/8/8.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "YHSheQuXQ.h"
#import "YHAVPlayDisplayView.h"
#import "YHAVPlayTableView.h"
#import "Masonry.h"
#import "LogViewController.h"
#import "UMSocial.h"
#import "CoreUMeng.h"
#import "comment.h"
#import "XMGCommentCell.h"
#import "HGHttpTool.h"
#import "HGFindModel.h"
#import "YHSheQuSendView.h"


@interface YHSheQuXQ ()<UITableViewDelegate,UITableViewDataSource,YHSheQuSendViewDelegate>
@property (strong ,nonatomic) NSArray *commentArray;

@property(nonatomic,strong) UIActivityIndicatorView *loadingAni;
@property(nonatomic,strong)NSNotificationCenter *notificationCenter;


@property (nonatomic, strong) UIImageView *imageVIew;
@property(nonatomic, strong) YHAVPlayDisplayView *displayView;
@property (nonatomic, strong) YHAVPlayTableView * tableview;
@property (nonatomic,strong) YHSheQuSendView *sendView;

@end

@implementation YHSheQuXQ

- (void)setVideo:(HGFindFrameModel *)video{
    _video = video;
    //    self.path = video.findModel.path
    if (_path == nil)
    {
        _path = _video.findModel.path;
    }
    if (_titles == nil)
    {
        _titles = _video.findModel.title;
    }
    if (_addtime ==nil)
    {
        _addtime = _video.findModel.add_time_x;
    }
    if (_video_id == nil)
    {
        _video_id = _video.findModel.video_id;
    }
    if (__on_looks ==nil)
    {
        __on_looks = _video.findModel.on_lookers;
    }
    if (_comment_num== nil)
    {
        _comment_num = _video.findModel.comment_num;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpShareButton];
    self.view.backgroundColor = [UIColor grayColor];
    
    [HGHttpTool getWirhUrl:[NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/looker_add.do?token=test&member_id=%@&video_id=%@",_member,_video_id] parms:nil success:^(id json) {
    } failture:^(id error) {
        
    }];
    
    [self setUpUI];
    
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 工具条平移的距离 == 屏幕高度 - 键盘最终的Y值
    CGFloat h = XMGScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat begin = [note.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].origin.y;
    CGFloat end = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    [self.sendView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-h);
    }];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)setUpUI{
    [self.view addSubview:self.imageVIew];
    [self.view addSubview:self.displayView];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.sendView];
    
    
    //self.play.view
    [self.imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(self.view.frame.size.height * 0.3));
    }];
    
    //添加描述 View
    [self.displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.imageVIew.mas_bottom);
    }];
    
    [self.sendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@(44));
    }];
    
    //添加 tableView
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.displayView.mas_bottom);
        make.bottom.equalTo(self.view).offset(-44);
    }];
    
}
- (void)loadData{
    NSString *url = [NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/video_comments.do?token=test&member_id=%@&video_id=%@&currentPage=1&showCount=99",_member,_video_id];
    
    [HGBaseMethod get:url parms:nil success:^(id json)
     {
         _commentArray = [comment objectArrayWithKeyValuesArray:json[@"comments"]];
         
         self.tableview.commentArray = _commentArray;
         [self.tableview reloadData];
         
         NSLog(@"-=-=%@",json);
         
     } failture:^(id json) {
         
     }];
}

#pragma mark - 懒加载
- (UIImageView *)imageVIew{
    if (!_imageVIew) {
        _imageVIew = [[UIImageView alloc] init];
        _imageVIew.backgroundColor = [UIColor darkGrayColor];
        if (_image1 != nil) {
            _imageVIew.image = _image1;
        }
    }
    return _imageVIew;
}

- (YHAVPlayDisplayView *)displayView{
    if (!_displayView) {
        //        _displayView = [[YHAVPlayDisplayView alloc] init];
        _displayView = [[[NSBundle mainBundle] loadNibNamed:@"YHAVPlayDisplayView" owner:nil options:nil] firstObject];
        _displayView.contentLable.text = self.titles;
        _displayView.timeLable.text = self.addtime;
        _displayView.looks.text = [NSString stringWithFormat:@"%@",self._on_looks];
        _displayView.lookImage.image = [UIImage imageNamed:@"icon_looker"];
        _displayView.commentImage.image = [UIImage imageNamed:@"icon_reply"];
        _displayView.comment_num.text = [NSString stringWithFormat:@"%@",self.comment_num];
    }
    return _displayView;
}
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[YHAVPlayTableView alloc] init];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (YHSheQuSendView *)sendView{
    if (!_sendView) {
        _sendView = [[[NSBundle mainBundle] loadNibNamed:@"YHSheQuSendView" owner:nil options:nil] firstObject];
        _sendView.delegate = self;
        self.tableview.sendView = _sendView;
    }
    return _sendView;
}
#pragma mark ----------sendView的代理方法

- (void)sendButtonDidClicWithTextField:(UITextField *)textField{
    if (self.tableview.huifutype == 1)
    {
        
        NSString *url = [NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/comment_add.do?token=test&member_id=%@&content=%@&video_id=%@&reply_member_id=%@",_member,[textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_video_id,self.tableview.huifumemID];
        [HGBaseMethod post:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parms:nil success:^(id json) {
            
            NSLog(@"%@",json);
            if ([json[@"result"] integerValue] == 1)
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"代言城" message:json[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alter show];
                [self viewWillAppear:YES];
            }
            textField.text = @"";
            //            [_pingluntext resignFirstResponder];
            
            [self.tableview reloadData];
        } failture:^(id json) {
            
        }];
        
        
        
    }else
    {
        
        NSString *url = [NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/comment_add.do?token=test&member_id=%@&content=%@&video_id=%@&reply_member_id=%@",_member,[textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_video_id,@""];
        [HGBaseMethod post:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parms:nil success:^(id json) {
            
            NSLog(@"%@",json);
            if ([json[@"result"] integerValue] == 1)
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"代言城" message:json[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alter show];
                [self viewWillAppear:YES];
            }
            textField.text = @"";
            //            [_pingluntext resignFirstResponder];
            
            [self.tableview reloadData];
        } failture:^(id json) {
            
        }];
    }
    textField.placeholder=@"写评论...";
    self.tableview.huifutype = 0;
    
}
- (void)setUpShareButton {
    UIButton *saveBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBt setFrame:CGRectMake(0, 0, 15, 15)];
    [saveBt addTarget:self action:@selector(SaveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [saveBt setBackgroundImage:[UIImage imageNamed:@"app_top_shoucang"] forState:UIControlStateNormal];
    [saveBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    saveBt.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *startBtn = [[UIBarButtonItem alloc] initWithCustomView:saveBt];
    
    UIButton *shareBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBt setFrame:CGRectMake(0, 0, 15, 15)];
    [shareBt addTarget:self action:@selector(ShareAction) forControlEvents:UIControlEventTouchUpInside];
    [shareBt setBackgroundImage:[UIImage imageNamed:@"app_top_fenxiang"] forState:UIControlStateNormal];
    [shareBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBt.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *pauseBtn = [[UIBarButtonItem alloc] initWithCustomView:shareBt];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: pauseBtn,startBtn,nil]];
    
}
//   收藏
-(void)SaveBtnAction:(UIButton *)Btn{

        //   //(@"收藏");
        NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
        NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
        int denglu  = (int)UserIDs.length;
        if (denglu ==  0) {// 未登录 进入登陆
            LogViewController *logview =[[LogViewController alloc]init];
            [self.navigationController pushViewController:logview animated:YES];
        }
        else{
            NSUserDefaults * UserDefault  =[NSUserDefaults  standardUserDefaults];
            NSString * UserID =[UserDefault objectForKey:@"Useid"];
            NSString *ShouY = [NSString stringWithFormat:FenXiangSQ,self.video_id];
            ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //(@"%@",ShouY);
            AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
            [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //(@"%@",[responseObject objectForKey:@"msg"]);
                UIAlertView  * SCAl =[[UIAlertView alloc]initWithTitle:@"提示" message:@"商家收藏成功，可在我的收藏中查看" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [SCAl show];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [failAlView show];
                //(@"cook load failed ,%@",error);
            }];
        }
}

-(void)ShareAction {
    
    NSString * ShareStr =[NSString stringWithFormat:FenXiangSQ,self.video_id];
    NSString * concentStr =[NSString stringWithFormat:@"%@",self.titles];
    [UMSocialData defaultData].extConfig.qqData.url = ShareStr;
    [UMSocialData defaultData].extConfig.qzoneData.url = ShareStr;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = ShareStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url =ShareStr;
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5507c758fd98c5cdd1000244"
                                      shareText:concentStr
                                     shareImage:self.image1
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]
                                       delegate:nil];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"来自代言城的分享内容";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"来自代言城的分享内容";
    [UMSocialData defaultData].extConfig.qqData.title = @"来自代言城的分享内容";
    [UMSocialData defaultData].extConfig.qzoneData.title = @"来自代言城的分享内容";
}

@end
