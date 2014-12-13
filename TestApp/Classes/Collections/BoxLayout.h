//
//  UICollectionViewLayout+BoxLayout.h
//  TestApp
//
//  Created by Pinkal on 02/11/14.
//  Copyright (c) 2014 Pinkal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoxLayout: UICollectionViewLayout
{
	
}

@property (nonatomic) UIEdgeInsets itemInset;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;
@end
