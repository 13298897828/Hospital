//
//  HospitalDetailViewController.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "HospitalDetailViewController.h"

@interface HospitalDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *hosImageView;
@property (strong, nonatomic) IBOutlet UILabel *hosNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *hosLevelLabel;
@property (strong, nonatomic) IBOutlet UILabel *hosMtype;
@property (strong, nonatomic) IBOutlet UILabel *hosAddressLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;


@end

@implementation HospitalDetailViewController

+ (instancetype)sharedHospitalDetalVC{
    static HospitalDetailViewController *hospitalDetailVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hospitalDetailVC = [[UIStoryboard storyboardWithName:@"HZJStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"HospitalDetailViewController"];
    });
    return hospitalDetailVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.hosAddressLabel.text = self.hospital.address;
    NSString *imgURl = [@"http://tnfs.tngou.net/img" stringByAppendingString:_hospital.img];
    [self.hosImageView sd_setImageWithURL:[NSURL URLWithString:imgURl]];
    self.hosNameLabel.text = self.hospital.name;
    self.hosLevelLabel.text = self.hospital.level;
    self.hosMtype.text = self.hospital.mtype;
    
    
    [self requestData];
}

- (IBAction)showInMapAction:(UIButton *)sender {
    
    HospitalMapViewController *hosMapVC=[HospitalMapViewController new];
    hosMapVC.hospital = self.hospital;
    [self.navigationController pushViewController:hosMapVC animated:YES];
}

- (void)requestData{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
