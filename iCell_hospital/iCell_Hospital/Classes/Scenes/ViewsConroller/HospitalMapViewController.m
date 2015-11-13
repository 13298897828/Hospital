//
//  HospitalMapViewController.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "HospitalMapViewController.h"

@interface HospitalMapViewController ()<MAMapViewDelegate>

@property(nonatomic,strong)HospitalMapView *map;

@end


@implementation HospitalMapViewController

- (void)loadView{
  
    self.map = [[HospitalMapView alloc] initWithFrame:[UIScreen mainScreen].bounds Hospital:self.hospital];

    self.view = self.map;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}





@end
