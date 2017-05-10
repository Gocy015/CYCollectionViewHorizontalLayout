//
//  CYCollectionViewHorizontalLayout.h
//  CYCollectionViewHorizontalLayoutDemo
//
//  Created by Gocy on 2017/5/8.
//  Copyright © 2017年 Gocy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYCollectionViewHorizontalLayout : UICollectionViewLayout

@property (nonatomic ,assign) CGSize itemSize;
@property (nonatomic ,assign) CGFloat minimumItemSpacing;
@property (nonatomic ,assign) CGFloat lineSpacing;

@end
