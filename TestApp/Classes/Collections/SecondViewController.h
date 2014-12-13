//
//  UIViewController+SecondViewController.h
//  TestApp
//
//  Created by Pinkal on 02/11/14.
//  Copyright (c) 2014 Pinkal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxLayout.h"

@interface SecondViewController: UICollectionViewController
{
	IBOutlet BoxLayout *boxLayout;
}

@property(nonatomic) BoxLayout *boxLayout;

@end
