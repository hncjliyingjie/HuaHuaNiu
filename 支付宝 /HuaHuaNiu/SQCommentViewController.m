//
//  CommentViewController.m
//  HuaHuaNiu
//
//  Created by wcs on 16/1/14.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "SQCommentViewController.h"
#import "KrVideoPlayerController.h"
#import "HGHttpTool.h"
#import "HGFindModel.h"
#import "XMGCommentCell.h"
#import "comment.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UMSocial.h"
#import "CoreUMeng.h"
#import "LogViewController.h"
#import "AFNetworking.h"
#import "UILabel+LableHeight.h"
#import "SQCommentViewControllerHeader.h"


@interface SQCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *toolpinglun;
@property (weak, nonatomic) IBOutlet UITextField *pingluntext;


@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (strong, nonatomic) IBOutlet UIView *backVew;

//@property (strong ,nonatomic) UILabel *titlelable;
//@property (strong ,nonatomic) UILabel *time;
//@property (strong ,nonatomic) UILabel *showcount;
//@property (strong ,nonatomic) UILabel *pinglunshu;

@property (strong ,nonatomic) NSArray *array;

@property(nonatomic,strong) UIActivityIndicatorView *loadingAni;
@property(nonatomic,strong)NSNotificationCenter *notificationCenter;

@property (strong,nonatomic) NSString *huifumemID;
@property (assign,nonatomic) NSInteger huifutype;

@property (assign,nonatomic) CGFloat MaxY;

@property (nonatomic,strong) HGFindModel *findModel;

@end

@implementation SQCommentViewController


static NSString * const XMGCommentCellId = @"comment";




-(void)viewWillAppear:(BOOL)animated
{
    
    
    self.findModel = _video.findModel;
    
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
    
    [HGBaseMethod get:[NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/video_comments.do?token=test&member_id=%@&video_id=%@&currentPage=1&showCount=99",_member,_video_id] parms:nil success:^(id json)
     {
         _array = [comment objectArrayWithKeyValuesArray:json[@"comments"]];
         
         
         [self.tableview reloadData];
         
         NSLog(@"-=-=%@",json);
         
     } failture:^(id json) {
         
     }];
}

- (IBAction)sendpinglun:(id)sender {
    
    if (self.pingluntext.text.length == 0)
    {
        
        return;
    }
    
    if (_huifutype == 1)
    {
        
        NSString *url = [NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/comment_add.do?token=test&member_id=%@&content=%@&video_id=%@&reply_member_id=%@",_member,[_pingluntext.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_video_id,_huifumemID];
        
        [HGBaseMethod post:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parms:nil success:^(id json) {
            
            NSLog(@"%@",json);
            if ([json[@"result"] integerValue] == 1)
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"代言城" message:json[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alter show];
                [self viewWillAppear:YES];
            }
            _pingluntext.text = @"";
//            [_pingluntext resignFirstResponder];
            
            [self.tableview reloadData];
        } failture:^(id json) {
            
        }];
        
        
        
    }else
    {
        
        NSString *url = [NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/comment_add.do?token=test&member_id=%@&content=%@&video_id=%@&reply_member_id=%@",_member,[_pingluntext.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_video_id,@""];
        [HGBaseMethod post:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parms:nil success:^(id json) {
            
            NSLog(@"%@",json);
            if ([json[@"result"] integerValue] == 1)
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"代言城" message:json[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alter show];
                [self viewWillAppear:YES];
            }
            _pingluntext.text = @"";
//            [_pingluntext resignFirstResponder];
            
            [self.tableview reloadData];
        } failture:^(id json) {
            
        }];
    }
    self.pingluntext.placeholder=@"写评论...";
    _huifutype = 0;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpShareButton];
//    self.view = [[[NSBundle mainBundle] loadNibNamed:@"SQCommentViewController" owner:nil options:nil] firstObject];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([XMGCommentCell class]) bundle:nil] forCellReuseIdentifier:XMGCommentCellId];
    self.backVew.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.tableview.estimatedRowHeight = 40;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedSectionHeaderHeight = 200;
    self.tableview.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    SQCommentViewControllerHeader * header = [[[NSBundle mainBundle] loadNibNamed:@"SQCommentViewControllerHeader" owner:nil options:nil] firstObject];
    
    if (_image1 != nil) {
        header.headerImage.image = _image1;
    }
    header.titleLable.text = _titles;
    
    header.timeLabel.text = _addtime;
    header.lookImage.image = [UIImage imageNamed:@"icon_reply"];
    header.pinglunImage.image = [UIImage imageNamed:@"icon_reply"];

    self.tableview.tableHeaderView = header;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //隐藏Tableview中间的分割线
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    if (Btn.tag == 11){

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
    }else if (Btn.tag ==10){
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"5507c758fd98c5cdd1000244"
                                          shareText:@"友盟社会化分享让您快速实现分享等社会化功能，www.umeng.com/social"
                                         shareImage:[UIImage imageNamed:@"icon.png"]
                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
                                           delegate:nil];
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                //(@"分享成功！");
            }
        }];
        //设置点击分享内容跳转链接
        [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
        
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信好友title";
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈title";
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    comment *temp = _array[indexPath.row];
    _huifumemID = temp.member_id;
    _huifutype = 1;
    self.pingluntext.placeholder=[NSString stringWithFormat:@"回复:%@",temp.member_name];
    [self.pingluntext becomeFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCommentCellId];
    comment *temp = [[comment alloc]init];
    temp = _array[indexPath.row];
    
    if (![temp.reply_member_name  isEqual: @""])
    {
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@回复%@:%@",temp.member_name,temp.reply_member_name,temp.content]];
        NSRange redRange = NSMakeRange(0,temp.reply_member_name.length);
        NSRange redRange1 = NSMakeRange([[noteStr string] rangeOfString:@":"].location - temp.reply_member_name.length, temp.member_name.length);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange1];
        [cell.mementcontent setAttributedText:noteStr] ;
        cell.mement_name.text = @"";
        
    }
    else
    {
        cell.mementcontent.text = temp.content;
        cell.mement_name.text = temp.member_name;
    }
    
    
    
    //    cell.mement_time.text = temp.add_time;
    
    return cell;
}


