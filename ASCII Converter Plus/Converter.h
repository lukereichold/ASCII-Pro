//
//  FirstViewController.h
//  ASCII Converter Plus
//
//  Created by Luke Reichold on 6/6/11.
//  Copyright 2011 Luke Reichold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface Converter : UIViewController <UITextViewDelegate, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate> {
    
    IBOutlet UITextView *entryTextView;
    IBOutlet UITextView *binaryView;
    IBOutlet UITextView *hexView;
    IBOutlet UITextView *base64View;
    IBOutlet UITextView *decCharView;
    CGFloat animatedDistance;
}

@property (nonatomic, retain) IBOutlet UITextView *entryTextView;
@property (nonatomic, retain) IBOutlet UITextView *binaryView;
@property (nonatomic, retain) IBOutlet UITextView *hexView;
@property (nonatomic, retain) IBOutlet UITextView *base64View;
@property (nonatomic, retain) IBOutlet UITextView *decCharView;

//Action Methods
-(IBAction)entryEncodeButtonClicked;
-(IBAction)binaryDecodeButtonClicked;
-(IBAction)hexDecodeButtonClicked;
-(IBAction)base64DecodeButtonClicked;
-(IBAction)decCharViewButtonClicked;
-(IBAction)clearFields;
-(IBAction)emailThis:(id)sender;

//For hexadecimal conversions
- (NSString *) stringFromHex:(NSString *)input;
- (NSString *) stringToHex:(NSString *)str;

//For base64 conversions
- (NSString *)encodeBase64WithData:(NSData *)objData;
- (NSString *)encodeBase64WithString:(NSString *)strData;
- (NSData *)decodeBase64WithString:(NSString *)strBase64;

//For binary conversions
- (NSString *)bits:(NSInteger)value forSize:(int)size;
- (NSString *)bitsForInteger:(NSInteger)value;
- (NSString *)bitsForString:(NSString *)value;
- (NSString *)BinaryToAsciiString: (NSString *)string;

//For ASCII decimal conversions
-(NSString*)textToDecChar:(NSString *) input;    
-(NSString *)decChartoText:(NSString *)input;


@end
