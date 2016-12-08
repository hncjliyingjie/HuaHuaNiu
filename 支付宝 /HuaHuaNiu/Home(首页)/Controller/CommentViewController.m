//
//  CommentViewController.m
//  HuaHuaNiu
//
//  Created by wcs on 16/1/14.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "CommentViewController.h"
#import "KrVideoPlayerController.h"
#import "HGHttpTool.h"
#import "HGFindModel.h"
#import "XMGCommentCell.h"
#import "comment.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "UMSocialQQHandler.h"
#import <MediaPlayer/MediaPlayer.h>
#import "CoreUMeng.h"
@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *toolpinglun;
@property (weak, nonatomic) IBOutlet UITextField *pingluntext;
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

@property (strong ,nonatomic) UILabel *titlelable;
@property (strong ,nonatomic) UILabel *time;
@property (strong ,nonatomic) UILabel *showcount;
@property (strong ,nonatomic) UILabel *pinglunshu;

@property (strong ,nonatomic) NSArray *array;

@property(nonatomic,strong) UIActivityIndicatorView *loadingAni;
@property(nonatomic,strong)NSNotificationCenter *notificationCenter;

@property (strong,nonatomic) NSString *huifumemID;
@property (assign,nonatomic) NSInteger huifutype;



@end




@implementation CommentViewController


static NSString * const XMGCommentCellId = @"comment";




-(void)viewWillAppear:(BOOL)animated
{
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
    self.pingluntext.placeholder=@"写评论...";
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
            
//            [self.tableview reloadData];
        } failture:^(id json) {
            
        }];
//        [self viewWillAppear:YES];
//        [self.tableview reloadData];
        
    }else
    {
    
        NSString *url = [NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/comment_add.do?token=test&member_id=%@&content=%@&video_id=%@&reply_member_id=%@",_member,[_pingluntext.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_video_id,@""];
        [HGBaseMethod post:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parms:nil success:^(id json) {
            
            NSLog(@"%@",json);
            if ([json[@"result"] integerValue] == 1)
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"代言城" message:json[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alter show];
                _pingluntext.text = @"";
                [self viewWillAppear:YES];
                
            }
            
            
        } failture:^(id json) {
            
        }];
//        [self viewWillAppear:YES];
//        [self.tableview reloadData];
    }
    self.pingluntext.placeholder=@"写评论...";
