//
//  ZMTFreebackViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/12/6.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZMTFreebackViewController.h"
#import "ZTMoreCell.h"

@interface ZMTFreebackViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation ZMTFreebackViewController

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.listTableView registerNib:[UINib nibWithNibName:@"ZTMoreCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZTMoreCell"];
    
    self.navigationItem.title = @"更多评价";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZTMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZTMoreCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//选中样式
    [cell showDataWithModel:self.dataSource[indexPath.row]];
    return cell;
}
#pragma mark -- UITableViewDelegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
