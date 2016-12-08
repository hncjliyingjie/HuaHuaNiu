//
//  ProductDetailViewController2.h
//  HuaHuaNiu
//
//  Created by 洪慧康 on 16/3/28.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController2 : UIViewController{
    NSString *ProductId ;
    NSDictionary *DicDate;
}

@property(nonatomic,strong)NSString *strName;
@property(nonatomic,strong)IBOutlet UIImageView *imgTitle;
@property(nonatomic,strong)IBOutlet UILabel *labelTitle;
@property(nonatomic,strong)IBOutlet UILabel *yinYuanlTitle;
@property(nonatomic,strong)IBOutlet UILabel *dingJiaTitle;
@property(nonatomic,strong)IBOutlet UILabel *yiLiuLanlTitle;
@property(nonatomic,strong)IBOutlet UILabel *xuLiuLanTitle;
@property(nonatomic,strong)IBOutlet UILabel *youFeiTitle;
@property(nonatomic,strong)IBOutlet UILabel *totalNumTitle;
@property (strong, nonatomic) IBOutlet UIButton *lijiDuiHuan;

@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;


-(id)initWithStr:(NSString *)str;
@property (strong, nonatomic) IBOutlet UIView *fenGeXianView;
@end
