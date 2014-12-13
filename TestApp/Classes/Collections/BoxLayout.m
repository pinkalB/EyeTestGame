//
//  UICollectionViewLayout+BoxLayout.m
//  TestApp
//
//  Created by Pinkal on 02/11/14.
//  Copyright (c) 2014 Pinkal. All rights reserved.
//

#import "BoxLayout.h"

static const NSString *cellIdentifier = @"BoxCell";

@interface BoxLayout()

@property (nonatomic,strong) NSDictionary *layoutInfo;
@end

@implementation BoxLayout

-(id)init
{
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

-(void)setup
{
	self.itemInset = UIEdgeInsetsMake(22, 22, 13, 22);
	self.itemSize = CGSizeMake(90, 90);
	self.interItemSpacingY = 12;
	self.numberOfColumns = 3;
}

-(void)prepareLayout
{
	NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
	NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
	
	NSInteger sectionCount = [self.collectionView numberOfSections];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	
	for (NSInteger section=0; section < sectionCount; section++) {
		NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
		
		for (NSInteger item=0; item < itemCount; item++) {
			indexPath = [NSIndexPath indexPathForRow:item inSection:section];
			
			UICollectionViewLayoutAttributes *itemAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
			itemAttribute.frame = [self frameForBoxAtIndexPath:indexPath];
			
			cellLayoutInfo[indexPath] = itemAttribute;
		}
	}
	newLayoutInfo[cellIdentifier] = cellLayoutInfo;
	self.layoutInfo = newLayoutInfo;
}

-(CGRect)frameForBoxAtIndexPath:(NSIndexPath*)indexPath
{
	NSInteger row = indexPath.section / self.numberOfColumns;
	NSInteger column = indexPath.section % self.numberOfColumns;
	
	CGFloat spacingX = self.collectionView.bounds.size.width - self.itemInset.left - self.itemInset.right - (self.numberOfColumns * self.itemSize.width);
	
	if (self.numberOfColumns > 1) {
		spacingX = spacingX / (self.numberOfColumns - 1);
	}
	
	CGFloat originX = floorf(self.itemInset.left + (self.itemSize.width  + spacingX) *column);
	
	CGFloat originY = floorf(self.itemInset.top + (self.itemSize.height + self.interItemSpacingY) * row);
	
	return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
	NSMutableArray *allAttribute = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
	[self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier, NSDictionary *elementsInfo, BOOL *stop) {
		[elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *innerStop) {
			if (CGRectIntersectsRect(rect, attribute.frame)) {
				[allAttribute addObject:attribute];
			}
		}];
	}];
	return allAttribute;
}

@end