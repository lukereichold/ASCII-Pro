//
//  Info.h
//  ASCII Converter Plus
//
//  Created by Luke Reichold on 6/22/11.
//  Copyright 2011 Luke Reichold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface Info : UIViewController <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate> {
    
    IBOutlet UITextView *appInfo;
    IBOutlet UINavigationBar *navBar;
}

@property (nonatomic, retain) IBOutlet UITextView *appInfo;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;


-(IBAction)backButtonPressed:(id)sender;
-(IBAction)sendFeedback:(id)sender;


@end
