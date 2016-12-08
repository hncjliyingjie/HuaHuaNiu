//
//  XZPTViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/12.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "XZPTViewController.h"
#import "QDXDViewController.h"
#import "Masonry.h"
#import "TFCell.h"
#import "TFModel.h"
@interface XZPTViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *zf_price;//支付金额
- (IBAction)delAction:(id)sender;//点击减号
- (IBAction)addAction:(id)sender;//点击加号
@property (weak, nonatomic) IBOutlet UILabel *shengLbl;//指定地区
@property (weak, nonatomic) IBOutlet UITextField *djTextField;//任务单价的
@property (weak, nonatomic) IBOutlet UIButton *DELBtn;//减号按钮
@property (weak, nonatomic) IBOutlet UIButton *JHBtn;//加号按钮
@property (weak, nonatomic) IBOutlet UIButton *szBtn;//点击设置按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *szViewHeight;//设置view的高度
@property (weak, nonatomic) IBOutlet UIView *szView;//设置的大view
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;//设置是否制定地区按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;//tableview高度
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;//投放数量用的
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;//微信朋友圈按钮
@property (weak, nonatomic) IBOutlet UIButton *wbBtn;//微博按钮
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;//qq按钮

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tfViewHeight;//投放数量的view的高度

@property (weak, nonatomic) IBOutlet UIView *ptView;//发布平台
@property (weak, nonatomic) IBOutlet UIView *firstView;//微信朋友圈view
@property (weak, nonatomic) IBOutlet UIView *threeView;//qq空间view
@property (weak, nonatomic) IBOutlet UIView *everyPriceView;//任务单价
@property (weak, nonatomic) IBOutlet UIView *numberView;//加减数字框
@property (weak, nonatomic) IBOutlet UIView *tfView;//投放view
@property (weak, nonatomic) IBOutlet UIView *dqView;//是否制定地区view
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;//下一步
@property (weak, nonatomic) IBOutlet UILabel *qsLbl;//友情提示label
@property(strong,nonatomic)NSMutableArray *array;//显示几条投放数量

//@property(strong,nonatomic)TFCell *tempCell;//临时存放的cell
@property(strong,nonatomic)UITextField *firstField;
@property(strong,nonatomic)UITextField *secoundField;
@property(strong,nonatomic)UITextField *threeField;

@property(assign,nonatomic)BOOL  selected;//设置是否被开启

@property(strong,nonatomic)NSString *firstStr;
@property(strong,nonatomic)NSString *secoundStr;
@property(strong,nonatomic)NSString *threeStr;


@property(strong,nonatomic)NSDictionary *dic;//上个页面用户填写的信息

@end

@implementation XZPTViewController
{
    NSUserDefaults *defaults;//保存上传的数据
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults =[NSUserDefaults standardUserDefaults];
    self.title=@"发布任务";
    [self viewWithStyle];
    self.dataTableView.delegate=self;
    self.dataTableView.dataSource=self;
    
    self.dataTableView.scrollEnabled=NO;
    
    _firstStr = @"0";
    _secoundStr = @"0";
    _threeStr = @"0";
}
-(void)viewWillAppear:(BOOL)animated{
    self.szView.hidden=YES;
    self.szViewHeight.constant=40;
    
    //判断设置按钮是否开启，开启显示，不开启，不显示
    if (_selected ) {
        self.szViewHeight.constant=80;
        self.szView.hidden=NO;
    }else{
        
        self.szViewHeight.constant=40;
        self.szView.hidden=YES;
    }
    
}
//接收用户填写的信息传到该页面
-(void)initWithYonghuXinxi:(NSDictionary *)dict{
    
    _dic=dict;
}

-(NSMutableArray *)array{
    if (_array==nil) {
        _array=[NSMutableArray array];
    }
    return _array;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _array.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TFCell *cell;
    
    if (indexPath.row==0) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"TFCell" owner:self options:nil]firstObject];
        [cell.jiahaoBtn addTarget:self action:@selector(addDone:) forControlEvents:UIControlEventTouchUpInside];
        [cell.jianhaoBtn addTarget:self action:@selector(delFirstDone:) forControlEvents:UIControlEventTouchUpInside];
        cell.jiahaoBtn.tag=indexPath.row;
        cell.jianhaoBtn.tag=indexPath.row;
        _firstField=cell.tfTextField;
        _firstField.delegate=self;
