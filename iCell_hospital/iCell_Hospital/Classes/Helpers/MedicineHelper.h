//
//  MedicineHelper.h
//  iCell_Hospital
//
//  Created by 张天琦 on 15/11/9.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Result)();
@interface MedicineHelper : NSObject
@property (nonatomic,strong)NSArray *MedicineInfoArray;
@property (nonatomic,strong)Result result;
+(instancetype)sharedManager;
-(void)request:(NSString*)httpUrl withHttpArg: (NSString*)HttpArg;
@end
