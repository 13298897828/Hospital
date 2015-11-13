//
//  Diagnose_SicknessCell.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "Diagnose_SicknessCell.h"

@implementation Diagnose_SicknessCell

- (void)setSickness:(Diagnose_Sickness *)sickness{
    
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/symptom/name";
    NSString *typeString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)_searchBar.text,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    NSString *httpArg = [NSString stringWithFormat:@"name=%@",typeString];
    [self request: httpUrl withHttpArg: httpArg];
    
    
    _nameLabel.text = _sickness.name;
    _descLabel.text = _sickness.desc;
    _causeLabel.text = _sickness.causetext;
    _detailLabel.text = _sickness.detailtext;
    _drugLabel.text = _sickness.drug;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:kSicknessImgUrl,_sickness.img]]];
    
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
                [_sickness setValuesForKeysWithDictionary:dic];
            }
        }];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
