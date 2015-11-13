//
//  HospitalDetailViewController.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "HospitalDetailViewController.h"

@interface HospitalDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_message;
}
@property (strong, nonatomic) IBOutlet UIImageView *hosImageView;
@property (strong, nonatomic) IBOutlet UILabel *hosNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *hosLevelLabel;
@property (strong, nonatomic) IBOutlet UILabel *hosMtype;
@property (strong, nonatomic) IBOutlet UILabel *hosAddressLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)UILabel *messageLabel;

@end

@implementation HospitalDetailViewController
static NSString *const cellID = @"CellID";

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
    
[self.segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.hosAddressLabel.text = self.hospital.address;
    NSString *imgURl = [@"http://tnfs.tngou.net/img" stringByAppendingString:_hospital.img];
    [self.hosImageView sd_setImageWithURL:[NSURL URLWithString:imgURl]];
    self.hosNameLabel.text = self.hospital.name;
    self.hosLevelLabel.text = self.hospital.level;
    self.hosMtype.text = self.hospital.mtype;
    self.messageLabel.text = @"";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self requestData];
    });
    
}

#pragma mark tableView 协议
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    self.messageLabel.text = _message;
    self.messageLabel.numberOfLines = 0;
 CGFloat height = [self calcHeightWithlabel:self.messageLabel];
    self.messageLabel.frame = CGRectMake(8, 0, self.view.bounds.size.width-16, height);
    [cell.contentView addSubview:self.messageLabel];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//计算cell高度
- (CGFloat)calcHeightWithlabel:(UILabel *)label{
    
    CGSize maxSize=CGSizeMake(label.frame.size.width, 1000);
    
    NSDictionary *dict=@{
                         NSFontAttributeName:label.font
                         };
    
    CGRect frame=[_message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    return frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.messageLabel.frame.size.height;
}

//在地图中显示医院位置
- (IBAction)showInMapAction:(UIButton *)sender {
    HospitalMapViewController *hosMapVC=[HospitalMapViewController new];
    hosMapVC.hospital = self.hospital;
    [self.navigationController pushViewController:hosMapVC animated:YES];
   
}


//请求医院简介数据
- (void)requestData{
    
     NSString *httArg = [NSString stringWithFormat:@"id=%@",self.hospital._id];

    [[HospitalHelper sharedHospitalHelper] requestHttpUrl:kDetailMessageUrl withHttpArg:httArg success:^(id data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _message = dic[@"message"];
        
       _message = [_message stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        
        if ([_message rangeOfString:@"<strong>"].location !=NSNotFound ) {
        NSRange range1 = [_message rangeOfString:@"<strong>"];
        NSInteger location = range1.location;
        NSRange range2 = [_message rangeOfString:@"</strong>"];
        NSInteger location2 = range2.location;
        NSInteger length = location2 -location;
        NSRange range = NSMakeRange(location, length);
        _message = [_message stringByReplacingCharactersInRange:range withString:@""];
        }
       
        _message = [self filterHTML:_message];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        });
    }];
}

//去除html标签
- (NSString *)filterHTML:(NSString *)html{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"   "];
    }
    return html;
    
}

//切换所看内容
- (void)segmentControlAction:(UISegmentedControl *)sender{
    
}



@end