#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
////    if (_image1 == nil)
////    {
////        return 150;
////    }
////    else
////    {
////        return 135+150;        
////        
////    }
//    return self.MaxY;
//}


/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    SQCommentViewControllerHeader * header = [[[NSBundle mainBundle] loadNibNamed:@"SQCommentViewControllerHeader" owner:nil options:nil] firstObject];
    
    header.model = _video.findModel;
    if (_image1 != nil) {
        header.headerImage.image = _image1;
    }
    
    
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 135)];
//    UIImageView *IMAGE1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,width, 200)];
//    
//
//    
//    
//    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(10, 1, width, 80)];
//    self.titlelable = titlelable;
//    self.titlelable.numberOfLines = 0;
//    self.titlelable.text = _titles;
//    
//    [titlelable sizeToFit];
//    CGFloat height = titlelable.frame.size.height;
//    titlelable.frame = CGRectMake(10, 1, width, height);
//    
//    self.time = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titlelable.frame), 100, 40)];
//    self.time.text = _addtime;
//    
//    self.showcount = [[UILabel alloc]initWithFrame:CGRectMake(width-100, CGRectGetMaxY(titlelable.frame), 80, 40)];
//    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(width-120, CGRectGetMaxY(titlelable.frame) + 15, 20, 15)];
//    img1.image = [UIImage imageNamed:@"icon_looker"];
//    //    img1.backgroundColor = [UIColor redColor];
//    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(width-60, CGRectGetMaxY(titlelable.frame) + 15, 20, 15)];
//    img2.image = [UIImage imageNamed:@"icon_reply"];
//    //    img2.backgroundColor = [UIColor redColor];
//    
//    self.showcount.text = [NSString stringWithFormat:@"%@",__on_looks];
//    self.pinglunshu = [[UILabel alloc]initWithFrame:CGRectMake(width-40, CGRectGetMaxY(titlelable.frame), 80, 40)];
//    self.pinglunshu.text = [NSString stringWithFormat:@"%@",_comment_num];
//    
//    UIView *toolview = [[UIView alloc]init];
//                        
//    if (_image1 == nil)
//    {
//        IMAGE1.hidden = YES;
//        toolview.frame = CGRectMake(0, 55, width, 80);
//
//    }
//    else
//    {
//        IMAGE1.image = _image1;
//        toolview.frame = CGRectMake(0, CGRectGetMaxY(IMAGE1.frame), width, 80);
//    }
//    
//    toolview.backgroundColor = [UIColor whiteColor];
//    
//    [toolview addSubview:self.titlelable];
//    [toolview addSubview:self.time];
//    [toolview addSubview:self.showcount];
//    [toolview addSubview:self.pinglunshu];
//    [toolview addSubview:img1];
//    [toolview addSubview:img2];
//    
//    [view addSubview:toolview];
//    
//    [view addSubview:IMAGE1];
//    self.MaxY = CGRectGetMaxY(view.frame);
//    return view;
    return header;
}
*/
#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    
    // 工具条平移的距离 == 屏幕高度 - 键盘最终的Y值
    self.bottomSpace.constant = XMGScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
