//
//  gouwucellTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-18.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "gouwucellTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
@implementation gouwucellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //不用去选择 
   
  
    self.NumberField.delegate=self;
    self.NumberField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
   
    self.NumberField.textAlignment =NSTextAlignmentCenter;
     self.NumberField.keyboardType =UIKeyboardTypeNumberPad;
    //self.NumberField.userInteractionEnabled = NO;
//  self.PriceLabel.text=[NSString stringWithFormat:@"%@",@"12.03"] ;
    
//    self.NumberField.layer.borderColor=[[UIColor grayColor]CGColor];
//    self.NumberField.layer.borderWidth=0.4f;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.NumberField resignFirstResponder];
}
-(void)cellMakeDateWithDic:(NSDictionary *)dic{
   
    
    UILongPressGestureRecognizer *tap =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(TapAvffd:)];
    tap.delegate=self;
    tap.minimumPressDuration= 1.0f;

    self.DeleImage.userInteractionEnabled = YES;
    [self.DeleImage addGestureRecognizer:tap];
    
    self.NameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];
    self.PriceLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] ;
    [self.IconImagg  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"goods_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    rec_id =[NSString stringWithFormat:@"%@",[dic objectForKey:@"cart_id"]];
    self.NumberField.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"quantity"]];
}
// 删除
-(void)TapAvffd:(UILongPressGestureRecognizer *)longpresssac{
    if (longpresssac.state == UIGestureRecognizerStateEnded) {
        
    }
    else if(longpresssac.state == UIGestureRecognizerStateBegan){
    
    
      delesBllcks(rec_id);
    }
    
  
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //    [self.NumberField resignFirstResponder];
    //如果是结算状态
   
    // self.PriceLabel.text=[NSString stringWithFormat:@"%@",@"12.03"] ;
//    // 数量
//    float Number =[self.NumberField.text floatValue];
//    // 单价
//    float Pricer =[self.PriceLabel.text floatValue];
//    
//    float titall = Number * Pricer ;
        
    //    }
    
    JieSuanBlocks(self.NumberField.text,rec_id);
    
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)MakeJieSuanBlocks:(void (^)(NSString *, NSString *))Blocks{   JieSuanBlocks =[Blocks copy];
}
-(void)deleActionBlocks:(void (^)(NSString *))Blocks{
    delesBllcks =[Blocks copy];

}


@end
