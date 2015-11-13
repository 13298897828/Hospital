//
//  DiagnoseInfoViewController.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "DiagnoseInfoViewController.h"

@interface DiagnoseInfoViewController ()

@end

@implementation DiagnoseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"DiagnoseInfoDetail" bundle:nil] forCellReuseIdentifier:@"infoCellId"];
    
    //设定cell根据内容自适应高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiagnoseInfoDetail *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCellId" forIndexPath:indexPath];
    
    cell.info = _info;
    
    cell.toInterest = ^(){
        Diagnose_InterestViewController *interestVC = [Diagnose_InterestViewController new];
        interestVC.url = _info.url;
        [self.navigationController pushViewController:interestVC animated:YES];

    };
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
