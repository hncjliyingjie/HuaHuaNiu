//
//  YHMessageView.m
//  HuaHuaNiu
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "YHMessageViewCon.h"

@implementation YHMessageViewCon



- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // title
    titleLable = [[UILabel alloc] init];
    titleLable.text = self.title;
    
    //内容
    lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ConentViewWidth - 20, 100)];
    lable.numberOfLines = 0;
    lable.text = self.content;
    [self.view addSubview:lable];
    
    // title
    titleLable = [[UILabel alloc] init];
    titleLable.text = self.title;
    
    
}


//- (void)setContent:(NSString *)content{
//    _content = content;
//    lable.text = content;
//}

@end
