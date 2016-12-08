//
//  FWLView.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWLView : UIView
@property (weak, nonatomic) IBOutlet UIButton *fbgaoBtn;//发布广告需求按钮
@property (weak, nonatomic) IBOutlet UIButton *fbzxBtn;//发布资讯按钮
@property (weak, nonatomic) IBOutlet UITableView *customTableView;//显示资讯的cell
@property (weak, nonatomic) IBOutlet UIView *slideView;//横向滑动的view
@property (strong, nonatomic) IBOutlet UIScrollView *topScrollView;//顶部轮播图
@property (weak, nonatomic) IBOutlet UIButton *tongcheng_btn;//同城按钮
@property (weak, nonatomic) IBOutlet UIButton *huodong_btn;//活动促销按钮
@property (weak, nonatomic) IBOutlet UIButton *caifu_btn;//财富榜
@property (weak, nonatomic) IBOutlet UIButton *yishua_btn;//印刷展示
+(FWLView *)creatFWView;
@end
