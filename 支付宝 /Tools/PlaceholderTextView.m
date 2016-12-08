//
//  PlaceholderTextView.m
//  PlaceholderTextView
//
//  Created by 胡旭 on 14/12/12.
//  Copyright (c) 2014年 huxu. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView()<UITextViewDelegate>

@property(nonatomic,strong)UILabel *PlaceholderLabel;

@end

@implementation PlaceholderTextView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
        self.delegate = self;
    }
    return self;
}

-(void)awakeFromNib
{
    //注册消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
    
    float left=5,top=0,hegiht=30;
    
    self.PlaceholderColor = [UIColor lightGrayColor];
    self.PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                               , CGRectGetWidth(self.frame)-2*left, hegiht)];
    self.PlaceholderLabel.font=self.PlaceholderFont?self.PlaceholderFont:self.font;
    self.PlaceholderLabel.textColor=self.PlaceholderColor;
    [self addSubview:self.PlaceholderLabel];
    self.PlaceholderLabel.text=self.Placeholder;
}

//设置水印字符串时候出现
-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        self.PlaceholderLabel.hidden=YES;
    }
    else
        self.PlaceholderLabel.text=placeholder;
    _Placeholder=placeholder;
}

-(void)DidChange:(NSNotification*)notification{
//    if ([self.text rangeOfString:@"\n"].length>0) {
//        self.text = [self.text substringWithRange:NSMakeRange(0, self.text.length-1)];
//        [self resignFirstResponder];//释放键盘
//        return;
//    }
    if (self.Placeholder.length == 0 || [self.Placeholder isEqualToString:@""]) {
        self.PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        self.PlaceholderLabel.hidden=YES;
    }
    else{
        self.PlaceholderLabel.hidden=NO;
    }
}

-(void)setPlaceholderFont:(UIFont *)PlaceholderFont
{
    self.PlaceholderLabel.font = PlaceholderFont;
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
//    if((textView.text.length-range.length+text.length)>200)
//    {
//        NSString *substring = [text substringToIndex:200 - (textView.text.length - range.length)];
//        NSMutableString *lastString = [textView.text mutableCopy];
//        [lastString replaceCharactersInRange:range withString:substring];
//        textView.text = [lastString copy];
//    }
    if ([text isEqualToString:@"\n"]) {//检测到“完成”
        [self resignFirstResponder];//释放键盘
        return NO;
    }
    
    return YES;
}

#pragma mark - Private
/**
 *  隐藏水印
 */
-(void)setPlaceholderHidden
{
    self.PlaceholderLabel.hidden = YES;
}

//限制字符
- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length>100)
    {
        textView.text = [textView.text substringToIndex:100];
    }
}

@end
