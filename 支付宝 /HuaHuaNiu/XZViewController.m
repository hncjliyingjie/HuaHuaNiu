//
//  XZViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "XZViewController.h"
#import "BZCell.h"
#import "PlaceholderTextView.h"
#import "FootView.h"
#import "TimeCell.h"
@interface XZViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *slLbl;//上传链接示例

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;//scrollview的高度

@property (weak, nonatomic) IBOutlet UIView *needView;//需要添加textView的view
@property (weak, nonatomic) IBOutlet UITableView *tableView;//步骤描述

@property(strong,nonatomic)NSMutableArray *array;

@property(strong,nonatomic) FootView *footView;

//@property(strong,nonatomic)NSMutableArray *numberArray;//自定义时间
@end

@implementation XZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发布任务";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    //设置圆角
    [self viewWithStyle];
    
    //添加textView的水印字
    PlaceholderTextView *textView=[[PlaceholderTextView alloc]initWithFrame:CGRectMake(10, 0, ConentViewWidth,40)];
    [self.needView addSubview:textView];
    textView.Placeholder=@"一句话描述任务，不超过40字。";
    textView.PlaceholderFont=[UIFont systemFontOfSize:12];
    
    
    self.array=[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    
    //    self.numberArray=[NSMutableArray array];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.tableView.scrollEnabled=NO;
    //动态改变整个滑动氛围的高度
    self.scrollViewHeight.constant=150*self.array.count+170+350;
    
    
    
}
-(void)viewWithStyle{
    self.slLbl.layer.cornerRadius=5;
    self.slLbl.layer.masksToBounds=YES;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.tableView) {
        return self.array.count;
    }
    if (tableView==self.footView.footTableView) {
        return 2;
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    if (tableView==self.tableView) {
        BZCell *cell;
        cell=[tableView dequeueReusableCellWithIdentifier:@"BZCELL"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"BZCell" owner:self options:nil]firstObject];
            [cell.delBtn addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchUpInside];
            PlaceholderTextView *textView=(PlaceholderTextView*)[cell viewWithTag:1001];
            textView.Placeholder=@"对该步骤进行描述";
            textView.PlaceholderFont=[UIFont systemFontOfSize:13];
        }
        
        PlaceholderTextView *textView=(PlaceholderTextView*)[cell viewWithTag:1001];
        textView.text = self.array[indexPath.row];
        cell.delBtn.tag = indexPath.row;
        cell.tag = [indexPath row];
        NSArray *subviews = [cell.contentView subviews];
        for(id view in subviews)
        {
            if([view isKindOfClass:[UIButton class]])
            {
                [view setTag:[indexPath row]];
                [cell.contentView bringSubviewToFront:view];
            }
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (tableView==_footView.footTableView) {
        TimeCell *cell;
        if (indexPath.row==0) {
            cell=[tableView dequeueReusableCellWithIdentifier:@"TimeCell"];
            if (cell==nil) {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"TimeCell" owner:self options:nil]firstObject];
                
            }
        }
        if (indexPath.row==1) {
            cell=[tableView dequeueReusableCellWithIdentifier:@"TimeCELL"];
            if (cell==nil) {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"TimeCell" owner:self options:nil]objectAtIndex:1];
                
            }
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView) {
        return 150;
    }
    if (tableView==self.footView.footTableView) {
        return 30;
    }
    return 0;
    
}
-(void)del:(id)sender
{
    UIButton *btn=sender;
    NSLog(@"%ld",btn.tag);
    [self.array removeObjectAtIndex:btn.tag];
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.row==[self.array count]-1) {
        //        UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 100)];
        _footView=[FootView creatView];
//        [_footView.addBtn addTarget:self action:@selector(addRow) forControlEvents:UIControlEventTouchUpInside];
        [_footView.startBtn addTarget:self action:@selector(startDone:) forControlEvents:UIControlEventTouchUpInside];
        [_footView.zdyBtn addTarget:self action:@selector(startDone:) forControlEvents:UIControlEventTouchUpInside];
        //        footView.backgroundColor=[UIColor redColor];
        self.tableView.tableFooterView=_footView;
        _footView.footTableView.delegate=self;
        _footView.footTableView.dataSource=self;
    }
}
//添加步骤
-(void)addRow:(id)sender{
    
    
}
//-(void)startDone:(id)sender{
//    UIButton *btn=sender;
//    if (btn.tag==1) {
//        self.numberArray=[NSMutableArray arrayWithCapacity:0];
//    }
//    if (btn.tag==2) {
//         self.numberArray=[NSMutableArray arrayWithCapacity:2];
//    }
//    [self.footView.footTableView reloadData];
//}
@end
