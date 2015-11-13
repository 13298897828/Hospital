//
//  HospitalTableViewCell.m
//  iCell_Hospital
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "HospitalTableViewCell.h"

@interface HospitalTableViewCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray  *hosArray;

@end

@implementation HospitalTableViewCell

static NSString *const cellID = @"cellID";
static NSString *const kheaderIdentifier = @"kheaderIdentifierID";

- (void)awakeFromNib {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) collectionViewLayout:flowLayout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HospitalCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    //注册headerView Nib的view需要继承UICollectionReusableView
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    
    [self.contentView addSubview:self.collectionView];
    
    self.collectionView.scrollEnabled = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark collectionView协议方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.hosArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(([UIScreen mainScreen].bounds.size.width-20) * 0.5, 120);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier;
    reuseIdentifier = kheaderIdentifier;
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, view.frame.size.width, 30)];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        label.text = @"热门医院";
        [view addSubview:label];
    }
    return view;
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={320,40};
    return size;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
 
    HospitalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];  
    for (int i=0; i<self.hosArray.count; i++) {
        static int count =0 ;
        Hospital *hospital = [Hospital new];
        
        if (count == self.hosArray.count-1) {
            
            for (int i=0; i<self.hosArray.count-1; i++) {
                static int count2 =0;
                Hospital *hos = [Hospital new];
                hos = self.hosArray[count2++];
                if ([hos.level  rangeOfString:@"二级甲等"].location !=NSNotFound) {
                    cell.hospital = hos;
                    return cell;
                }
            }
    }
        
        hospital = self.hosArray[count++];
                 if ([hospital.level  rangeOfString:@"三级甲等"].location !=NSNotFound) {
                cell.hospital = hospital;
                return cell;
            }
    }
    
    return cell;
}

- (void)setDataArray:(NSArray *)dataArray{
    self.hosArray = [dataArray copy];
}

- (NSMutableArray *)hosArray{
    if (_hosArray == nil) {
        _hosArray = [NSMutableArray arrayWithCapacity:4];
    }
    return _hosArray;
}

@end
