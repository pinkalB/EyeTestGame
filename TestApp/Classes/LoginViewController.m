//
//  ViewController.m
//  TestApp
//
//  Created by Pinkal on 15/10/14.
//  Copyright (c) 2014 Pinkal. All rights reserved.
//

#import "LoginViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	CGFloat power = powf(1.01, 240);
	CGFloat emi = roundf(2000000 * 0.01 * power / (power - 1));
	NSLog(@"power: %.2f",power);
	NSLog(@"emi: %.2f",emi);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark textfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
    return YES;
}


#pragma mark -
#pragma mark Button Methods

- (IBAction)onLoginButtonClick:(id)sender {
    NSLog(@"email: %@",self.txtEmail.text);
    NSLog(@"password: %@",[self md5:self.txtPassword.text]);
	if (![self.txtEmail.text isEqualToString:@""] && ![self.txtPassword.text isEqualToString:@""]) {
		/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yepp" message:@"Logged in" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		[alert show];*/
		
		FirstViewController *firstView = [[FirstViewController alloc] initWithNibName:@"FirstView" bundle:nil];

		//UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:firstView];
		//firstView.title = @"First View";
		[self presentViewController:firstView animated:YES completion:nil];
		
		/*SecondViewController *secondView = [[SecondViewController alloc] init];
		[self presentViewController:secondView animated:YES completion:nil];*/
	}
}

- (IBAction)onCancelButtonClick:(id)sender {
    self.txtEmail.text = @"";
    self.txtPassword.text = @"";
}

- (IBAction)onSignupButtonClick:(id)sender {

}


- (NSString *) md5:(NSString *) input
{
 const char *cStr = [input UTF8String];
 unsigned char digest[16];
 CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
	
 NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	
 for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
	 [output appendFormat:@"%02x", digest[i]];
	
 return  output;
	
}

-(NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return ((toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)) || (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
