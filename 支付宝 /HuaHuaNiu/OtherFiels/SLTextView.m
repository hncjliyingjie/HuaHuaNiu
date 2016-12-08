//
//  SLTextView.m
//  O2O_MeiYe
//
//  Created by 肖燊亮 on 16/7/27.
//  Copyright © 2016年 肖燊亮. All rights reserved.
//

#import "SLTextView.h"

@interface SLTextView()
@property (nonatomic, strong) UILabel *placeHolderLabel;
@end

@implementation SLTextView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChanged:(NSNotification *)notification
{
    if(self.placeholder.length == 0)
    {
        return;
    }
    if(self.text.length == 0)
    {
        self.placeHolderLabel.hidden = NO;
    }
    else
    {
        self.placeHolderLabel.hidden = YES;
    }
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    if(self.placeholder.length > 0)
    {
        if (_placeHolderLabel == nil)
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,self.bounds.size.height - 16)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            [self addSubview:_placeHolderLabel];
        }
        _placeHolderLabel.hidden = YES;
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    if( self.text.length == 0 && self.placeholder.length > 0 )
    {
        self.placeHolderLabel.hidden = NO;
    }
    
    [super drawRect:rect];
}
@end
