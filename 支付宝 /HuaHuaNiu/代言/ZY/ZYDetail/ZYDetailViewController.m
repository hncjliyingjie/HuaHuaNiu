//
//  ZYDetailViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/12/7.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZYDetailViewController.h"
#import "HHHeaderView.h"
#import "ZYModel.h"
#import "SDCycleScrollView.h"
//友盟分享
#import "UMSocial.h"
#import "CoreUMeng.h"
#import "ZYDetailImgAndTextTableViewCell.h"
#import "ZYDetailFreebackTableViewCell.h"

@interface ZYDetailViewController ()<UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, NSXMLParserDelegate>


@property (nonatomic, strong) HHHeaderView *myHeaderView;//页眉
@property (nonatomic, strong) NSMutableArray *dataArray;//存model的数组
@property (nonatomic, strong) MBProgressHUD *myHUD;//加载菊花
@property (nonatomic, strong) SDCycleScrollView *sdView;//轮播图对象
@property (nonatomic, strong) NSMutableArray *sdDataArray;//轮播图网址数据
@property (nonatomic, strong) NSString *ringURLStr;//轮播图网址
@property (nonatomic, assign) NSInteger type;//记录是图文详情还是
@property (nonatomic, strong) NSMutableArray *imageAndTextDataArray;//图文详情数组
@property (nonatomic, strong) NSMutableArray *freebackDataArray;//评论数组

@end

@implementation ZYDetailViewController
//懒加载
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
        
    }
    return _dataArray;
    
}
- (HHHeaderView *)myHeaderView {
    if (_myHeaderView == nil) {
        _myHeaderView = [HHHeaderView headerView];
    }
    return _myHeaderView;
}
- (NSMutableArray *)sdDataArray {
    if (_sdDataArray == nil) {
        _sdDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _sdDataArray;
}
- (NSMutableArray *)imageAndTextDataArray {
    if (_imageAndTextDataArray ==nil) {
        _imageAndTextDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _imageAndTextDataArray;
}
- (NSMutableArray *)freebackDataArray {
    if (_freebackDataArray == nil) {
        _freebackDataArray = [NSMutableArray array];
    }
    return _freebackDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //默认是图文详情
    [self imageAndTextAction:self.myHeaderView.imageAndTextButton];
    
    //注册cell
    [self.listTableView registerNib:[UINib nibWithNibName:@"ZYDetailImgAndTextTableViewCell" bundle:nil] forCellReuseIdentifier:@"imgAndTextCell"];
    [self.listTableView registerNib:[UINib nibWithNibName:@"ZYDetailFreebackTableViewCell" bundle:nil] forCellReuseIdentifier:@"freebackCell"];
    //cell自适应高度
    self.listTableView.estimatedRowHeight = 80;
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
    
    //请求数据
    [self makeData];
    
    //请求他的评价数据
    [self requestFreebackData];
    
    //初始化轮播图
    [self creatRingView];
    
    //添加页眉
    [self makeUI];
    
    #if 0
    //增加监听，当键盘出现或改变时收到消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键盘退出时收到消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
#endif
    //加载发表视图
    [self makeDiscussView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeUI {
    
    //设置标题
    self.navigationItem.title = @"资源详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    
    
}
- (void)makeHeaderView {
    //加载页眉
    CGFloat labelHeight = self.myHeaderView.profielsHeight.constant;
    self.myHeaderView.frame = CGRectMake(0, 0, ScreenWidth, 729 + labelHeight - 29);
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.myHeaderView.frame.size.width, self.myHeaderView.frame.size.height)];
    [headView addSubview:self.myHeaderView];
    self.listTableView.tableHeaderView = headView;
    
    //收藏按钮添加手势
    UITapGestureRecognizer *collTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCollectImageView:)];
    [self.myHeaderView.collectImageView addGestureRecognizer:collTap];
    //分享按钮添加手势
    UITapGestureRecognizer *shareTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShareImageView:)];
    [self.myHeaderView.shareImageView addGestureRecognizer:shareTap];
    

    //图文详情按钮添加方法
    [self.myHeaderView.imageAndTextButton addTarget:self action:@selector(imageAndTextAction:) forControlEvents:UIControlEventTouchUpInside];
    //他的评价按钮添加方法
    [self.myHeaderView.freebackButton addTarget:self action:@selector(freebackAction:) forControlEvents:UIControlEventTouchUpInside];
}

