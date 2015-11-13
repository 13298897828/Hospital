//
//  HospitalSearchTableViewCell.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "HospitalSearchTableViewCell.h"

@interface HospitalSearchTableViewCell ()
@property (strong, nonatomic) IBOutlet UIView *nearHospitalView;

@property (strong, nonatomic) IBOutlet UIView *searchHospitalView;

@end

@implementation HospitalSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
