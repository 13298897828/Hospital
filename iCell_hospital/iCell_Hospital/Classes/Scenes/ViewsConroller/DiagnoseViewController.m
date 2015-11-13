//
//  DiagnoseViewController.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "DiagnoseViewController.h"
#import "SDCycleScrollView.h"

@interface DiagnoseViewController ()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *cycleView;

- (IBAction)sicknessInfoAction:(UIButton *)sender;
- (IBAction)checkAction:(UIButton *)sender;
- (IBAction)operationAction:(UIButton *)sender;
- (IBAction)healthAction:(UIButton *)sender;


//轮播图的数组（标题和图片）
@property(nonatomic,strong)NSMutableArray *titles;
@property(nonatomic,strong)NSMutableArray *imgUrls;

//轮播图的View
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;

@end

@implementation DiagnoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数组
    self.titles = [NSMutableArray array];
    self.imgUrls = [NSMutableArray array];
    
    //实现block块
    [DiagnoseManager sharedDiagnoseManager].digResult = ^(){
        
        [self getAllTitleAndURLs];
        [self reloadViews];
    };
 
}

//获取所有的titles和imgs
- (void)getAllTitleAndURLs{
    NSArray *arr = [DiagnoseManager sharedDiagnoseManager].infoArr;
    for (Diagnose_Info *info in arr) {
        
        [self.titles addObject:info.title];
        [self.imgUrls addObject:info.img];
    }
}

//加载视图
- (void)reloadViews{
    
    CGFloat w = self.view.bounds.size.width;
    //网络加载 --- 创建带标题的图片轮播器
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 180) imageURLStringsGroup:nil]; // 模拟网络延时情景
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.delegate = self;
    _cycleScrollView.titlesGroup = _titles;
//    _cycleScrollView.dotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"doctor1.jpg"];
    [self.cycleView addSubview:_cycleScrollView];
    
    // --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _cycleScrollView.imageURLStringsGroup = _imgUrls;
    });

}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
    
    //传值并推出
    Diagnose_Info *info = [DiagnoseManager sharedDiagnoseManager].infoArr[index];
    DiagnoseInfoViewController *infoVC = [DiagnoseInfoViewController new];
    infoVC.info = info;
    
    [self.navigationController pushViewController:infoVC animated:YES];
}



















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sicknessInfoAction:(UIButton *)sender {
}

- (IBAction)checkAction:(UIButton *)sender {
}

- (IBAction)operationAction:(UIButton *)sender {
}

- (IBAction)healthAction:(UIButton *)sender {
}
@end
