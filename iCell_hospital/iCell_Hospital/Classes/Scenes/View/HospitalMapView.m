//
//  HospitalMapView.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "HospitalMapView.h"

@interface HospitalMapView ()<MAMapViewDelegate,CLLocationManagerDelegate>
{
    MAMapView *_mapView;
    CLLocationManager *_locationManager;
}
@end

@implementation HospitalMapView

- (instancetype)initWithFrame:(CGRect)frame Hospital:(Hospital *)hospital;{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews:hospital];
        
    }
    return self;
}


- (void)addAllViews:(Hospital *)hospital{
    _locationManager = [[CLLocationManager alloc] init];
    //配置用户Key
    [MAMapServices sharedServices].apiKey = @"a7e74608b4423098e744ca60a5ce5f79";
    
    _mapView = [[MAMapView alloc] initWithFrame:self.frame];
    _mapView.delegate = self;
    
    [self addSubview:_mapView];
    
    _mapView.showsUserLocation  = YES;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow];
    _mapView.zoomLevel = 10;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        _locationManager = [[CLLocationManager alloc] init];
        //设置权限为使用的时候定位
        [_locationManager requestAlwaysAuthorization];
        //
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }

    
    //距离筛选器  设置最小的位置更新提示距离
    _locationManager.desiredAccuracy = 2000;
    
    //设置地图管理类的代理
    _locationManager.delegate = self;
    
    //    当前经纬度
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(_locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude));
    
    //    将经纬度赋值给工具类，以便使用
    [HospitalHelper sharedHospitalHelper].myPoint = point2;
    
    if (hospital !=nil) {
        
        _mapView.centerCoordinate = CLLocationCoordinate2DMake([hospital.y doubleValue], [hospital.x doubleValue]);
    }
}

@end
