//
//  WSMoreViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-10.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSMoreViewController : UIViewController<UIScrollViewDelegate>{
    
    UIScrollView *BackScrollView; 
    
    // 总的数据 data.count  大的分类数
    NSMutableArray *DataArr ;
    
    // 每一个小的分类
    NSMutableArray *SmallArr;
}

@end