//        [defaults setObject:_firstField.text forKey:@"wx_number"];
        
        if (self.wxBtn.selected==YES) {
            _firstStr=[NSString stringWithFormat:@"%@",_firstField.text];
            [self changeValue];
//            BOOL check=self.wxBtn.selected;
//            //区分选中的是哪个平台
//            [defaults setBool:check forKey:@"wxselected"];
        }
        if (self.wxBtn.selected==NO) {
            _firstStr=0;
            [self changeValue];
//            BOOL check=self.wxBtn.selected;
//            //区分选中的是哪个平台
//            [defaults setBool:check forKey:@"wxselected"];
        }
        
    }
    
    if (indexPath.row==1) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"TFCell" owner:self options:nil]firstObject];
        [cell.jiahaoBtn addTarget:self action:@selector(addsecoundDone:) forControlEvents:UIControlEventTouchUpInside];
        [cell.jianhaoBtn addTarget:self action:@selector(delSecoundDone:) forControlEvents:UIControlEventTouchUpInside];
        cell.jiahaoBtn.tag=indexPath.row;
        cell.jianhaoBtn.tag=indexPath.row;
        _secoundField=cell.tfTextField;
        _secoundField.delegate=self;
//        [defaults setObject:_secoundField.text forKey:@"wb_number"];
        if (self.wbBtn.selected==YES) {
            _secoundStr=[NSString stringWithFormat:@"%@",_secoundField.text];
            [self changeValue];
//            BOOL check=self.wbBtn.selected;
//            //区分选中的是哪个平台
//            [defaults setBool:check forKey:@"wbselected"];
        }
        if (self.wbBtn.selected==NO) {
            _secoundStr=0;
            [self changeValue];
//            BOOL check=self.wbBtn.selected;
//            //区分选中的是哪个平台
//            [defaults setBool:check forKey:@"wbselected"];
        }
        
    }
    
    if (indexPath.row==2) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"TFCell" owner:self options:nil]firstObject];
        [cell.jiahaoBtn addTarget:self action:@selector(addthreeDone:) forControlEvents:UIControlEventTouchUpInside];
        [cell.jianhaoBtn addTarget:self action:@selector(delThreeDone:) forControlEvents:UIControlEventTouchUpInside];
        cell.jiahaoBtn.tag=indexPath.row;
        cell.jianhaoBtn.tag=indexPath.row;
        _threeField=cell.tfTextField;
        _threeField.delegate=self;
//        [defaults setObject:_threeField.text forKey:@"qq_number"];
        if (self.qqBtn.selected==YES) {
            _threeStr=_secoundStr=[NSString stringWithFormat:@"%@",_threeField.text];
            [self changeValue];
//            BOOL check=self.qqBtn.selected;
            //区分选中的是哪个平台
//            [defaults setBool:check forKey:@"qqselected"];
        }
        if (self.qqBtn.selected==NO) {
            _threeStr=0;
            [self changeValue];
//            BOOL check=self.qqBtn.selected;
            //区分选中的是哪个平台
//            [defaults setBool:check forKey:@"qqselected"];
        }
        
    }
    
    TFModel *model=_array[indexPath.row];
    cell.imgView.image=model.img;
    self.dataTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

#pragma mark  UITextFieldDelegate
//输入完调用
- ( void )textFieldDidEndEditing:( UITextField *)textField

{
    _firstStr = 0;
    _secoundStr = 0;
    _threeStr = 0;
    
    for(int i = 0 ;i < _array.count; i++){
        if (i == 0) {
            _firstStr=[NSString stringWithFormat:@"%@",_firstField.text];
        }
        else if (i == 1){
            _secoundStr=[NSString stringWithFormat:@"%@",_secoundField.text];
        }
        else{
            _threeStr=[NSString stringWithFormat:@"%@",_threeField.text];
        }
    }
    [self changeValue];
    
}
-(void)changeValue{
    
    NSString *djStr=_djTextField.text;
    double sum_price=(_firstStr.doubleValue+_secoundStr.doubleValue+_threeStr.doubleValue)*(djStr.doubleValue);
    self.zf_price.text=[NSString stringWithFormat:@"%.1f",sum_price];
    
}

