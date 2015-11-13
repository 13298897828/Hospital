//
//  HospitalSecondTableViewCell.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "HospitalSecondTableViewCell.h"
@interface HospitalSecondTableViewCell ()<MAMapViewDelegate,CLLocationManagerDelegate>
//{
//    CLLocationManager *_locationManager;
//    MAMapView *_mapView;
//}

@property (strong, nonatomic) IBOutlet UIImageView *hosIMageView;
@property (strong, nonatomic) IBOutlet UILabel *hosNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *hosLevelLabel;
@property (strong, nonatomic) IBOutlet UILabel *hosMtypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *hosDistanceLabel;


@property(nonatomic,strong)HospitalMapView *map;



@end

@implementation HospitalSecondTableViewCell


- (void)setHospital:(Hospital *)hospital{
    
    NSString *imgURl = [@"http://tnfs.tngou.net/img" stringByAppendingString:hospital.img];
    [self.hosIMageView sd_setImageWithURL:[NSURL URLWithString:imgURl]];
    
    self.hosNameLabel.text =hospital.name;
    
    self.hosLevelLabel.text = hospital.level;
    
    self.hosMtypeLabel.text = hospital.mtype;
    
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake([hospital.y doubleValue], [hospital.x doubleValue]));
    
    MAMapPoint point2 =[HospitalHelper sharedHospitalHelper].myPoint;
 
    self.hosDistanceLabel.text = [NSString stringWithFormat:@"距离您%.1fkm",MAMetersBetweenMapPoints(point1, point2)*0.001];
    
}


- (void)awakeFromNib {
    self.map = [[HospitalMapView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) Hospital:nil];
    [self.contentView addSubview: self.map];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