//加载发表视图
- (void)makeDiscussView {
    //输入框成为第一相应者
//    [self.discussTextField resignFirstResponder];
}

-(void)makeData{
    //加载菊花
    self.myHUD = [[MBProgressHUD alloc] init];
    [self.view addSubview:self.myHUD];
    self.myHUD.mode = MBProgressHUDModeIndeterminate;
    [self.myHUD show:YES];
    
    //清除数据,防止重复添加
    [self.dataArray removeAllObjects];
    [self.imageAndTextDataArray removeAllObjects];
    
    NSString * ShouY = [NSString stringWithFormat:@"%@%@%@",DYUrl,ZYLISTMOREURL, _idStr];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.dataArray removeAllObjects];//将数据源清空
        
        NSMutableDictionary *array=[responseObject objectForKey:@"resource"];
        NSLog(@"资源详情返回数据%@",array);
        //地铁名字
        NSString *ditieNameStr=[array objectForKey:@"name"];
        //描述
        NSString *profilesStr=[array objectForKey:@"profiles"];
        //价格
        NSString *priceStr=[array objectForKey:@"out_price"];
        //媒介位置
        NSString *shengStr=[array objectForKey:@"province"];
        NSString *cityStr=[array objectForKey:@"city"];
        NSString *addressStr=[array objectForKey:@"address"];
        
        //受众人群
        NSString *cover_numStr=[array objectForKey:@"cover_num"];
        //开始时间
        NSString *startStr=[array objectForKey:@"start_time"];
        //结束时间
        NSString *endStr=[array objectForKey:@"end_time"];
        //类型
        NSString *typeStr=[array objectForKey:@"type"];
        //规格
        NSString *widthStr=[array objectForKey:@"width"];
        NSString *heightStr=[array objectForKey:@"height"];
        //代言人名字
        NSString *headNameStr=[array objectForKey:@"nick_name"];
        //代言人头像
        NSString *headImg=[array objectForKey:@"spokesman"];
        //公司名称
        NSString *companyStr=[array objectForKey:@"company_name"];
        
        NSString *idStrs=[array objectForKey:@"id"];
        
        //图文详情
        NSString *detialStr=[array objectForKey:@"detail"];
        NSData *detailData = [detialStr dataUsingEncoding:NSUTF8StringEncoding];
        // 1.根据需要解析的XML数据, 创建NSXMLParser对象
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:detailData];
        
        // 2.设置代理, 通过代理方法告诉NSXMLParser, 需要获取哪些元素和哪些属性
        parser.delegate = self;
        
        // 3.开始解析
        [parser parse];
        
        
        //轮播图
        NSArray*imgArray=[array objectForKey:@"heads"];
        for (int i=0; i<imgArray.count; i++) {
            NSDictionary *imgDic=[imgArray objectAtIndex:i];
            NSString *imgStr=[imgDic objectForKey:@"image"];
            //头像给的是网址，需要转化
            [self.sdDataArray addObject:[NSString stringWithFormat:@"%@/%@", DYUrl, imgStr]];
        }
        
        ZYModel *model=[[ZYModel alloc]init];
        model.name=ditieNameStr;
        model.profiles=profilesStr;
        model.price=priceStr;
        model.province=shengStr;
        model.city=cityStr;
        model.address=addressStr;
        model.cover_num=cover_numStr;
        model.start_time=startStr;
        model.end_time=endStr;
        model.type=typeStr;
        model.width=widthStr;
        model.height=heightStr;
        model.nick_name=headNameStr;
        model.iconURLStr = headImg;
        model.company_name=companyStr;
        model.detail=detialStr;
        model.idStr=idStrs;
        [self.dataArray addObject:model];
        [self.myHeaderView showViewWithModel:model];
        
        self.sdView.imageURLStringsGroup = self.sdDataArray;//轮播图赋值
        [self.listTableView reloadData];//刷新数据
        //加载页眉
        [self makeHeaderView];
        [self.myHUD hide:YES];//隐藏菊花
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.myHUD hide:YES];//隐藏菊花
#if 0
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
#endif 
    }];
}

