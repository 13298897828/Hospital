//
//  HosipitalViewController.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "HosipitalViewController.h"

@interface HosipitalViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *hospitalListArray;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation HosipitalViewController

static NSString *const collectionCellID=@"collectionID";

static NSString *const secondTableID = @"secondTableID";

static NSString *const searchTableID = @"searchTableID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HospitalSearchTableViewCell" bundle:nil] forCellReuseIdentifier:searchTableID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HospitalTableViewCell" bundle:nil] forCellReuseIdentifier:collectionCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HospitalSecondTableViewCell" bundle:nil] forCellReuseIdentifier:secondTableID];
    
    
    //    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width , 20)];
    //    view.backgroundColor = [UIColor greenColor];
    //    self.tableView.tableHeaderView = view;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         [self requestData];
        
    });
    
    
}



- (void)requestData{
    
    NSString *httpArg = @"id=151&page=1&rows=20";
    [[HospitalHelper sharedHospitalHelper] requestHttpUrl:kListhttpUrl withHttpArg:httpArg success:^(id data) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //            static int i=0;
        NSArray *array = dict[@"tngou"];
     
        for (NSDictionary *dic in array) {
            Hospital *hos = [Hospital new];
            [hos setValuesForKeysWithDictionary:dic];
            [self.hospitalListArray addObject:hos];
        }
        [self.dataArray addObject:self.hospitalListArray];
//        [self.tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self .tableView reloadData];
        });
    }];
}

- (IBAction)nearHospitalAction:(UIBarButtonItem *)sender {
    
    
    [self.navigationController pushViewController:[HospitalMapViewController new] animated:YES];
    
}


#pragma mark tableView协议方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        HospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionCellID forIndexPath:indexPath];
        cell.dataArray = self.hospitalListArray;
        return cell;
    }
    if (indexPath.section == 1) {
        HospitalSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchTableID forIndexPath:indexPath];
        return cell;
    }
    
    if (indexPath.section == 2) {
          HospitalSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondTableID forIndexPath:indexPath];
    cell.hospital = self.hospitalListArray[indexPath.row];
    return cell;
    }

    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return self.dataArray.count;
    }
    if (section == 1) {
        return 1;
    }
    return  self.hospitalListArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 300;
    }
    else if(indexPath.section == 1){
        return 50;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return;
    }
    [HospitalDetailViewController sharedHospitalDetalVC].hospital  = self.hospitalListArray[indexPath.row];
    [self.navigationController pushViewController:[HospitalDetailViewController sharedHospitalDetalVC] animated:YES];
    
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)hospitalListArray{
    if (_hospitalListArray == nil) {
        _hospitalListArray = [NSMutableArray arrayWithCapacity:8];
    }
    return _hospitalListArray;
}

@end