//    [self viewWillAppear:YES];
//    [self.tableview reloadData];
//    [_pingluntext resignFirstResponder];

    _huifutype = 0;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([XMGCommentCell class]) bundle:nil] forCellReuseIdentifier:XMGCommentCellId];
    
    self.tableview.estimatedRowHeight = 40;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
 //隐藏Tableview中间的分割线
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:(UIBarButtonItemStylePlain) target:self action:@selector(fenxiang)];
    
    
}
-(void)fenxiang
{
//    [CoreUmengShare show:self text:@"我是友盟分享文字" image:[UIImage imageNamed:@"show"]];
//    [CoreUmengShare show:<#(UIViewController *)#> text:<#(NSString *)#> image:<#(id)#>];
//    BOOL  isweixin =   [WXApi isWXAppInstalled];
//    if (isweixin) {// 安装
        // 分享收益
        //shareText  文字 //  shareImage 图片
        NSString * ShareStr =[NSString stringWithFormat:@"http://daiyancheng.cn/appshare/videoinfo.do?key=%@",_video.findModel.video_id];
    
        NSLog(@"wo d %@",ShareStr);
        NSString * concentStr =[NSString stringWithFormat:@"#代言城#来自代言城客户端"];
    [CoreUmengShare show:self text:concentStr image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",_video.findModel.img_path]]]]];
//                [UMSocialSnsService presentSnsIconSheetView:self
//                                             appKey:@"5507c758fd98c5cdd1000244"
//                                          shareText:concentStr
//                                         shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",_video.findModel.img_path]]]]
//                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
//                                           delegate:nil];
        [UMSocialData defaultData].extConfig.wechatSessionData.url = ShareStr;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url =ShareStr;
        // [UMSocialData defaultData].extConfig.wechatTimelineData.url =ShareStr;
        
        
        
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"来自代言城的分享内容";
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"来自代言城的分享内容";
//        [CoreUmengShare show:self text:@"我是友盟分享文字" image:[UIImage imageNamed:@"show"]];
        NSLog(@"11");

        //(@"分享");
        
        
        
//    }
//    else{  // 未安装
//        
//        UIAlertView * all =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您未安装微信无法分享获取积分" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [all show];
//    }
//
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    comment *temp = _array[indexPath.row];
    _huifumemID = temp.member_id;
    
    
    _huifutype = 1;
    self.pingluntext.placeholder=[NSString stringWithFormat:@"回复:%@",temp.member_name];
    [self.pingluntext becomeFirstResponder];
}

//-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%li",_array.count);
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 135+150;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.moviePlayer.playbackState==MPMoviePlaybackStatePlaying||self.moviePlayer.playbackState==MPMoviePlaybackStatePaused)
    {
        
        [self.moviePlayer.view removeFromSuperview];
    }
    
    if (!_moviePlayer) {
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://101.200.90.192:8090/%@",_path]]];
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    if ([self.moviePlayer isPreparedToPlay]) {
        [_moviePlayer setContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://101.200.90.192:8090/%@",_path]]];
        
    }

    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 135+100)];

    self.moviePlayer.view.frame=CGRectMake(0,0,width, 135);
    
    [self addNotification];
    
 
    self.titlelable = [[UILabel alloc]initWithFrame:CGRectMake(10, 1, width, 40)];
    self.titlelable.text = _titles;
    
    self.time = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 100, 40)];
    self.time.text = _addtime;
    
    self.showcount = [[UILabel alloc]initWithFrame:CGRectMake(width-100, 45, 80, 40)];
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(width-120, 60, 20, 15)];
    img1.image = [UIImage imageNamed:@"icon_looker"];
//    img1.backgroundColor = [UIColor redColor];
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(width-60, 60, 20, 15)];
    img2.image = [UIImage imageNamed:@"icon_reply"];
//    img2.backgroundColor = [UIColor redColor];
    
    self.showcount.text = [NSString stringWithFormat:@"%@",__on_looks];
    self.pinglunshu = [[UILabel alloc]initWithFrame:CGRectMake(width-40, 45, 80, 40)];
    self.pinglunshu.text = [NSString stringWithFormat:@"%@",_comment_num];
    
    UIView *toolview = [[UIView alloc]initWithFrame:CGRectMake(0, 135+55, width, 80)];
    toolview.backgroundColor = [UIColor whiteColor];
    
    [toolview addSubview:self.titlelable];
    [toolview addSubview:self.time];
    [toolview addSubview:self.showcount];
    [toolview addSubview:self.pinglunshu];
    [toolview addSubview:img1];
    [toolview addSubview:img2];
    [view addSubview:toolview];

    [view addSubview:self.moviePlayer.view];
    
    return view;
}


-(void)viewDidDisappear:(BOOL)animated
{
   
}






-(void)addNotification{
    
    self.notificationCenter=[NSNotificationCenter defaultCenter];
    [self.notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    
    if ([self.moviePlayer respondsToSelector:@selector(loadState)])
    {
        [self.moviePlayer prepareToPlay];
    }
    else
    {
        [self.moviePlayer play];
    }
    
}


-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
   
    
    if ([self.moviePlayer loadState]!=MPMovieLoadStateUnknown)
    {
        
        switch (self.moviePlayer.playbackState) {
            case MPMoviePlaybackStatePlaying:
                
                //  NSLog(@"正在播放...");
                break;
            case MPMoviePlaybackStatePaused:
                // NSLog(@"暂停播放.");
                break;
            case MPMoviePlaybackStateStopped:
                // NSLog(@"停止播放.");
                break;
            default:
                // NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
                break;
        }
    }
}
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
