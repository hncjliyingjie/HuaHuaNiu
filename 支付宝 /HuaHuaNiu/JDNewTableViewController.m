//
//  JDNewTableViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "JDNewTableViewController.h"
#import "JDFirstCell.h"
#import "JDSecoundCell.h"
#import "Toast+UIView.h"
#import "share_linkCell.h"
#import "JDMoreModel.h"
#import "shao_maoCell.h"
@interface JDNewTableViewController ()
//@property(strong,nonatomic)NSMutableArray *saomaArray;
@end

@implementation JDNewTableViewController
{
    bool isSaoMao;//是否是扫描二维码任务
    bool isSharePic;//是否是分享图片
    bool isShareLink;//是否是分享链接
    NSString *idStr;//点击的行号标识
    NSDictionary *dict;

}
- (void)viewDidLoad {
    [self makeData];
    self.title = @"接单详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];

    self.tableView.backgroundColor=BGCOLOR;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [super viewDidLoad];
    
    [self viewWithFootView];
    //测试，一开始是扫描
//    isSaoMao=YES;
//    isSharePic=YES;
        isShareLink=YES;
   
    
}
//点击的行
-(void)initWithIdStr:(NSString *)str{
    idStr=str;

}
//去完成按钮
-(void)viewWithFootView{
    
    UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 60)];
    views.backgroundColor=BGCOLOR;
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, ConentViewWidth-20, 25)];
    btn.backgroundColor=[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1];
    btn.layer.cornerRadius=12;
    [btn setTitle:@"去完成" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    [views addSubview:btn];
    self.tableView.tableFooterView=views;

}
#pragma mark - Table view data source
//返回段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//返回的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    if (section==1) {
        //分享链接
        if (isShareLink) {
            return 1;
        }
        //扫描任务
        if (isSaoMao) {
            return 3;
        }
        else{
            return 3;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //其他任务类型或者扫描类型
    if (indexPath.section==0) {
        JDFirstCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"JDFirstCell" owner:self options:nil]firstObject];
        cell.titleName.text=[dict objectForKey:@"name"];
        cell.isAccpect.text=[dict objectForKey:@"isAccept"];
        cell.phone.text=[dict objectForKey:@"phone"];
        NSString *first=[dict objectForKey:@"jd_cont_fisrst"];
         NSString *secound=[dict objectForKey:@"jd_cont_secund"];
        cell.jd_number.text=[NSString stringWithFormat:@"%@/%@",first,secound];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        //判断是分享图文还是链接
        if (isShareLink) {
            share_linkCell *cell=[[[NSBundle mainBundle]loadNibNamed:@"share_linkCell" owner:self options:nil]objectAtIndex:0];
            cell.share_Text.text=[dict objectForKey:@"content"];
            cell.share_linkText.text=[dict objectForKey:@"url"];
            return cell;
        }
        //判断第二段是否是分享图文
        if (isSharePic) {
            
            JDSecoundCell *cell=[[JDSecoundCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"share_pic"];
            return cell;
        }
        else{
            if (indexPath.row==0)
            {
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bzcell1"];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0,cell.frame.size.width,30)];
            label.text=[dict objectForKey:@"content"];
            label.font=[UIFont systemFontOfSize:13];
            label.textColor=[UIColor grayColor];
            [cell.contentView addSubview:label];
            UIImageView *imgs;
            //判断是否是扫码任务
            if (isSaoMao==YES)
                {
                    imgs =[[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 30, 40)];
                    imgs.backgroundColor=[UIColor greenColor];
                    [cell.contentView addSubview:imgs];
                }
            else
                {
                    imgs.hidden=YES;
            
                }
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }
            else
            {
                shao_maoCell *cell=[[shao_maoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shao_maoCell"];
                cell.label.text=@"第一步";
                cell.img.backgroundColor=[UIColor redColor];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        //第一个section
        return 180;
    }
    if (indexPath.section==1) {
        
        if (isShareLink) {
            return 160;
        }
        //扫码任务
        if (isSaoMao) {
            if (indexPath.row==0)
            {
                return 80;
            }
            else
            {
                return 110;
            
            }
        }
        //步骤和图片的
        else{
            
            return 110;
        }
    }
    return 0;
}

#pragma mark 网络请求
-(void)makeData{
    [self.view makeToastActivity];
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    
    NSString * ShouY = [NSString stringWithFormat:JDMoreUrl,idStr,UserIDs];
    NSString *urlStringUTF8 = [ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStringUTF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.view hideToastActivity];
        NSLog(@"接单详情返回数据%@",responseObject);
        NSMutableDictionary *dic=[responseObject objectForKey:@"task"];
        //任务名称
        NSString *name=[dic objectForKey:@"name"];
        //剩余时间
         NSString *end_time=[dic objectForKey:@"end_time"];
        //新浪微博/分享链接任务/5为其他，不用显示
         NSString *media_type=[dic objectForKey:@"media_type"];
        //发布人联系方式
         NSString *phone=[dic objectForKey:@"mobile"];
        //按接单人次
        NSString *count=[dic objectForKey:@"count"];
        NSString *tol_count=[dic objectForKey:@"tol_count"];
        //分享链接的URL
        NSString *url=[dic objectForKey:@"url"];
        if (url==nil) {
            url=@"";
        }
        //任务状态
        NSString *isAccept;
        NSString *isAccepts=[dic objectForKey:@"isAccept"];
        if (isAccepts.intValue==0) {
            isAccept=[NSString stringWithFormat:@"未认领"];
        }
        if (isAccepts.intValue==1) {
            isAccept=[NSString stringWithFormat:@"已认领"];
        }
        //分享语
        NSString *content=[dic objectForKey:@"content"];
        //二维码
        NSString *qrcode=[dic objectForKey:@"qrcode"];

        //任务步骤
        NSMutableArray *imgArray=[dic objectForKey:@"images"];
       
        JDMoreModel *model=[[JDMoreModel alloc]init];
        model.name=name;
        model.renling_type=isAccept;
        model.end_time=end_time;
        model.phone=phone;
        model.jd_cont_fisrst=count;
        model.jd_cont_secund=tol_count;
        model.content=content;
        model.qrcode=qrcode;
        
        
        for (int i=0; i<imgArray.count; i++) {
            NSMutableDictionary *dic=[imgArray objectAtIndex:i];
            //任务图片
            NSString *imgStr=[dic objectForKey:@"image"];
            NSMutableString *url=[NSMutableString stringWithFormat:DYListUrl,DYSTRRING, imgStr];
            UIImage *imgs=[self getImageFromURL:url];
            //任务步骤
            NSString *sortStr=[dic objectForKey:@"sort"];
            //任务描述
            NSString *summaryStr=[dic objectForKey:@"summary"];
            //放入所有步骤图片
            model.img=imgs;
        }
        if (qrcode==nil) {
            qrcode=@"";
        }
        dict = @{@"name" : name,
                              @"isAccept" : isAccept,
                              @"end_time" : end_time,
                              @"phone" : phone,
                              @"jd_cont_fisrst" : count,
                              @"jd_cont_secund" : tol_count,
                              @"content" : content,
                              @"qrcode" : qrcode,
                              @"url" : url};
        


//        [self.saomaArray addObject:model];
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
    }];
    
}
-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}
//-(NSMutableArray*)saomaArray{
//
//    if (_saomaArray==nil) {
//        _saomaArray=[NSMutableArray array];
//    }
//    return _saomaArray;
//}

