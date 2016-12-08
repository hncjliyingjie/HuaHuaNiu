////
////  DaiLIShangMapViewController.m
////  HuaHuaNiu
////
////  Created by 张燕 on 15-3-23.
////  Copyright (c) 2015年 张燕. All rights reserved.
////
//
//#import "DaiLIShangMapViewController.h"
//#import "BMapKit.h"
//#import "WanShangModel.h"
//@interface DaiLIShangMapViewController ()<BMKMapViewDelegate, BMKPoiSearchDelegate>
//{
//
//    BMKPoiSearch * _searcher;
//}
//
//@end
//
//@implementation DaiLIShangMapViewController
//-(id)initWithArr:(NSMutableArray *)Arr{
//    self =[super init];
//    if (self) {
//        DataArr = Arr;
//    }
//    return self;
//
//}
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    //1. 创建百度地图
//    _mapView = [[BMKMapView alloc]init];
//    self.view =_mapView;
//    
//    //2. 切换为卫星图
//    [_mapView setMapType:BMKMapTypeSatellite];
//    
//    //3. 打开实时路况图层 --> iOS9也可以实现
//    [_mapView setTrafficEnabled:YES];
//    
//    //4. 打开百度城市热力图图层（百度自有数据）
//    [_mapView setBaiduHeatMapEnabled:YES];
//    
//    //5. 添加一个PointAnnotation
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = 39.915;
//    coor.longitude = 116.404;
//    annotation.coordinate = coor;
//    annotation.title = @"这里是北京";
//    [_mapView addAnnotation:annotation];
//    
//    
//    // 延迟调用
//    [self performSelector:@selector(poiSearch) withObject:nil afterDelay:2];
//    
//    //7. 设置地图显示层级--> 显示跨度
//    //3~20 3最大, 20最小
//    [_mapView setZoomLevel:16];
//}
//
//- (void)poiSearch
//{
//    //6. POI搜索
//    //1. 初始化检索对象
//    _searcher =[[BMKPoiSearch alloc]init];
//    _searcher.delegate = self;
//    
//    //2. 发起检索 - 拼接参数
//    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//    option.pageIndex = 0;
//    option.pageCapacity = 10;
//    option.location = CLLocationCoordinate2DMake(39.915, 116.404);
//    option.keyword = @"小吃";
//    
//    // 发送请求
//    BOOL flag = [_searcher poiSearchNearBy:option];
//    
//    if(flag)
//    {
//        NSLog(@"周边检索发送成功");
//    }
//    else
//    {
//        NSLog(@"周边检索发送失败");
//    }
//}
//
////实现PoiSearchDeleage处理回调结果
//- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
//{
//    if (error == BMK_SEARCH_NO_ERROR) {
//        //在此处理正常结果
//        
//        for (BMKPoiInfo *poiInfo in poiResultList.poiInfoList) {
//            
//            //添加一个PointAnnotation
//            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//            annotation.coordinate = poiInfo.pt;
//            annotation.title = poiInfo.name;
//            [_mapView addAnnotation:annotation];
//        }
//        
//        
//        
//        
//    }
//    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
//        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
//        // result.cityList;
//        NSLog(@"起始点有歧义");
//    } else {
//        NSLog(@"抱歉，未找到结果");
//    }
//}
//
//
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [_mapView viewWillAppear];
//    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [_mapView viewWillDisappear];
//    _mapView.delegate = nil; // 不用时，置nil
//    
//    _searcher.delegate = nil;//不使用时将delegate设置为 nil
//}
//@end











//
//  DaiLIShangMapViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-23.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "DaiLIShangMapViewController.h"
#import "BMapKit.h"
#import "WanShangModel.h"
@interface DaiLIShangMapViewController ()

@end

@implementation DaiLIShangMapViewController
-(id)initWithArr:(NSMutableArray *)Arr{
    self =[super init];
    if (self) {
        DataArr = Arr;
    }
    return self;

}
- (void)viewDidLoad {
    self.view.backgroundColor =BackColor;
    [super viewDidLoad];
//    NSArray * LLarr = [[NSArray alloc]init];
//  
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth,ConentViewHeight)];
//    self.view = _mapView;
    [self.view addSubview:_mapView];
    _mapView.zoomLevel = 16;
    // 定位
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
//  添加大头针
    
    [self makeAnnotations];
    
    //113.718054,34.7590495
    //初始化BMKLocationService
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    //启动LocationService
//    [_locService startUserLocationService];
//    
//    //  反检索
//    _geocodesearch =[[BMKGeoCodeSearch alloc]init];
//    _geocodesearch.delegate =self;
//    
  // Do any additional setup after loading the view.
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];

    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title=@"地图";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//  添加大头针
-(void)makeAnnotations{
    // 根据穿的数组字典获取  位置和标题
    NSMutableArray *AnnotatioArr =[[NSMutableArray alloc]init];
    for (int i = 0 ; i< DataArr.count; i++) {
        WanShangModel * storeModel =DataArr[i];
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
       
        annotation.title =storeModel.storeName;
        
        NSString * lllstr =storeModel.storeAddress_ll;
        //(@"zuobia == %@  i == %d",lllstr,i);
        LLarr =[[NSArray alloc]initWithArray:[lllstr componentsSeparatedByString:@","]];
        
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
        if (lllstr.length == 0) {
            
        }
        else{
            
            pt = (CLLocationCoordinate2D){ [LLarr[0] floatValue],[LLarr[1] floatValue]};
         
            annotation.coordinate =pt;
            [_mapView addAnnotation:annotation];
            [_mapView selectAnnotation:annotation animated:YES];
            [AnnotatioArr addObject:annotation];
        }
        
        
    }
    [_mapView showAnnotations:AnnotatioArr animated:YES];
//    [_mapView addAnnotations:AnnotatioArr];


}

/// 定位 和 检索
/*
////   处理方向变更；
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    //(@"heading is %@",userLocation.heading);
//}
////处理位置坐标更新
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
//    _mapView.centerCoordinate = userLocation.location.coordinate;
// 
//    
//    
//    //(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    // 定完位置 开始反检索
//    
//    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
//    
//        pt = (CLLocationCoordinate2D){ userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
//   
//    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
//    reverseGeocodeSearchOption.reverseGeoPoint = pt;
//    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
//    if(flag)
//    {
//        //(@"反geo检索发送成功");
//    }
//    else
//    {
//        //(@"反geo检索发送失败");
//    }
//}
//
//-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
//{
//    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//    [_mapView removeAnnotations:array];
//    array = [NSArray arrayWithArray:_mapView.overlays];
//    [_mapView removeOverlays:array];
//    if (error == 0) {
//       BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//       item.coordinate = result.location;
//       item.title = result.address;
//        
//       [_mapView addAnnotation:item];
//        
//        BMKAnnotationView  *AnnotationView =[[BMKAnnotationView alloc]initWithAnnotation:item reuseIdentifier:nil];
//        [_mapView addSubview:AnnotationView];
//        
////        _mapView.centerCoordinate = result.location;
//      //  NSString* titleStr;
//      //  NSString* showmeg;
//     //   titleStr = @"反向地理编码";
//      //  showmeg = [NSString stringWithFormat:@"%@",item.title];
//        
////        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
////        [myAlertView show];
//    }
//}
*/

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    //(@"选择了这个View ");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