- (void)requestFreebackData {
    [self.freebackDataArray removeAllObjects];//清空数据
    NSString *url = [NSString stringWithFormat:KZYFreebackURL, DYUrl, @"test", @"1", @"1"];
    [[RequestManger share] requestDataByGetWithPath:url complete:^(NSDictionary *data) {
        if ([[data objectForKey:@"result"] integerValue] == 1) {
            //请求成功
            NSArray *discuss = [data objectForKey:@"discuss"];
            for (NSDictionary *dic in discuss) {
                ZYModel *model = [[ZYModel alloc] init];
                model.nickName = [dic objectForKey:@"nick_name"];
                model.time = [dic objectForKey:@"add_time"];
                model.freebackStr = [dic objectForKey:@"content"];
                model.iconUrlStr = [NSString stringWithFormat:@"%@/%@", DYUrl, [dic objectForKey:@"head"]];
                [self.freebackDataArray addObject:model];
            }
        }
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type == 0) {
        //图文详情
        KMyLog(@"图文详情的个数:%ld", self.imageAndTextDataArray.count);
        return self.imageAndTextDataArray.count;
    } else {
        //他的评论
        return self.freebackDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 0) {
        
        ZYDetailImgAndTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imgAndTextCell"];
        ZYModel *model = self.imageAndTextDataArray[indexPath.row];
        cell.myImageView.image = model.image;
        return cell;
    } else {
        ZYDetailFreebackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"freebackCell"];
        ZYModel *model = self.freebackDataArray[indexPath.row];
        [cell showDataWithModel:model];
        return cell;
    }
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 0) {
        //图文详情
        ZYModel *model = self.imageAndTextDataArray[indexPath.row];
        
        return model.imgHeight;
    } else {
        //他的评论
        return 60;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

//初始化轮播图
- (void)creatRingView {
    self.sdView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 150) imageNamesGroup:@[]];
    //图片点击事件回调
    __weak ZYDetailViewController *BLOCKSELF = self;
    self.sdView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        KMyLog(@"点击的第%ld张", currentIndex);
        BLOCKSELF.ringURLStr = BLOCKSELF.sdDataArray[currentIndex];
        
    };
    
    [self.myHeaderView addSubview:_sdView];
}