#pragma mark actions
//投放数量的减号加号
-(void)addDone:(id)sender{
    
    NSString *str=_firstField.text;
    double lblStr=str.doubleValue+1;
    
    int lblStr_new=(int)lblStr;
    _firstField.text=[NSString stringWithFormat:@"%d",lblStr_new];
    _firstStr=_firstField.text;
    
    [defaults setObject:_firstField.text forKey:@"wx_number"];
    [self changeValue];
    
    
}
-(void)delFirstDone:(id)sender{
    
    NSString *str=_firstField.text;
    if(str.doubleValue == 0){
        return;
    }
    double lblStr=str.doubleValue-1;
    int lblStr_new=(int)lblStr;
    //减数的时候，textfield显示的数字
    _firstField.text=[NSString stringWithFormat:@"%d",lblStr_new];
    //将显示的数字赋给str，计算总数
    _firstStr=_firstField.text;
    [defaults setObject:_firstField.text forKey:@"wx_number"];
    [self changeValue];
    
    
}
-(void)addsecoundDone:(id)sender{
    NSString *str=_secoundField.text;
    double lblStr=str.doubleValue+1;
    int lblStr_new=(int)lblStr;
    _secoundField.text=[NSString stringWithFormat:@"%d",lblStr_new];
    _secoundStr=_secoundField.text;
    [defaults setObject: _secoundField.text forKey:@"wb_number"];
    [self changeValue];
    
    
    
}
-(void)delSecoundDone:(id)sender{
    
    NSString *str=_secoundField.text;
    if(str.doubleValue == 0){
        return;
    }
    double lblStr=str.doubleValue-1;
    int lblStr_new=(int)lblStr;
    _secoundField.text=[NSString stringWithFormat:@"%d",lblStr_new];
    _secoundStr=_secoundField.text;
    
    [defaults setObject: _secoundField.text forKey:@"wb_number"];
    [self changeValue];
    
}

-(void)addthreeDone:(id)sender{
    NSString *str=_threeField.text;
    double lblStr=str.doubleValue+1;
    int lblStr_new=(int)lblStr;
    _threeField.text=[NSString stringWithFormat:@"%d",lblStr_new];
    _threeStr=_threeField.text;
    [defaults setObject:_threeField.text forKey:@"qq_number"];
    [self changeValue];
}

-(void)delThreeDone:(id)sender{

    NSString *str=_threeField.text;
    if(str.doubleValue == 0){
        return;
    }
    double lblStr=str.doubleValue-1;
    int lblStr_new=(int)lblStr;
    _threeField.text=[NSString stringWithFormat:@"%d",lblStr_new];
    _threeStr=_threeField.text;
    [defaults setObject:_threeField.text forKey:@"qq_number"];
    [self changeValue];
    
}
//点击区分哪个发布平台
-(void)selected:(id)sender{
    UIButton *btn=sender;
    btn.selected=!btn.selected;
    TFModel *model=[[TFModel alloc]init];
    if (btn.tag==1) {
        [btn setImage:[UIImage imageNamed:@"wx.png"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"wx_hui.png"] forState:UIControlStateNormal];
        if (btn.selected==YES) {
            
            model.img=[UIImage imageNamed:@"wx.png"];
            model.str=(int)btn.tag;
            _firstStr = @"500";
            [self.array addObject:model];
            [defaults setBool:YES forKey:@"wxselected"];
            
        }
        
        if (btn.selected==NO) {
            for (TFModel *model in self.array.copy) {
                if (model.str==btn.tag) {
                    _firstStr=0;
                    [self.array removeObject:model];
                    [defaults setBool:NO forKey:@"wxselected"];
                }
                
            }
        }
    }
    if (btn.tag==2) {
        [btn setImage:[UIImage imageNamed:@"wb.png"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"wb_hui.png"] forState:UIControlStateNormal];
        if (btn.selected==YES) {
            
            model.img=[UIImage imageNamed:@"wb.png"];
            model.str=(int)btn.tag;
            _secoundStr=@"500";
            [self.array addObject:model];
             [defaults setBool:YES forKey:@"wbselected"];
        }
        if (btn.selected==NO) {
            for (TFModel *model in self.array.copy) {
                if (model.str==btn.tag) {
                    _secoundStr=0;
                    [self.array removeObject:model];
                     [defaults setBool:NO forKey:@"wbselected"];
                }
                
            }
        }
    }
    if (btn.tag==3) {
        [btn setImage:[UIImage imageNamed:@"qq.png"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"qq_hui.png"] forState:UIControlStateNormal];
        if (btn.selected==YES) {
            model.img=[UIImage imageNamed:@"qq.png"];
            model.str=(int)btn.tag;
            _threeStr=@"500";
            [self.array addObject:model];
             [defaults setBool:YES forKey:@"qqselected"];
        }
        if (btn.selected==NO) {
            for (TFModel *model in self.array.copy) {
                if (model.str==btn.tag) {
                    _threeStr=0;
                    [self.array removeObject:model];
                     [defaults setBool:NO forKey:@"qqselected"];
                }
                
            }
        }
    }
    
    //当数组没有元素的时候，重载tableview不进入方法
    if (_array.count==3) {
        self.tfViewHeight.constant=180.0f;
        self.tableViewHeight.constant=130.0f;
        
    }
    if (_array.count==2) {
        self.tfViewHeight.constant=140.0f;
        self.tableViewHeight.constant=90.0f;
        
    }
    if (_array.count==1) {
        self.tfViewHeight.constant=100.0f;
        self.tableViewHeight.constant=50.0f;
        
    }
    if (_array.count==0) {
        self.tfViewHeight.constant=60.0f;
        self.tableViewHeight.constant=0.0f;
        
    }
    [self.dataTableView reloadData];
    
}
//单价点击减号
- (IBAction)delAction:(id)sender {
    
    NSString *str=self.djTextField.text;
    if(str.doubleValue == 0){
        return;
    }
    double lblStr=str.doubleValue -1;
    self.djTextField.text=[NSString stringWithFormat:@"%.2lf",lblStr];
    //任务单价
    [defaults setObject:self.djTextField.text forKey:@"every_price"];
    [self changeValue];
    
}
//单价点击加号
- (IBAction)addAction:(id)sender {
    
    NSString *str=self.djTextField.text;
    double lblStr=str.doubleValue +1;
    self.djTextField.text=[NSString stringWithFormat:@"%.2lf",lblStr];
    //任务单价
    [defaults setObject:self.djTextField.text forKey:@"every_price"];
    [self changeValue];
    
}
//下一步
-(void)nextDo:(id)snedr{
    
    NSString *every_price=[NSString stringWithFormat:@"%@",_djTextField.text];
    NSString *sum_price=[NSString stringWithFormat:@"%@", _zf_price.text];
    NSString *sum_people=[NSString stringWithFormat:@"%.0f",(_firstStr.doubleValue+_secoundStr.doubleValue+_threeStr.doubleValue)];
    NSString *area=[NSString stringWithFormat:@"%@",_shengLbl.text];
    
    NSDictionary* sumPeopleDic = @{@"every_price" : every_price,
                                   @"sum_price" : sum_price,
                                   @"people_number" : sum_people,
                                   @"area":area};
    QDXDViewController *qdxdVC=[[QDXDViewController alloc]initWithNibName:@"QDXDViewController"bundle:nil];
    [qdxdVC initWithFirstXinXi:_dic andXuanZePingTaiXinxi:sumPeopleDic];
    [self.navigationController pushViewController:qdxdVC animated:YES];
    
}

