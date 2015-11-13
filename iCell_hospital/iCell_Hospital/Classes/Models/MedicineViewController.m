//
//  MedicineViewController.m
//  iCell_Hospital
//
//  Created by 张天琦 on 15/11/9.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "MedicineViewController.h"
#import "EFAnimationViewController.h"
#import <UIImageView+WebCache.h>
NSString *httpUrl = @"http://apis.baidu.com/tngou/drug/search";
@interface MedicineViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,assign)NSInteger num;
@property (weak, nonatomic) IBOutlet UIButton *drugstore;
@property (nonatomic, strong) EFAnimationViewController *viewController;


@end

@implementation MedicineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewController = ({
        EFAnimationViewController *viewController = [[EFAnimationViewController alloc] init];
        [self.view addSubview:viewController.view];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        viewController;
        

        
    });
    
//    self.view.backgroundColor = [UIColor colorWithRed:64 / 255.0 green:147/255.0 blue:188 /255.0 alpha:1];
    [self.view bringSubviewToFront:_MedicineSearchBar];
    [self.view bringSubviewToFront:_drugstore];
    _MedicineSearchBar.delegate = self;
    _MedicineSearchBar.keyboardType = UIKeyboardTypeDefault;
    
    
    
}

 
#pragma mark - 点击搜索按钮 搜索结果
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
     NSString *typeString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)_MedicineSearchBar.text,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    
    NSString *urlString = [NSString stringWithFormat:@"name=drug&keyword=%@&page=1&rows=30&type=name",typeString];
    [[MedicineHelper sharedManager] request:httpUrl withHttpArg:urlString];
    MedicineSearchResultViewController *search = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"search"];
    [self showViewController:search sender:nil];
    [searchBar endEditing:YES];
    
}

- (IBAction)dragStore:(UIButton *)sender {
    
    ContantMedicineViewController *contantVC =  [ContantMedicineViewController new];
    
    [self showDetailViewController:contantVC sender:nil];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
