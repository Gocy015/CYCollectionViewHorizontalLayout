//
//  CYCollectionViewHorizontalLayout.m
//  CYCollectionViewHorizontalLayoutDemo
//
//  Created by Gocy on 2017/5/8.
//  Copyright © 2017年 Gocy. All rights reserved.
//

#import "CYCollectionViewHorizontalLayout.h"
#import "NSArray+HigherOrderFunction.h"

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
    NSUInteger maxRow = floor(collectionSize.height / (_lineSpacing + _itemSize.height));

    if (itemsPerRow <= 0 || maxRow <= 0) {
        _layoutAttributes = nil;
        return;
    }
    
    CGFloat widthPerItem = collectionSize.width / (CGFloat)itemsPerRow;
    
    NSUInteger column = 0;
    
    NSUInteger row = 0;
    
    CGFloat maxX = 0;
    
    CGFloat pageOffset = 0;
    
    NSMutableArray <UICollectionViewLayoutAttributes *> *attrs = [NSMutableArray new];
    
    for (int i = 0; i < numOfItems; ++i) {
        CGRect itemRect = CGRectMake(pageOffset + (CGFloat)column * widthPerItem, (CGFloat)row * (_itemSize.height + _lineSpacing), _itemSize.width, _itemSize.height);
        
        if (CGRectGetMaxX(itemRect) > maxX) {
            maxX = CGRectGetMaxX(itemRect);
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.frame = itemRect;
        
        [attrs addObject:attr];
        
        row += (column+1) / itemsPerRow;
        column = (column + 1) % itemsPerRow;
        
        if (row >= maxRow) {
            row = 0;
            pageOffset = CGRectGetMaxX(attrs.lastObject.frame) + widthPerItem - _itemSize.width;
        }
    }
    
    CGFloat height = row * (_itemSize.height + _lineSpacing);
    height += _itemSize.height;
    _contentSize = CGSizeMake(maxX, collectionSize.height);
    
    _layoutAttributes = [attrs copy];
    
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _layoutAttributes ?
    [_layoutAttributes filter:^BOOL(UICollectionViewLayoutAttributes *value) {
        return CGRectIntersectsRect(value.frame, rect);
    }]
    : @[];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _layoutAttributes ?
    _layoutAttributes[indexPath.item]
    : [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    return !CGRectEqualToRect(oldBounds, newBounds);
}

- (CGSize)collectionViewContentSize{
    return _contentSize;
}

#pragma mark - Helpers

@end
