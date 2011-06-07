//
//  SecondViewController.m
//  ASCII Converter Plus
//
//  Created by Luke Reichold on 6/6/11.
//  Copyright 2011 Luke Reichold. All rights reserved.
//

#import "HashGen.h"
#import <CommonCrypto/CommonDigest.h>
#import <QuartzCore/QuartzCore.h>
#import "Info.h"

@implementation HashGen

#define CC_MD5_DIGEST_LENGTH 16   /* digest length in bytes */

@synthesize md5View;
@synthesize textToBeHashedView;
@synthesize sha1View;
@synthesize infoViewController;

-(IBAction)emailThis:(id)sender
{
	// Don't make the feedback button clickable if user can't send email from device
	if ([MFMailComposeViewController canSendMail] == YES)
	{
		MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc]init];
		mailer.navigationBar.tintColor = [UIColor colorWithRed:(0/255.0) green:(90/255.0) blue:(187/255.0) alpha:1];
		mailer.mailComposeDelegate = self;
        
		[mailer setSubject:@"ASCII Hash!"];
        
        NSString *messageBodyString = @"";
        messageBodyString = @"Here are ASCII hashes I generated using ASCII Pro! <br><br> ASCII Text: ";
        messageBodyString = [messageBodyString stringByAppendingString:textToBeHashedView.text];
        messageBodyString = [messageBodyString stringByAppendingString:@" <br>MD5 Text: "];
        messageBodyString = [messageBodyString stringByAppendingString:md5View.text];
        messageBodyString = [messageBodyString stringByAppendingString:@" <br>SHA-1 Text: "];
        messageBodyString = [messageBodyString stringByAppendingString:sha1View.text];

        
        [mailer setMessageBody:messageBodyString isHTML: YES];
		
		//[mailer setToRecipients: [NSArray arrayWithObject:@""]];
		
		if (mailer !=nil)	{
			[self presentModalViewController:mailer animated:YES];
		}
		[mailer release];
	}
	else {
		UIAlertView *cannotSendMail = [[UIAlertView alloc]initWithTitle:@"Send Feedback" message:@"You need to have a Mail account set up to use this feature." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[cannotSendMail show];
		[cannotSendMail release];
	}
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	if (result == MFMailComposeResultSent)	{
		NSLog(@"Message sent!");
	}
	[self dismissModalViewControllerAnimated:YES];
}

-(void)viewDidLoad  {
    
    textToBeHashedView.delegate = self;
    
    md5View.layer.cornerRadius = 8.0f;
    [md5View.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [md5View.layer setBorderWidth:0.3];
    [md5View.layer setMasksToBounds:YES];
    md5View.clipsToBounds = YES;
    
    sha1View.layer.cornerRadius = 8.0f;
    [sha1View.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [sha1View.layer setBorderWidth:0.3];
    [sha1View.layer setMasksToBounds:YES];
    sha1View.clipsToBounds = YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self backgroundTapped];
    [self hashButtonClicked];
    [textToBeHashedView resignFirstResponder];

    return YES;
}

-(IBAction)loadInfoView:(id)sender  {
    
    Info *infoVC = [[Info alloc]initWithNibName:@"Info" bundle:nil];
    infoVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:infoVC animated:YES];
    [infoVC release];
}

-(IBAction)backgroundTapped  {
    [textToBeHashedView resignFirstResponder];
    [sha1View resignFirstResponder];
    [md5View resignFirstResponder];
}

-(IBAction)hashButtonClicked   {

    if ([textToBeHashedView.text length] != 0) {
        md5View.text = [self returnMD5Hash: textToBeHashedView.text];
        sha1View.text = [self returnSHA1: textToBeHashedView.text];
    }
    
}

-(NSString*) returnSHA1:(NSString*)input  
{  
    
    NSData *data = [input dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];  
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];  
    CC_SHA1(data.bytes, data.length, digest);  
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];  
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)  
        [output appendFormat:@"%02x", digest[i]];  
    
    return output;  
}  


- (NSString *) returnMD5Hash:(NSString*)concat {
    const char *concat_str = [concat UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
    
}

-(IBAction)clearFields  {
    
    md5View.text = @"";
    sha1View.text = @"";   
    textToBeHashedView.text = @"";
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [md5View release];
    [sha1View release];
    [textToBeHashedView release];
    [super dealloc];
}

@end
