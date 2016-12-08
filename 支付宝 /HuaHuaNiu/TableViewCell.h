//
//  TableViewCell.h
//  HuaHuaNiu
//
//  Created by alex on 16/1/4.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UILabel *newsName;
//@property (weak, nonatomic) IBOutlet UILabel *newsLeibie;
//@property (weak, nonatomic) IBOutlet UILabel *newsTime;
//@property (weak, nonatomic) IBOutlet UILabel *newsmain;
@property(nonatomic,strong)UILabel *newsName;
@property(nonatomic,strong)UILabel *newsLeibie;
@property(nonatomic,strong)UILabel *newsTime;
@property(nonatomic,strong)UILabel *newsmain;

-(void)cellMakeDataWithDic:(NSDictionary *)dic;
-(void)cellSearchWithDic:(NSDictionary *)dic;

@end
