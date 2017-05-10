//
//  ViewController.m
//  CYCollectionViewHorizontalLayoutDemo
//
//  Created by Gocy on 2017/5/8.
//  Copyright © 2017年 Gocy. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "CYCollectionViewHorizontalLayout.h"

#define reuseId @"cy.collectioncell"

@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic ,strong) NSArray *data;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self genData];
//    [self.collectionView registerClass:CollectionViewCell.class forCellWithReuseIdentifier:reuseId];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:reuseId];
    
    self.collectionView.dataSource = self;
    
    CYCollectionViewHorizontalLayout *layout = [CYCollectionViewHorizontalLayout new];
    layout.itemSize = CGSizeMake(120, 60);
    layout.minimumItemSpacing = 6;
    layout.lineSpacing = 20;
    
    self.collectionView.collectionViewLayout = layout;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)genData{
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0 ; i < 30 ; ++i){
        [arr addObject:[NSString stringWithFormat:@"Item %i",i]];
    }
    self.data = [arr copy];
}

#pragma mark - CollectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return nil;
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    cell.textLabel.text = self.data[indexPath.item];
    
    return cell;
}

#pragma mark - Actions
- (IBAction)refresh:(id)sender {
    [self.collectionView.collectionViewLayout invalidateLayout];
}



@end
