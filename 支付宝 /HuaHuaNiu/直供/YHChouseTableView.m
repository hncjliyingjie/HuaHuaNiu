//
//  YHChouseTableView.m
//  花花牛
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YHChouseTableView.h"
#import "YHOrderModel.h"
#import "YHCateModel.h"


@interface YHChouseTableView ()<UITableViewDataSource,UITableViewDelegate>


@end
@implementation YHChouseTableView
static NSString *ID = @"cell";
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if ([self.lable isEqualToString: @"order"]) {
        YHOrderModel * model = self.dataArray[indexPath.row];
        cell.textLabel.text = model.name;
    }else if([self.lable isEqualToString: @"cate_id"]){
        YHOrderModel * model = self.dataArray[indexPath.row];
        cell.textLabel.text = model.value;

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //隐藏tableView
    self.hidden = YES;
    
    //拿到数据 跳转页面;
    if ([self.lable isEqualToString: @"order"]) {
        YHOrderModel * model = self.dataArray[indexPath.row];
        [self.cellDelegate setValue:model.value With:@"order" name:model.name];

    }else if([self.lable isEqualToString: @"cate_id"]){
        YHCateModel * model = self.dataArray[indexPath.row];
        
        [self.cellDelegate setValue:model.cate_id With:@"cate_id" name:model.value];
    }
    
}
@end
