//
//  UIViewController+FirstViewController.m
//  TestApp
//
//  Created by Pinkal on 30/10/14.
//  Copyright (c) 2014 Pinkal. All rights reserved.
//

#import "FirstViewController.h"

static const NSInteger freeSpace = 2;

@implementation FirstViewController

@synthesize mainView, boxPerRow, boxSize, gridTable, random, score, index, boxArray,boxColor;

-(void)viewDidLoad
{
	[super viewDidLoad];
	self.index = 0;
	
	/*self.boxArray = [NSMutableArray array];
	for (int i = 0; i < 30; i++)
		[self.boxArray addObject: [NSString stringWithFormat:@"%d",(arc4random()%7) + 3]];
	[self.boxArray	sortUsingSelector:@selector(compare:)];*/
	self.boxArray = [NSMutableArray arrayWithObjects:@"2",@"3",@"4",@"5",@"5",@"6",@"6",@"7",@"7",@"7",@"8",@"8",@"8",@"8",@"8",@"8", nil];
	//NSLog(@"random array: %@",self.boxArray);

	//NSLog(@"random: %d",self.random);
	
}

-(void)viewDidAppear:(BOOL)animated
{
	self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil];
	NSLog(@"view: === %f == %f",self.view.frame.size.width, self.view.frame.size.height);
	CGRect frame = self.mainView.frame;
	frame.size.height = frame.size.width;
	self.mainView.frame = frame;
	NSLog(@"container: === %f == %f",self.mainView.frame.size.width, self.mainView.frame.size.height);

	self.boxPerRow = [[self.boxArray objectAtIndex:self.index] integerValue];
	self.score = 0;
	self.random = arc4random() % (self.boxPerRow * self.boxPerRow);
	
	self.boxColor = [self getRandomColor];
	self.boxSize = self.gridTable.frame.size.width / self.boxPerRow;
	NSLog(@"tableview: %.2f = %.2f",gridTable.frame.size.height,gridTable.frame.size.width);
	NSLog(@"view: %.2f = %.2f",self.mainView.frame.size.height,self.mainView.frame.size.width);
	//NSLog(@"box row: %d box size: %d",self.boxPerRow,self.boxSize);
	[self.gridTable reloadData];
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];

	[super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	//[self fillMainView:2];
}

-(void)fillMainView:(NSInteger)col
{
	[self.mainView subviews];
	NSInteger width = (self.mainView.frame.size.width / self.boxPerRow) - freeSpace;
	NSInteger total = self.mainView.frame.size.width - (width * self.boxPerRow);
	NSInteger start = round(total / (self.boxPerRow+1));
	NSLog(@"width: %ld total: %ld x: %ld",(long)width,(long)total,(long)start);
	for (int i=0; i < self.boxPerRow; i++) {
		NSInteger y = start + i;
		for (int j=0; j<self.boxPerRow; j++) {
			NSInteger x = (width * j) + y;
			NSLog(@"x: %ld y: %ld",(long)x,(long)y);
			UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, width)];
			[btn setBackgroundColor:[UIColor purpleColor]];
			[self.mainView addSubview:btn];
		}
		
	}
}

#pragma mark -
#pragma mark tableview dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.boxPerRow;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
		cell.backgroundColor = [UIColor clearColor];
	}

	[cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;

	int j = (int)indexPath.row * (int)self.boxPerRow;
	for (int i=0; i<self.boxPerRow; i++) {
		
		UIButton *btn = [[UIButton alloc] init];
		[btn setBackgroundColor:self.boxColor];
		btn.tag = j;
		if (j == self.random) {
			[btn setAlpha:0.8];
			[btn addTarget:self action:@selector(alphaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		}
		btn.bounds = CGRectMake(0, 0, self.boxSize-freeSpace, self.boxSize-freeSpace);
		btn.center = CGPointMake((1 + i)  + self.boxSize *( 0.5 + i) ,self.boxSize * 0.5);
		CGRect frame = btn.frame;
		frame.origin.x -= freeSpace;
		btn.frame = frame;
		[cell.contentView addSubview:btn];
		j++;
	}
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return self.boxSize ;
}

#pragma mark -
#pragma mark tableview delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)shouldAutorotate
{
	return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return ((toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight));
}

-(void)alphaButtonClick:(id)sender
{
	// UIButton *btn = (UIButton*)sender;
	//NSLog(@"btn: %@",btn);
	self.score += 1;
	self.index += 1;
	if (self.index >= [self.boxArray count]) {
		self.boxPerRow = 9;
	}
	else
		self.boxPerRow = [[self.boxArray objectAtIndex:self.index] integerValue];
	//self.boxPerRow += 1;
	self.random = arc4random() % (self.boxPerRow * self.boxPerRow);
	self.boxSize = self.gridTable.frame.size.width / self.boxPerRow;
	self.boxColor = [self getRandomColor];
	//NSLog(@"box row: %d box size: %d",self.boxPerRow,self.boxSize);
	[self.gridTable reloadData];
}

-(void)updateTimer
{
	static NSInteger counter = 30;
	if (counter == 0) {
		NSLog(@"score: %ld",(long)self.score);
		[self.timer invalidate];
		self.timer = nil;
		//[gridTable setUserInteractionEnabled:NO];
	}
	lblTime.text = [NSString stringWithFormat:@"%ld",(long)counter--];
}

-(UIColor*)getRandomColor
{
	CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
	CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
	CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
	UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
	return color;
}
@end
