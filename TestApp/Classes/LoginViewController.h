//
//  ViewController.h
//  TestApp
//
//  Created by Pinkal on 15/10/14.
//  Copyright (c) 2014 Pinkal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *txtEmail;
@property (retain, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)onLoginButtonClick:(id)sender;
- (IBAction)onCancelButtonClick:(id)sender;
- (IBAction)onSignupButtonClick:(id)sender;

@end

