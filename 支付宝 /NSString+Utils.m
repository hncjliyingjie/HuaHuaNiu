//
//  NSString+Utils.m
//  ZJWR
//
//  Created by myqu on 14-8-31.
//  Copyright (c) 2014年 3TI. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (CGSize)sizeForStringWithFont:(UIFont*)font
{
    CGSize size = CGSizeMake(0, 0);
    if (self == nil || [self length] < 1)
    {
        return size;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        size = [self sizeWithAttributes:@{ NSFontAttributeName:font}];
    }
    else
    {
        size = [self sizeWithFont:font];
    }
    return size;

}

+ (CGSize)SizeForString:(NSString*)string Font:(UIFont*)font
{
    CGSize size = CGSizeMake(0, 0);
    if (string == nil || [string length] < 1)
    {
        return size;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        size = [string sizeWithAttributes:@{ NSFontAttributeName:font}];
    }
    else
    {
        size = [string sizeWithFont:font];
    }
    return size;
}

+ (CGSize)SizeForString:(NSString*)string Width:(float)width Font:(UIFont*)font
{
    CGSize size = CGSizeMake(0, 0);
    if (string == nil || [string length] < 1)
    {
        return size;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSAttributedString *attributedText =[[NSAttributedString alloc]
                                             initWithString:string
                                             attributes:@{ NSFontAttributeName:font}];
        size = [attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            context:nil].size;
    }
    else
    {
        size = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    }
    return size;
}


-(BOOL)checkTextWithError:(NSString*)error
{
    if(self.length == 0 || self == nil)
    {
        [SVProgressHUD showErrorWithStatus:error];
        return YES;
    }
    return NO;
}

@end
