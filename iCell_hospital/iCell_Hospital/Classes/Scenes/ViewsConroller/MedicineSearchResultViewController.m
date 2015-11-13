//
//  MedicineSearchResultViewController.m
//  iCell_Hospital
//
//  Created by 张天琦 on 15/11/11.
//  Copyright © 2015年 张天琦. All rights reserved.
//

#import "MedicineSearchResultViewController.h"
#import "MedicineCollectionViewCell.h"
@interface MedicineSearchResultViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *searchMedicineCollectionView;
@property (weak, nonatomic) IBOutlet UIView *lunboView;

@end

@implementation MedicineSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [MedicineHelper sharedManager].result = ^{
        
        [self.searchMedicineCollectionView reloadData];
        
    };
    
     [self.searchMedicineCollectionView registerNib:[UINib nibWithNibName:@"MedicineCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MedicineSearchCollectionCell"];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4.jpeg"]];
    imageV.frame = _searchMedicineCollectionView.frame;
    _searchMedicineCollectionView.backgroundView = imageV;
    _searchMedicineCollectionView.delegate = self;
    _searchMedicineCollectionView.dataSource = self;
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
     return [MedicineHelper sharedManager].MedicineInfoArray.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MedicineCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"MedicineSearchCollectionCell" forIndexPath:indexPath];
    for(UIView * view in cell.subviews){
        
        if([view isKindOfClass:[UIImageView class]])
            
        {
            
            [view removeFromSuperview];
            
        }
        
    }
    Medicine *medicine = [MedicineHelper sharedManager].MedicineInfoArray[indexPath.row];
    //        UIImageView *imgView = [[UIImageView alloc] initWithFrame:cell.frame];
    
    
    
        [cell.medicineImg sd_setImageWithURL:[NSURL URLWithString:medicine.img]];
        cell.medicineName.text = medicine.name;
        cell.medicineName.textColor = [UIColor whiteColor];
        cell.medicineName.font = [UIFont systemFontOfSize:14];
    
        [cell.medicineImg sd_setImageWithURL:[NSURL URLWithString:medicine.img]];
        cell.medicineName.text = medicine.name;
    
  
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Medicine *medicine = [MedicineHelper sharedManager].MedicineInfoArray[indexPath.row];
    
    MedicineDetailViewController *medicineDetail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"medicineDetailViewController"];
    
    medicineDetail.view.backgroundColor = [UIColor whiteColor];
    medicineDetail.medicine = medicine;

    [self showViewController:medicineDetail sender:nil];
    
}

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