#pragma mark 设置section圆角
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
 {
       if ([cell respondsToSelector:@selector(tintColor)]) {
               if (tableView == self.tableView) {
                        // 圆角弧度半径
                     CGFloat cornerRadius = 5.f;
                      // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
                      cell.backgroundColor = UIColor.clearColor;
          
                  // 创建一个shapeLayer
                       CAShapeLayer *layer = [[CAShapeLayer alloc] init];
                       CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
                    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
                         CGMutablePathRef pathRef = CGPathCreateMutable();
                       // 获取cell的size
                       CGRect bounds = CGRectInset(cell.bounds, 5,0);
            
                        // CGRectGetMinY：返回对象顶点坐标
                       // CGRectGetMaxY：返回对象底点坐标
                      // CGRectGetMinX：返回对象左边缘坐标
                      // CGRectGetMaxX：返回对象右边缘坐标
          
                     // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
                       BOOL addLine = NO;
                      // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
                       if (indexPath.row == 0) {
                               // 初始起点为cell的左下角坐标
                               CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                               // 起始坐标为左下角，设为p1，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
                              CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                               CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                            // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
                              CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                                addLine = YES;
                        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                                // 初始起点为cell的左上角坐标
                                   CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                                 CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                                     // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
                                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
                                } else {
                                    // 添加cell的rectangle信息到path中（不包括圆角）
                                       CGPathAddRect(pathRef, nil, bounds);
                                        addLine = YES;
                                  }
                    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
                        layer.path = pathRef;
                         backgroundLayer.path = pathRef;
                         // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
                       CFRelease(pathRef);
                         // 按照shape layer的path填充颜色，类似于渲染render
                        // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
                       layer.fillColor = [UIColor whiteColor].CGColor;
                        // 添加分隔线图层
//                       if (addLine == YES) {
//                               CALayer *lineLayer = [[CALayer alloc] init];
//                               CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
//                               lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
//                             // 分隔线颜色取自于原来tableview的分隔线颜色
//                                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
//                                 [layer addSublayer:lineLayer];
//                            }
            
                         // view大小与cell一致
                        UIView *roundView = [[UIView alloc] initWithFrame:bounds];
                         // 添加自定义圆角后的图层到roundView中
                        [roundView.layer insertSublayer:layer atIndex:0];
//                        roundView.backgroundColor = UIColor.clearColor;
                   roundView.backgroundColor=BGCOLOR;
                       //cell的背景view
                         //cell.selectedBackgroundView = roundView;
                      cell.backgroundView = roundView;
                   
                       //以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
                         UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
                         backgroundLayer.fillColor = tableView.separatorColor.CGColor;
                        [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
                         selectedBackgroundView.backgroundColor = UIColor.clearColor;
                        cell.selectedBackgroundView = selectedBackgroundView;
                    }
            }
  }

@end
