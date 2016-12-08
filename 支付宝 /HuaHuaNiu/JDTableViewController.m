//
//  JDTableViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/8.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "JDTableViewController.h"
#import "JDCell.h"
#import "JDNewTableViewController.h"
#import "Toast+UIView.h"
#import "JDModel.h"
@interface JDTableViewController ()
@property(strong,nonatomic)NSMutableArray *listArray;
@end

@implementation JDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self makeData];
    self.view.backgroundColor=BGCOLOR;
   

    
}
-(NSMutableArray *)listArray{
    if (_listArray==nil) {
        _listArray=[NSMutableArray array];
    }
    return _listArray;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     JDCell *cell;
        cell= [tableView dequeueReusableCellWithIdentifier:@"JDCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"JDCell" owner:self options:nil]firstObject ];
        }
    [cell cellWithStyle];
    JDModel *model=[self.listArray objectAtIndex:indexPath.row];
    cell.titleName.text=model.name;
    cell.link_text.text=model.ad_type;
    cell.numberLbl.text=[NSString stringWithFormat:@"%d/%d个",model.counts,model.tol_count];
    [cell.wxBtn setTitle:model.media_type forState:UIControlStateNormal];
    cell.lingquLbl.text=model.isLingqus;
    cell.headImg.image=model.way_type;
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    return cell;

}
#pragma mark 网络请求
-(void)makeData{
    
    [self.view makeToastActivity];
    NSString * ShouY = [NSString stringWithFormat:JDLISTURL];
    NSString *urlStringUTF8 = [ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStringUTF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.view hideToastActivity];
        
        NSLog(@"接单列表返回数据%@",responseObject);
        NSMutableArray *array=[responseObject objectForKey:@"task"];
        for (int i=0; i<array.count; i++) {
            NSMutableDictionary *dic=[array objectAtIndex:i];

            //数量
             NSString *  countStr=[dic objectForKey:@"count"];
            int contStrs=countStr.intValue;
            //总数
             NSString *  tol_countStr=[dic objectForKey:@"tol_count"];
            int tolNumber=tol_countStr.intValue;
            //点击的cell
            NSString *idStr=[dic objectForKey:@"id"];
           
            //微信朋友圈/qq/微博
            NSString *mediaStr;
            NSString *  mediatypeStr=[dic objectForKey:@"media_type"];
           
            if (mediatypeStr.intValue==0) {
                mediaStr=[NSString stringWithFormat:@"微信朋友圈"];
            }
            if (mediatypeStr.intValue==1) {
                mediaStr=[NSString stringWithFormat:@"qq空间"];
            }
            if (mediatypeStr.intValue==2) {
                mediaStr=[NSString stringWithFormat:@"新浪微博"];
            }
            if (mediatypeStr.intValue==3) {
                mediaStr=[NSString stringWithFormat:@"公众号"];
            }
            if (mediatypeStr.intValue==4) {
                mediaStr=[NSString stringWithFormat:@"直播"];
            }
            NSString *linquStr;
            if (contStrs==tolNumber) {
                linquStr=[NSString stringWithFormat:@"已领完"];
            }
            if (contStrs!=tolNumber) {
                linquStr=[NSString stringWithFormat:@"未领完"];
            }
            //任务名称
            NSString *nameStr=[dic objectForKey:@"name"];
            //是按接单人数发布还是其他的7种方式,当way_typeStr=2，3时，才能判断ad_type
            NSString *  way_typeStr=[dic objectForKey:@"way_type"];
            NSString *ad_type;
            if (way_typeStr.intValue==2||way_typeStr.intValue==3) {
                            //分享链接/分享图文
                            NSString *typeStr=[dic objectForKey:@"ad_type"];
                
                            if (typeStr.intValue==0) {
                                ad_type=[NSString stringWithFormat:@"分享链接"];
                
                            }
                            if (typeStr.intValue==1) {
                                ad_type=[NSString stringWithFormat:@"分享图文"];
                
                            }
            }
            else
            {
                if (way_typeStr.intValue==0) {
                    ad_type=[NSString stringWithFormat:@"指定代言人"];
                }
                if (way_typeStr.intValue==1) {
                    ad_type=[NSString stringWithFormat:@"按展示点击"];
                }
                if (way_typeStr.intValue==4) {
                    ad_type=[NSString stringWithFormat:@"APP下载任务"];
                }
                if (way_typeStr.intValue==5) {
                    ad_type=[NSString stringWithFormat:@"微信扫码任务"];
                }
                if (way_typeStr.intValue==6) {
                    ad_type=[NSString stringWithFormat:@"绑卡任务"];
                }
                if (way_typeStr.intValue==7) {
                    ad_type=[NSString stringWithFormat:@"其他任务"];
                }            
            
            }
            //头像
            UIImage *img;
            if (way_typeStr.intValue==0) {
                img=[UIImage imageNamed:@"zddy.png"];
            }
            if (way_typeStr.intValue==1) {
                img=[UIImage imageNamed:@"zddy.png"];
            }
            if (way_typeStr.intValue==2) {
                img=[UIImage imageNamed:@"zddy.png"];
            }
            if (way_typeStr.intValue==3) {
                 img=[UIImage imageNamed:@"zddy.png"];
            }
            if (way_typeStr.intValue==4) {
                 img=[UIImage imageNamed:@"zddy.png"];
            }
            if (way_typeStr.intValue==5) {
                 img=[UIImage imageNamed:@"zddy.png"];
            }
            if (way_typeStr.intValue==6) {
                 img=[UIImage imageNamed:@"zddy.png"];
            }
            if (way_typeStr.intValue==7) {
                img=[UIImage imageNamed:@"zddy.png"];
            }
            
            JDModel *model=[[JDModel alloc]init];
            model.ad_type=ad_type;
            model.counts=contStrs;
            model.tol_count=tolNumber;
            model.idStr=idStr;
            model.media_type=mediaStr;
            model.name=nameStr;
            model.way_type=img;
            model.isLingqus=linquStr;
            [self.listArray addObject:model];
            [self.tableView reloadData];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
    }];

}
//接单详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    JDNewTableViewController *vc=[[JDNewTableViewController alloc]init];
    JDModel *mode=[self.listArray objectAtIndex:indexPath.row];
    [vc initWithIdStr:mode.idStr];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];

}
@end
