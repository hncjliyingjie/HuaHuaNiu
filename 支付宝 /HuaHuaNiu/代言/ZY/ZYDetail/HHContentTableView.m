//
//  HHContentTableView.m
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//
/****
 *****招标详情下招标任务tableview
 ****/
#import "HHContentTableView.h"
#import "ZYTableViewCell.h"
#import "Masonry.h"
#import "DYTableViewCell.h"
#import "ILSideScrollViewItem.h"
#import "ILSideScrollView.h"

@interface HHContentTableView ()<UITableViewDataSource, UITableViewDelegate,UIWebViewDelegate>
{
     ILSideScrollView *scroller;//底部其他资源横向滚动的

}
@property(strong,nonatomic)UILabel *qtzyLbl;//其他资源
@end

@implementation HHContentTableView

+ (HHContentTableView *)contentTableView
{
    HHContentTableView *contentTV = [[HHContentTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    contentTV.backgroundColor = [UIColor clearColor];
    contentTV.dataSource = contentTV;
    contentTV.delegate = contentTV;
    
    return contentTV;
}
//
//-(void) clickButton:(UIButton *) sender {
//    if ([self.delegate respondsToSelector:@selector(webViewLoadRequest)]) {
//        [self.zydelegate webViewLoadRequest];
//    }
//}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section==0) {
        UITableViewCell*cell;
        cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, cell.frame.size.height)];
            _webView.backgroundColor=[UIColor redColor];
            [cell.contentView addSubview:_webView];
            _webView.delegate=self;
            NSURL *url=[NSURL URLWithString:@"http://www.baidu.com"];
            NSURLRequest *request=[NSURLRequest requestWithURL:url];
        
            [_webView loadRequest:request];

        }
        //去掉cell的选中状态
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        //隐藏分割线
        tableView.separatorStyle=UITableViewCellSelectionStyleNone;
        return cell;

    }
    else{
        UITableViewCell *cell;
        if (indexPath.row==0) {
            cell =[tableView dequeueReusableCellWithIdentifier: @"qtcell"];
            if (cell==nil) {
                 cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qtcell"];
                self.qtzyLbl.frame=CGRectMake(0, 0, cell.width, cell.height );
                self.qtzyLbl.text=[NSString stringWithFormat:@"----------其他资源----------"];
                self.qtzyLbl.textAlignment=NSTextAlignmentCenter;
                self.qtzyLbl.font=[UIFont systemFontOfSize:14];
                [cell.contentView addSubview:self.qtzyLbl];
            }
            
           
        }
        if (indexPath.row==1) {
            cell =[tableView dequeueReusableCellWithIdentifier: @"tpcell"];
            if (cell==nil) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tpcell"];
                ILSideScrollView*scrollView=[self setupScroller];
                [cell.contentView addSubview:scrollView];
            }
        }
        //去掉cell的选中状态
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        //隐藏分割线
        tableView.separatorStyle=UITableViewCellSelectionStyleNone;
        return cell;

    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 5;
    }
    if (section==1) {
        return 2;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
         return 120.f;
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            return 40;
        }
        if (indexPath.row==1) {
            return 130;
        }
       
    }
    return 0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 10;
//}
#pragma mark 懒加载
-(UILabel *)qtzyLbl{
    if (_qtzyLbl==nil) {
        _qtzyLbl=[[UILabel alloc]init];
    }
    return _qtzyLbl;
}
#pragma mark 其他资源下的横向滚动图片
- (ILSideScrollView*)setupScroller{
    NSMutableArray *items = [NSMutableArray array];
    
    for (int i = 'A'; i <= 'J'; i++) {
        ILSideScrollViewItem *item = [ILSideScrollViewItem item];
        item.title = [NSString stringWithFormat:@"%c", i];
        item.backgroundColor = [UIColor colorWithPatternImage:
                                [UIImage imageNamed:@"wood.png"]];
        item.defaultTitleColor = [UIColor brownColor];
        item.selectedTitleColor = [UIColor redColor];
        item.titleFont = [UIFont fontWithName:@"MarkerFelt-Wide" size:60];
        [item setTarget:self action:@selector(showAlertForItem:) withObject:item];
        [items addObject:item];
    }
    
    scroller = [[ILSideScrollView alloc] initWithFrame:
                 CGRectMake(0,
                            0,
                            ConentViewWidth,
                            164)];
//    scroller.backgroundColor=[UIColor greenColor];
    [scroller populateSideScrollViewWithItems:items];
    return scroller;
}
#pragma mark - Actions

- (void)showAlertForItem:(ILSideScrollViewItem *)item {
    NSString *title = [NSString stringWithFormat:@"You tapped on the giant %@!", item.title];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


@end
