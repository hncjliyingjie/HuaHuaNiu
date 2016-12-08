//
//  YHAVPlayTableView.h
//  代言成
//
//  Created by YongHeng on 16/7/26.
//  Copyright © 2016年 YongHeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHSheQuSendView.h"

@interface YHAVPlayTableView : UITableView

@property (strong,nonatomic) NSString *huifumemID;
@property (assign,nonatomic) NSInteger huifutype;

@property (nonatomic,strong) NSArray * commentArray;

//- (instancetype)initWithDelegate:(id)delegate;
@property (nonatomic,strong) NSArray * array;

@property (nonatomic,strong) YHSheQuSendView *sendView;

@end
