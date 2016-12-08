//
//  ShareLinkView.h
//  demo
//
//  Created by 肖燊亮 on 2016/11/26.
//  Copyright © 2016年 肖燊亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareLinkView : UIView
@property(nonatomic,strong)UITextField* textField;
@property(nonatomic,strong)UITextView* textView;
@property(nonatomic,copy)void(^exampleBlock)(BOOL isLink);//示例回调
@property(nonatomic,strong)NSMutableArray *selectedPhotos;
@property(nonatomic,strong)NSMutableArray *selectedAssets;
@property(nonatomic,copy)void(^addBlock)(BOOL isLink);//添加图片回调
@property(nonatomic,copy)void(^heigthBlock)(BOOL isLink, NSMutableArray *selectedPhotos,NSMutableArray *selectedAssets);//高度变化回调
@end
