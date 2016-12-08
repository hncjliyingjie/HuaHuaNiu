//
//  SharePicTextView.m
//  demo
//
//  Created by 肖燊亮 on 2016/11/26.
//  Copyright © 2016年 肖燊亮. All rights reserved.
//

#import "SharePicTextView.h"
#import "SLTextView.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"

@interface SharePicTextView ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UILabel* numberLabel;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,assign)CGFloat itemWH;
@property(nonatomic,assign)CGFloat margin;
@end

@implementation SharePicTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //line
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
        label.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
        [self addSubview:label];
        
        //shareText
        SLTextView* textView = [[SLTextView alloc]initWithFrame:CGRectMake(5, 5, frame.size.width - 10, 60)];
        textView.delegate = self;
        textView.font = [UIFont systemFontOfSize:12];
        textView.placeholder = @"输入直发内容，不超过140字！";
        textView.placeholderColor = [UIColor grayColor];
        [self addSubview:textView];
        self.textView = textView;
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width - 50, 65, 50, 25)];
        label.text = @"0/140";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
        self.numberLabel = label;
        
        //line
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, frame.size.width, 0.5)];
        label.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
        [self addSubview:label];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 200, 30)];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        NSMutableAttributedString* str = [[NSMutableAttributedString alloc]initWithString:@"内容配图:（最多上传9张）"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [@"内容配图:" length])];
        label.attributedText = str;
        [self addSubview:label];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(frame.size.width - 45, 97, 35, 15);
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 125, self.tz_width - 10, 60) collectionViewLayout:layout];
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
    
    _collectionView.frame = CGRectMake(5, 125, self.bounds.size.width - 10, height);
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
            self.addBlock(NO);
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
            self.heigthBlock(NO , _selectedPhotos,_selectedAssets);
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
        self.exampleBlock(NO);
    }
}

@end
