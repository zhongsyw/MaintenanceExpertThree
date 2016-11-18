//
//  ZSHomeMapView.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/10.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSHomeMapView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ZSHomeMapView ()<MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) NSString *currentLatitude;    //  纬度
@property (strong, nonatomic) NSString *currentLongitude;   //  经度

@end

@implementation ZSHomeMapView


//- (CLLocationManager *)locationManager {
//    if (!_locationManager) {
//        _locationManager = [[CLLocationManager alloc] init];
//        
//        // 版本适配
//        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//            [_locationManager requestAlwaysAuthorization];
//        }
//    }
//    return _locationManager;
//}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor cyanColor];
        
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
        [_mapView setShowsUserLocation:YES];
        
        
        [self creatMapVew];
        
    }
    
    return self;
}



- (void)creatMapVew {
    
    _mapView = [[MKMapView alloc] initWithFrame:self.bounds];
    [self addSubview:_mapView];
    _mapView.delegate = self;
    _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    //  地图样式（标准地图）
    _mapView.mapType = MKMapTypeStandard;
    
    
    
//    CLLocationCoordinate2D centerCoordinate;
//    centerCoordinate.latitude = 35.9097;
//    centerCoordinate.longitude = 115.3476;
//    MKCoordinateSpan span;
//    span.latitudeDelta = 5;
//    span.longitudeDelta = 5;
//    MKCoordinateRegion region;
//    region.center = centerCoordinate;
//    region.span = span;
    
    
    
    // 设置地图的控制项
    // 是否可以滚动
    self.mapView.scrollEnabled = YES;
    // 缩放
    self.mapView.zoomEnabled = YES;
    // 旋转
    self.mapView.rotateEnabled = NO;
    
    // 设置地图的显示项(注意::版本适配)
    // 显示建筑物
    self.mapView.showsBuildings = YES;
    // 指南针
    self.mapView.showsCompass = YES;
    // 兴趣点
    self.mapView.showsPointsOfInterest = NO;
    // 比例尺
    self.mapView.showsScale = YES;
    // 交通
    self.mapView.showsTraffic = YES;
    
    
    //  显示用户位置
    [self locationManager];
    
    // 显示用户位置, 但是地图并不会自动放大到合适比例
//    self.mapView.showsUserLocation = YES;
    
    
    
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(36.088142,120.380310), 1000, 1000) animated:YES];
    
    
}



- (void)showUserLocation:(id)sender {
    
    MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.02);
    MKCoordinateRegion region=MKCoordinateRegionMake(_mapView.userLocation.coordinate, span);
    [_mapView setRegion:region animated:YES];
    
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    NSLog(@"纬度:%f 经度:%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.currentLatitude = [NSString stringWithFormat:@"%.4f",userLocation.location.coordinate.latitude];
    self.currentLongitude = [NSString stringWithFormat:@"%.4f",userLocation.location.coordinate.longitude];
    
//    [self initLocationData];
    
    //    设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(_mapView.region.center, span);
    [_mapView setRegion:region animated:true];
    
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
