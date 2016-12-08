//
//  YHChouseTableView.h
//  花花牛
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHChouseTableViewDelegate <NSObject>

- (void)setValue:(NSString *)Value With:(NSString *)key name:(NSString *) name;

@end

@interface YHChouseTableView : UITableView

@property (nonatomic,weak) id<YHChouseTableViewDelegate> cellDelegate;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSString *lable;
@end
