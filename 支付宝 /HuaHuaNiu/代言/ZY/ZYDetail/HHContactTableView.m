//
//  HHContactTableView.m
//  BuildMaterial
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 admin. All rights reserved.
//
/****
 *****招标详情下联系方式tableview
 ****/
#import "HHContactTableView.h"
#import "DYTableViewCell.h"
#import "ZTMoreCell.h"
@interface HHContactTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation HHContactTableView

+ (HHContactTableView *)contactTableView {
    HHContactTableView *tableView = [[HHContactTableView alloc] init];
    tableView.delegate=tableView;
    tableView.dataSource=tableView;
    return tableView;
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZTMoreCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:@"ZTMoreCell"];
        if(cell==nil){
            cell=[[[NSBundle mainBundle]loadNibNamed:@"ZTMoreCell" owner:self options:nil]objectAtIndex:0];
        }
    //去掉cell的选中状态
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //隐藏分割线
    tableView.separatorStyle=UITableViewCellSelectionStyleNone;
     return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 12;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
