//
//  SecondViewController.h
//  ASCII Converter Plus
//
//  Created by Luke Reichold on 6/6/11.
//  Copyright 2011 Luke Reichold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface HashGen : UIViewController <UITextFieldDelegate, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate> {
    
    IBOutlet UITextField *textToBeHashedView;
    IBOutlet UITextView *md5View;
    IBOutlet UITextView *sha1View;
    Info *infoViewController;
}

@property (nonatomic, retain) IBOutlet UITextField *textToBeHashedView;
@property (nonatomic, retain) IBOutlet UITextView *md5View;
@property (nonatomic, retain) IBOutlet UITextView *sha1View;
@property (nonatomic, retain) Info *infoViewController;


//Actions
-(IBAction)loadInfoView:(id)sender;
-(IBAction)clearFields;
-(IBAction)hashButtonClicked;
-(IBAction)backgroundTapped;
-(IBAction)emailThis:(id)sender;

//Processing
- (NSString *) returnMD5Hash:(NSString*)concat;
-(NSString*) returnSHA1:(NSString*)input;

@end
