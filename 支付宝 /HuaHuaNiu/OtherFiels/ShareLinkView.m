//
//  ShareLinkView.m
//  demo
//
//  Created by 肖燊亮 on 2016/11/26.
//  Copyright © 2016年 肖燊亮. All rights reserved.
//

#import "ShareLinkView.h"
#import "SLTextView.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"


@interface ShareLinkView()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UILabel* numberLabel;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,assign)CGFloat itemWH;
@property(nonatomic,assign)CGFloat margin;
@end

@implementation ShareLinkView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //line
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
        label.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
        [self addSubview:label];
        
        //link
        UITextField* textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0.5, frame.size.width - 10, 30)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:12];
        textField.placeholder = @"请输入分享链接";
        textField.leftViewMode = UITextFieldViewModeAlways;
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75, 30)];
        label.text = @"链接地址:";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        textField.leftView = label;
        [self addSubview:textField];
        self.textField = textField;
        
        //line
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, frame.size.width, 0.5)];
        label.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
        [self addSubview:label];
        
        //shareText
        SLTextView* textView = [[SLTextView alloc]initWithFrame:CGRectMake(5, 35, frame.size.width - 10, 50)];
        textView.delegate = self;
        textView.font = [UIFont systemFontOfSize:12];
        textView.placeholder = @"红人分享链接时，要说点什么呢～选填";
        textView.placeholderColor = [UIColor grayColor];
        [self addSubview:textView];
        self.textView = textView;
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width - 50, 85, 50, 25)];
        label.text = @"0/140";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
        self.numberLabel = label;
        
        //line
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, frame.size.width, 0.5)];
        label.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
        [self addSubview:label];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 200, 30)];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        NSMutableAttributedString* str = [[NSMutableAttributedString alloc]initWithString:@"请上传分享图标（可为空）"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [@"请上传分享图标" length])];
        label.attributedText = str;
        [self addSubview:label];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(frame.size.width - 45, 117, 35, 15);
        [button addTarget:self action:@selector(example) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [button setTitle:@"示例" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor darkGrayColor];
        button.layer.cornerRadius = 7.5;
        button.layer.masksToBounds = YES;
        [self addSubview:button];
        
        //photopicker
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _margin = 4;
        _itemWH = 50;
        layout.itemSize = CGSizeMake(_itemWH, _itemWH);
        layout.minimumInteritemSpacing = _margin;
        layout.minimumLineSpacing = _margin;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 145, self.tz_width - 10, 60) collectionViewLayout:layout];
//        CGFloat rgb = 244 / 255.0;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self addSubview:_collectionView];
        [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    float height = 55;
    if (([UIScreen mainScreen].bounds.size.width - 20) < (_selectedPhotos.count + 1 ) * 54) {
        height = 110;
    }
    
    _collectionView.frame = CGRectMake(5, 145, self.bounds.size.width - 10, height);
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        if (self.addBlock) {
            self.addBlock(YES);
        }
    }
}

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        if (self.heigthBlock) {
            self.heigthBlock(YES , _selectedPhotos,_selectedAssets);
        }
    }];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length >= 140) {
        textView.text = [textView.text substringToIndex:140];
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/140",textView.text.length];
}


-(void)example
{
    if (self.exampleBlock) {
        self.exampleBlock(YES);
    }
}
@end
