//
//  DiagnoseManager.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "DiagnoseManager.h"

@interface DiagnoseManager ()

@property(nonatomic,strong)NSMutableArray *allDataArray;

@end

@implementation DiagnoseManager

+ (instancetype)sharedDiagnoseManager{
    static DiagnoseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DiagnoseManager new];
    });
    return manager;
}

//初始化方法中请求数据
- (instancetype)init{
    if (self = [super init]) {
        [self requstAllData];
    }
    return self;
}


//请求数据
- (void)requstAllData{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^
                {
        NSString *typeString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)@"健康",NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kDiagnoseUrl,typeString]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        //解析数据
        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse *  _Nullable response, NSError * _Nullable error) {

            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = dict[@"tngou"];
        
            for (NSDictionary *dic in arr) {
                Diagnose_Info *digInfo = [Diagnose_Info new];
                [digInfo setValuesForKeysWithDictionary:dic];
                [self.allDataArray addObject:digInfo];
            }
            
            //NSLog(@"%@",_allDataArray);
            //主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                self.digResult();
            });
        }];
    
        //执行
        [task resume];
    });
}


#pragma mark - 懒加载
- (NSMutableArray *)allDataArray{
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (NSArray *)infoArr{
    return [self.allDataArray copy];
}

@end


















