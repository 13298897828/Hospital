//
//  Diagnose_SicknessViewController.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "Diagnose_SicknessViewController.h"

@interface Diagnose_SicknessViewController ()

@end

@implementation Diagnose_SicknessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"Diagnose_SicknessCell" bundle:nil] forCellReuseIdentifier:@"sicknessCellId"];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Diagnose_SicknessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sicknessCellId" forIndexPath:indexPath];
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
