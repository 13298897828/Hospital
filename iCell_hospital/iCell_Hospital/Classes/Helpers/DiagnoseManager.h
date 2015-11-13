//
//  DiagnoseManager.h
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Result)();

@interface DiagnoseManager : NSObject

//外界使用的数组
@property(nonatomic,strong)NSArray *infoArr;

//定义一个回调函数
@property(nonatomic,copy)Result digResult;

//创建单例
+ (instancetype)sharedDiagnoseManager;

@end
