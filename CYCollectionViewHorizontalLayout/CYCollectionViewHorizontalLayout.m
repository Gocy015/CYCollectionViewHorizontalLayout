//
//  CYCollectionViewHorizontalLayout.m
//  CYCollectionViewHorizontalLayoutDemo
//
//  Created by Gocy on 2017/5/8.
//  Copyright © 2017年 Gocy. All rights reserved.
//

#import "CYCollectionViewHorizontalLayout.h"

@interface CYCollectionViewHorizontalLayout ()

@property (nonatomic ,assign) CGSize contentSize;
@property (nonatomic ,strong) NSArray <UICollectionViewLayoutAttributes *> *layoutAttributes;

@end

@implementation CYCollectionViewHorizontalLayout

-(instancetype)init{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

-(void)initialize{
    _itemSize = CGSizeMake(44, 44);
    _contentSize = CGSizeZero;
}

#pragma mark - layout

-(void)prepareLayout{
    [super prepareLayout];
    
    NSUInteger numOfItems = [self.collectionView numberOfItemsInSection:0];
    CGSize collectionSize = self.collectionView.bounds.size;
    
    NSUInteger itemsPerRow = floor(collectionSize.width / (_minimumItemSpacing +_itemSize.width));

    if (itemsPerRow <= 0) {
        self.layoutAttributes = nil;
        return;
    }
    
    CGFloat widthPerItem = collectionSize.width / (CGFloat)itemsPerRow;
    
    CGFloat height = 0;
    
    NSUInteger column = 0;
    
    NSUInteger row = 0;
    
    NSMutableArray <UICollectionViewLayoutAttributes *> *attrs = [NSMutableArray new];
    
    for (int i = 0; i < numOfItems; ++i) {
        CGRect itemRect = CGRectMake((CGFloat)column * widthPerItem, (CGFloat)row * (_itemSize.height + _lineSpacing), _itemSize.width, _itemSize.height);
        
        
    }
    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

#pragma mark - Helpers

@end
