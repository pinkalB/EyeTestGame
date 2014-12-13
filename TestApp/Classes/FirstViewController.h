//
//  UIViewController+FirstViewController.h
//  TestApp
//
//  Created by Pinkal on 30/10/14.
//  Copyright (c) 2014 Pinkal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController: UIViewController <UITableViewDataSource, UITableViewDelegate>
{
	IBOutlet UIView *mainView;
	IBOutlet UITableView *gridTable;
	NSInteger boxPerRow, boxSize, random, score, index;
	IBOutlet UILabel *lblTime;
	NSMutableArray *boxArray;
	UIColor *boxColor;
}

@property(nonatomic) NSInteger boxPerRow, boxSize, random, score, index;
@property(nonatomic,retain) UIView *mainView;
@property(nonatomic,retain) UITableView *gridTable;
@property(nonatomic,retain) NSTimer *timer;
@property(nonatomic,retain) NSMutableArray *boxArray;
@property(nonatomic,retain) UIColor *boxColor;

-(void)alphaButtonClick:(id)sender;
@end
