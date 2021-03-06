//
//  Diagnose_SicknessViewController.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "Diagnose_SicknessViewController.h"

@interface Diagnose_SicknessViewController ()<UISearchBarDelegate>
@property(nonatomic,strong)Diagnose_SicknessCell *cell;
@end

@implementation Diagnose_SicknessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设定cell根据内容自适应高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;

    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/symptom/name";
    NSString *typeString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)@"发烧",NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    NSString *httpArg = [NSString stringWithFormat:@"name=%@",typeString];
    [self request: httpUrl withHttpArg: httpArg];

    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"Diagnose_SicknessCell" bundle:nil] forCellReuseIdentifier:@"sicknessCellId"];
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:@"sicknessCellId" forIndexPath:indexPath];
    
    _cell.del = ^(){
        [tableView reloadData];
    };
    
    return _cell;
}


-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"3d3dfb25a74f419547bfef42d666d2b6" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
        if (error) {
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        } else {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            Diagnose_Sickness *sick = [Diagnose_Sickness new];
            [sick setValuesForKeysWithDictionary:dic];
            _cell.sickness = sick;
        }
        
    }];
}


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}



//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 5000;
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
