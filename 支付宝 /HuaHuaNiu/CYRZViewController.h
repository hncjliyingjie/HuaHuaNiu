//
//  CYRZViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYRZViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

//  标题Arr
    NSArray * TitleArr ;
// 图片ARR
    NSArray * ImaArr;
// 内容ARR
    NSArray *concentArr;
    // 右上边的View
    
    UIView * TopView;
    
    UITableView * _Tv;
    

    NSMutableArray *DatArr;

}
@property (weak, nonatomic) IBOutlet UIImageView *TopImageViwe;

@end
