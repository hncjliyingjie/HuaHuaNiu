//
//  contentViewController.h
//  MeiPinJie
//
//  Created by mac on 15/11/19.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASIHTTPRequest;
@interface contentViewController : UIViewController
{
    ASIHTTPRequest *videoRequest;
}

@property (nonatomic,strong) UISwipeGestureRecognizer *right;
@property (nonatomic,strong) UISwipeGestureRecognizer *up;
@property (nonatomic,strong) NSString *isWrite;
@property (nonatomic,strong) NSString *isWidth;
@property (nonatomic,strong) NSString *isNiming;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)NSString *ID;
@property (nonatomic, strong)NSString *isAnonymous;
@property (nonatomic, strong)NSString *UserId;
@property (nonatomic, strong)NSString *replyUserid;
@property (nonatomic, strong)NSMutableArray *datasource;
@property (nonatomic, strong)NSString *VideoUrl;
@property (nonatomic, strong)NSString *ThumbUrl;
@property (nonatomic, strong)NSString *fileName;
@property (nonatomic, strong)NSString *fileUrl;
@property (nonatomic, strong)NSString *tongji;
@property (nonatomic, strong)NSDictionary *resultDic;
@property (nonatomic, strong)NSString *downloadisSuccess;
@property (nonatomic, strong)UIImage *shareImage;
@property (nonatomic, strong)NSString *shareUrl;
//评论后改变pinglunlabel的条件
@property (nonatomic, strong)NSString *ispinglun;
@property (nonatomic, assign)int width;
@property (nonatomic, assign)int height;
@end
