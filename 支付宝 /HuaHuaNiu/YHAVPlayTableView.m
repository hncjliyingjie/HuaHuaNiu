//
//  YHAVPlayTableView.m
//  代言成
//
//  Created by YongHeng on 16/7/26.
//  Copyright © 2016年 YongHeng. All rights reserved.
//

#import "YHAVPlayTableView.h"
#import "XMGCommentCell.h"
#import "comment.h"


@interface YHAVPlayTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YHAVPlayTableView
static NSString * const XMGCommentCellId = @"comment";
- (instancetype)init{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 80;
        //自动适应行高
        //自动计算行高 需要有自上而下的约束
        self.rowHeight = UITableViewAutomaticDimension;
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.commentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGCommentCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XMGCommentCell" owner:nil options:nil] firstObject];
    comment *model = self.commentArray[indexPath.row];
    cell.mement_name.text = model.member_name;
    cell.mementcontent.text = model.content;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    comment *temp = self.commentArray[indexPath.row];
    _huifumemID = temp.member_id;
    _huifutype = 1;
    self.sendView.textField.placeholder=[NSString stringWithFormat:@"回复:%@",temp.member_name];
    [self.sendView.textField becomeFirstResponder];
}



@end