//收藏手势方法
- (void)tapCollectImageView:(UITapGestureRecognizer *)tap {
    KMyLog(@"收藏");
    NSString *userID = [[UserDefaultManager shareUserDefaultManager] getUid];
    //收藏地址中 type=0
    NSString *colleUrl = [NSString stringWithFormat:@"%@%@token=test&media_id=%@&user_id=%@&type=0", DYUrl, KDYCollectionURL, _idStr, userID];
    
    [[RequestManger share] requestDataByGetWithPath:colleUrl complete:^(NSDictionary *data) {
        NSString *infoStr = [data objectForKey:@"msg"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"收藏" message:infoStr delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }];
}
//分享手势方法
- (void)tapShareImageView:(UITapGestureRecognizer *)tap {
    KMyLog(@"分享");
    
    NSString * ShareStr =[NSString stringWithFormat:@"www.baidu.com"];
    //李英杰分享了
    NSString * concentStr =[NSString stringWithFormat:@"代言城"];
    //_imgTitle.image
    [CoreUmengShare show:self text:concentStr image:[UIImage imageNamed:@"Default"]];
    //                                           delegate:nil];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = ShareStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url =ShareStr;
    
    [UMSocialData defaultData].extConfig.qqData.url = ShareStr;
    [UMSocialData defaultData].extConfig.qzoneData.url = ShareStr;
    
    NSString *ProductName = @"#笨笨鸟#";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = ProductName;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = ProductName;
    [UMSocialData defaultData].extConfig.qqData.title = ProductName;
    [UMSocialData defaultData].extConfig.qzoneData.title = ProductName;
}

//图文详情按钮方法
- (void)imageAndTextAction:(UIButton *)sender {
    KMyLog(@"图文详情");
    self.type = 0;
    [self.myHeaderView.imageAndTextButton setTitleColor:MainCorlor forState:UIControlStateNormal];
    [self.myHeaderView.freebackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.listTableView reloadData];
}
//他的评价按钮
- (void)freebackAction:(UIButton *)sender {
    KMyLog(@"他的评价");
    self.type = 1;
    [self.myHeaderView.imageAndTextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myHeaderView.freebackButton setTitleColor:MainCorlor forState:UIControlStateNormal];
    [self.listTableView reloadData];
}

#pragma mark -- MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

//评论按钮
- (IBAction)discussAction:(UIButton *)sender {
    KMyLog(@"评论");
}
//购物车按钮
- (IBAction)buyCarAction:(UIButton *)sender {
    KMyLog(@"购物车");
    NSString *userID = [[UserDefaultManager shareUserDefaultManager] getUid];
    NSString *urlStr = [NSString stringWithFormat:KZYBuyCarURL, DYUrl, @"test", _idStr, userID];
    [[RequestManger share] requestDataByGetWithPath:urlStr complete:^(NSDictionary *data) {
        NSString *infoStr = [data objectForKey:@"msg"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"加入购物车" message:infoStr delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }];

}
//立即购买按钮
- (IBAction)buyNowAction:(UIButton *)sender {
    KMyLog(@"立即购买");
}
//发表评论按钮方法
- (IBAction)commentAction:(UIButton *)sender {
    KMyLog(@"发表品论");
}
#pragma mark - NSXMLParserDelegate
// 只要开始解析XML文档就会调用
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    KMyLog(@"DidStartDocument");
}
// 只要解析完毕XML文档就会调用
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    KMyLog(@"DidEndDocument");
    //给图文详情赋值
    [self.listTableView reloadData];
}
// 只要开始解析一个元素就会调用
// elementName : 元素名称
// attributeDict : 元素中的属性
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"img"]) {
        ZYModel *model = [[ZYModel alloc] init];
        model.myImageView = [UIImageView new];
        NSString *imgURLStr = [attributeDict objectForKey:@"src"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", DYUrl, imgURLStr]];
        [model.myImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //原始宽高
            CGFloat width = image.size.width;
            CGFloat height = image.size.height;
            //适应屏幕后宽高
            CGFloat width_new = ScreenWidth - 20;
            CGFloat height_new = width_new * height / width;
            model.imgWidth = width_new;
            model.imgHeight = height_new;
            model.image = image;
            KMyLog(@"原始宽高%f==%f", image.size.width, image.size.height);
            KMyLog(@"新的宽高%f==%f", width_new, height_new);
            model.myImageView.frame = CGRectMake(10, 0, width_new, height_new);
            [self.imageAndTextDataArray addObject:model];
            [self.listTableView reloadData];
        }];
    }
    
}

// 只要解析完一个元素就会调用
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}
// 解析出现错误时调用
- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    KMyLog(@"error");
}
#if 0
/**
 * 功能：当键盘出现或改变时调用
 */
- (void)keyboardWillShow:(NSNotification *)aNotification {
    // ------获取键盘的高度
    NSDictionary *userInfo    = [aNotification userInfo];
    //结束的frame
    NSValue *beginValue           = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardBeginRect       = [beginValue CGRectValue];
    NSInteger KBeyBeginHeight              = keyboardBeginRect.size.height;
    //结束的frame
    NSValue *aValue           = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect       = [aValue CGRectValue];
    NSInteger KBHeight              = keyboardRect.size.height;
    self.discussTextField.inputAccessoryView = nil;
    self.discussViewBottom.constant = - 30;
    //定义存放键盘动画时间用来让发送的view进行动画效果
    NSTimeInterval time = 0;
    //获取键盘的动画时间 UIKeyboardAnimationDurationUserInfoKey
    NSNumber *timeNum           = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
     //把值放给time
    [timeNum getValue:&time];
    // ------键盘出现或改变时的操作代码
    //因为view会改变  所以layoutIfNeeded  刷新布局
    [UIView animateWithDuration:time animations:^{
        
        [self.view layoutIfNeeded];
    }];
}

/**
 * 功能：当键盘退出时调用
 */
- (void)keyboardWillHide:(NSNotification *)aNotification {
    // ------键盘退出时的操作代码
    // ------获取键盘的高度
    NSDictionary *userInfo    = [aNotification userInfo];
    // 把约束改成开始的 0
    self.discussViewBottom.constant = 0 ;
    //定义存放键盘动画时间用来让发送的view进行动画效果
    NSTimeInterval time = 0;
    //获取键盘的动画时间 UIKeyboardAnimationDurationUserInfoKey
    NSNumber *timeNum           = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //把值放给time
    [timeNum getValue:&time];
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        // 布控子视图
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
#endif
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
