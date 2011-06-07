//
//  Info.m
//  ASCII Converter Plus
//
//  Created by Luke Reichold on 6/22/11.
//  Copyright 2011 Luke Reichold. All rights reserved.
//

#import "Info.h"


@implementation Info

@synthesize appInfo;
@synthesize navBar;


-(IBAction)sendFeedback:(id)sender
{
	// Don't make the feedback button clickable if user can't send email from device
	if ([MFMailComposeViewController canSendMail] == YES)
	{
		MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc]init];
		mailer.navigationBar.tintColor = [UIColor colorWithRed:(0/255.0) green:(90/255.0) blue:(187/255.0) alpha:1];
		mailer.mailComposeDelegate = self;
		        
		[mailer setSubject:@"Feedback"];
		[mailer setMessageBody:@"<p>I have some feedback on the ASCII Suite app:</p><br><br><p></p>" isHTML: YES];
		
		[mailer setToRecipients: [NSArray arrayWithObject:@"asciisuite@gmail.com"]];
		
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)backButtonPressed:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [appInfo release];
    [navBar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
   // [appInfo setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