//设置按钮
-(void)switchAction:(id)sender{
    
    UISwitch *switchBtn=sender;
    bool isButtOn=[switchBtn isOn];
    if (isButtOn) {
        self.szViewHeight.constant=80;
        self.szView.hidden=NO;
        NSString *zhiding_area=self.shengLbl.text;
        [defaults setObject:zhiding_area forKey:@"zhidingdiqu"];
    }else{
        
        self.szViewHeight.constant=40;
        self.szView.hidden=YES;
    }
    _selected=isButtOn;
    
}

-(void)viewWithStyle{
    //给三个平台设置tag值区分点击的是哪个按钮
    self.wxBtn.tag=1;
    self.wbBtn.tag=2;
    self.qqBtn.tag=3;
    [self.wxBtn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.wbBtn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.qqBtn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    
    self.ptView.layer.cornerRadius=5;
    self.ptView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.ptView.layer.borderWidth=0.5;
    
    self.firstView.layer.cornerRadius=5;
    
    self.threeView.layer.cornerRadius=5;
    
    
    self.everyPriceView.layer.cornerRadius=5;
    self.everyPriceView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.everyPriceView.layer.borderWidth=0.5;
    
    self.numberView.layer.cornerRadius=5;
    self.numberView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.numberView.layer.borderWidth=0.5;
    
    
    self.tfView.layer.cornerRadius=5;
    self.tfView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.tfView.layer.borderWidth=0.5;
    
    self.dqView.layer.cornerRadius=5;
    self.dqView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.dqView.layer.borderWidth=0.5;
    
    self.nextBtn.layer.cornerRadius=12;
    self.nextBtn.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.nextBtn.layer.borderWidth=0.5;
    [self.nextBtn addTarget:self action:@selector(nextDo:) forControlEvents:UIControlEventTouchUpInside];
    self.qsLbl.text=@"友情提示：\r\n1.严禁违法违规欺骗垫钱等任务，一经发现，官方进行封号并冻结任务资金;2.任务单价2元起，注册下载或推广app类的任务单价5元起（借贷宝单价10元起）,投放数量100个起。";
    
    [self.switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    
    self.szBtn.layer.cornerRadius=15;
    self.szBtn.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.szBtn.layer.borderWidth=0.5;
    self.djTextField.delegate=self;
    
    //一开始设置为no
    [defaults setBool:NO forKey:@"wxselected"];
     [defaults setBool:NO forKey:@"wBselected"];
     [defaults setBool:NO forKey:@"qqselected"];
    
}
@end
