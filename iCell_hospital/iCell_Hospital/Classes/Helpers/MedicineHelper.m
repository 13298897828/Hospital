//
//  MedicineHelper.m
//  iCell_Hospital
//
//  Created by 张天琦 on 15/11/9.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "MedicineHelper.h"

@interface MedicineHelper ()

@property (nonatomic,strong)NSMutableArray *MedicineArray;

@end
@implementation MedicineHelper



+(instancetype)sharedManager{
    
    static MedicineHelper *medicineHelper;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        medicineHelper = [MedicineHelper new];
        
    });
    
    return medicineHelper;
}

-(instancetype)init{
    
    if (self = [super init]) {
        //    [self request: httpUrl withHttpArg: httpArg];
    }
    
    return self;
}

-(void)request:(NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    
    
    //子线程解析数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
        NSURL *url = [NSURL URLWithString: urlStr];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
        [request setHTTPMethod: @"GET"];
        [request addValue: @"c3755e88decce5a63cfe9aae49cf7e0b" forHTTPHeaderField: @"apikey"];
        [NSURLConnection sendAsynchronousRequest: request
                                           queue: [NSOperationQueue mainQueue]
                               completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                                   if (error) {
                                       NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                   } else {
                                       
                                       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                                       
                                       for (NSDictionary *dic in dict[@"tngou"]) {
                                           
                                           Medicine *medicine = [Medicine new];
                                           [medicine setValuesForKeysWithDictionary:dic];
                                           //              分离 成行
                                           NSMutableArray *array = [medicine.message componentsSeparatedByString:@"【"];
                                           [array removeObjectAtIndex:0];
                                    
                                           for (NSString *itemStr in array) {
                                               NSString* itemStr1 = [@"【" stringByAppendingString:itemStr];
                                               
                                               [medicine.messageArray addObject:itemStr1];
                                               
//                                               NSLog(@"%@",medicine.messageArray[0]);
                                               
                                           }
                                           [_MedicineArray addObject:medicine];
                                           
                                       }
                                       
                                   }
                                   
                                   //       主线程刷新
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       
                                       
                                       self.result();
                                       
                                   });
                               }];
        
        
        
    });
    
}

-(NSMutableArray *)MedicineArray{
    
    if (!_MedicineArray) {
        
        self.MedicineArray = [NSMutableArray new];
        
    }
    
    return _MedicineArray;
    
}

-(NSArray *)MedicineInfoArray{
    
    return [self.MedicineArray copy];
    
}

@end
