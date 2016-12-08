//
//  FXTWView.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "FXTWView.h"
#import "PlaceholderTextView.h"
@implementation FXTWView
//分享图文的view
+(FXTWView *)creatView{
    FXTWView *shareView=[[[NSBundle mainBundle]loadNibNamed:@"FXTWView" owner:self options:nil]firstObject];
    shareView.frame=CGRectMake(0, 0, ConentViewWidth, 220);
    shareView.tag=1002;
    UIView *fxView=[shareView viewWithTag:101];
    shareView.layer.cornerRadius=5;
    fxView.layer.cornerRadius=5;
    fxView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    fxView.layer.borderWidth=0.5;
    
    UILabel *shiliLbl=[shareView viewWithTag:104];
    shiliLbl.layer.cornerRadius=5;
    shiliLbl.clipsToBounds=YES;
    
    PlaceholderTextView *textView=(PlaceholderTextView *)[shareView viewWithTag:1005];
    textView.Placeholder=@"输入直发内容，不超过140字";
    
    return shareView;

}
//分享链接的view
+(FXTWView *)creatFirstView{
     FXTWView *shareView=[[[NSBundle mainBundle]loadNibNamed:@"FXTWView" owner:self options:nil]objectAtIndex:1];
    shareView.frame=CGRectMake(0, 0, ConentViewWidth, 220);
    shareView.tag=1001;
    UIView *fxView=[shareView viewWithTag:102];
    shareView.layer.cornerRadius=5;
    fxView.layer.cornerRadius=5;
    fxView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    fxView.layer.borderWidth=0.5;
    
    UILabel *shiliLbl=[shareView viewWithTag:103];
    shiliLbl.layer.cornerRadius=5;
    shiliLbl.clipsToBounds=YES;
    
    PlaceholderTextView *textView=(PlaceholderTextView *)[shareView viewWithTag:1006];
    textView.Placeholder=@"代言人分享链接时，要说点什么呢~选填";
    return shareView;
}

-(void)styleWithBtn{
    
    self.fxljBtn.tag=1;

}

-(void)styleWithOtherBtn{
    
    self.fxtwBtn.tag=2;

}
@end
