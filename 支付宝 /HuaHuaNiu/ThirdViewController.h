//
//  ThirdViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-1.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView  * StoreTv;
    NSMutableArray *StoreDataArr;
    // 没数据提示
    UILabel * tisishsl;
    // 全部分类  （使用两个FirstTv，secondTv）  全部  离我最近 的TV   (全部  离我最近  共用第三个ThirdTv)
    //   分类选择相关
    UITableView *FirstTv;
    UITableView *secondTv;
    UITableView *ThirdTv;
    // 请求的数据
    NSArray *allArr;
    // 全部分类 TV 所在的VIew
    UIView *UPView;
    // 是否隐藏 分类
    BOOL IsHide;
    //所有 分类的四个数据源
    NSMutableArray * FirDataArr;
    NSMutableArray * secDataArr;
    NSMutableArray * ThirdDataArr;
    NSMutableArray *ForDataArr;
    // 三或者四 的数据源作为 Third 的数据源
    NSMutableArray *FinallDataArr;
    //判断 FinallDataArr 是 第三或者第四的数据源
    BOOL  isThree;  // yes 是三
    // 第一次进入不用 分类 
    BOOL  isFirstCome;
    
//  城市的展示
    UIView * CityTopView ;
    // 存放地区  和 ScrollViw
    UIScrollView * ScrollVi;
// 市区的Arr；
    NSMutableArray *AreaArr;
  
    
 // 判断是不是搜索进入的 本界面
    BOOL ISSearCH;
    
    //  搜索的参数 dic
  //  NSDictionary *CanShuDic;
    NSString *  SearchConcent;
    
    // 分类的ID
    NSString *cates_ID;
    //  坐标
    NSString *ll ;
    //  is_ll 判断是不是
    NSString * is_ll;
    // 排序
    NSString * orderStr;
    //区域 dic
    NSMutableDictionary * AreaDic;
    // 排序 dic
    NSMutableDictionary  * PaiXuDic;
    
}
@property (nonatomic,strong) NSString * typeStr;
// 获取 分类的ID
-(id)initWithcateId:(NSString *)Str;

//搜索的接口

-(id)initWithConcentStr:(NSString  *)SearStr;
// 请求数据
-(void)makeFenLeiDataWithCates_Id:(NSString *)Str ;
@end
