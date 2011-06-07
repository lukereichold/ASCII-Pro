//
//  FirstViewController.m
//  ASCII Converter Plus
//
//  Created by Luke Reichold on 6/6/11.
//  Copyright 2011 Luke Reichold. All rights reserved.
//

#import "Converter.h"
#import "QSUtilities.h"
#import "GTMNSString+HTML.h"
#import <QuartzCore/QuartzCore.h>


@implementation Converter

@synthesize entryTextView;
@synthesize binaryView;
@synthesize hexView;
@synthesize base64View;
@synthesize decCharView;


static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
 
static const char _base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short _base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
    -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};


-(IBAction)emailThis:(id)sender
{
	// Don't make the feedback button clickable if user can't send email from device
	if ([MFMailComposeViewController canSendMail] == YES)
	{
		MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc]init];
		mailer.navigationBar.tintColor = [UIColor colorWithRed:(0/255.0) green:(90/255.0) blue:(187/255.0) alpha:1];
		mailer.mailComposeDelegate = self;
        
        NSString *messageBodyString = @"";
        messageBodyString = @"Here are ASCII values I generated using ASCII Pro! <br><br> ASCII Text: ";
        messageBodyString = [messageBodyString stringByAppendingString:entryTextView.text];
        messageBodyString = [messageBodyString stringByAppendingString:@" <br>Binary Text: "];
        messageBodyString = [messageBodyString stringByAppendingString:binaryView.text];
        messageBodyString = [messageBodyString stringByAppendingString:@" <br>Hex Text: "];
        messageBodyString = [messageBodyString stringByAppendingString:hexView.text];
        messageBodyString = [messageBodyString stringByAppendingString:@" <br>Base 64 Text: "];
        messageBodyString = [messageBodyString stringByAppendingString:base64View.text];
        messageBodyString = [messageBodyString stringByAppendingString:@" <br>Decimal Code: "];
        messageBodyString = [messageBodyString stringByAppendingString:decCharView.text];

        
		[mailer setSubject:@"ASCII Code!"];
		[mailer setMessageBody:messageBodyString isHTML: YES];
		
		//[mailer setToRecipients: [NSArray arrayWithObject:@""]];
		
		if (mailer !=nil)	{
			[self presentModalViewController:mailer animated:YES];
		}
		[mailer release];
        //[messageBodyString release];
	}
	else {
		UIAlertView *cannotSendMail = [[UIAlertView alloc]initWithTitle:@"Email ASCII Code" message:@"You need to have a Mail account set up to use this feature." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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


-(IBAction)clearFields  {
    
    entryTextView.text = @"";
    hexView.text = @"";
    base64View.text = @"";
    decCharView.text = @"";;
    binaryView.text = @"";
}

- (void)viewDidLoad
{
    //Format Custom UITextViews
    
    entryTextView.layer.cornerRadius = 8.0f;
    [entryTextView.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [entryTextView.layer setBorderWidth:0.3];
    [entryTextView.layer setMasksToBounds:YES];
    entryTextView.clipsToBounds = YES;
    
    hexView.layer.cornerRadius = 8.0f;
    [hexView.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [hexView.layer setBorderWidth:0.3];
    [hexView.layer setMasksToBounds:YES];
    hexView.clipsToBounds = YES;
    
    base64View.layer.cornerRadius = 8.0f;
    [base64View.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [base64View.layer setBorderWidth:0.3];
    [base64View.layer setMasksToBounds:YES];
    base64View.clipsToBounds = YES;
    
    decCharView.layer.cornerRadius = 8.0f;
    [decCharView.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [decCharView.layer setBorderWidth:0.3];
    [decCharView.layer setMasksToBounds:YES];
    decCharView.clipsToBounds = YES;
    
    binaryView.layer.cornerRadius = 8.0f;
    [binaryView.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [binaryView.layer setBorderWidth:0.3];
    [binaryView.layer setMasksToBounds:YES];
    binaryView.clipsToBounds = YES;

    [super viewDidLoad];

}

-(IBAction)binaryDecodeButtonClicked    {

    if ([binaryView.text length] != 0)  {
        entryTextView.text = [self BinaryToAsciiString:binaryView.text];
        [self entryEncodeButtonClicked];
    }
}


- (NSString *)BinaryToAsciiString: (NSString *)string
{
    NSMutableString *result = [NSMutableString string];
    const char *b_str = [string cStringUsingEncoding:NSASCIIStringEncoding];
    char c;
    int i = 0; /* index, used for iterating on the string */
    int p = 7; /* power index, iterating over a byte, 2^p */
    int d = 0; /* the result character */
    while ((c = b_str[i])) { /* get a char */
        if (c == ' ') { /* if it's a space, save the char + reset indexes */
            [result appendFormat:@"%c", d];
            p = 7; d = 0;
        } else { /* else add its value to d and decrement
                  * p for the next iteration */
            if (c == '1') d += pow(2, p);
            --p;
        }
        ++i;
    } [result appendFormat:@"%c", d]; /* this saves the last byte */
    
    return [NSString stringWithString:result];
}

-(IBAction)hexDecodeButtonClicked    {
    if ([hexView.text length] != 0) {
        entryTextView.text = [self stringFromHex:hexView.text];

    }
    [self entryEncodeButtonClicked];
    
}

-(IBAction)base64DecodeButtonClicked {
    
    if ([base64View.text length] != 0) {
        
        NSString* decryptedStr = [[NSString alloc] initWithData:[self decodeBase64WithString:base64View.text] encoding:NSUTF8StringEncoding];
        
        entryTextView.text = decryptedStr;
        [self entryEncodeButtonClicked];
        [decryptedStr release];
    }
}

-(IBAction)decCharViewButtonClicked {
    if ([decCharView.text length] != 0) {
        entryTextView.text = [self decChartoText:decCharView.text];
    }
    [self entryEncodeButtonClicked];
}


- (NSString *)encodeBase64WithString:(NSString *)strData {
    return [QSStrings encodeBase64WithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    CGRect textViewRect =
    [self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];

    CGFloat midline = textViewRect.origin.y + 0.5 * textViewRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;

    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    //viewFrame.size.height += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    self.view.window.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1];

    [UIView commitAnimations];
     
}

-(void)textViewDidEndEditing:(UITextView *)textView {

    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    //viewFrame.size.height -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
 

- (NSString *)encodeBase64WithData:(NSData *)objData {
    const unsigned char * objRawData = [objData bytes];
    char * objPointer;
    char * strResult;
    
    // Get the Raw Data length and ensure we actually have data
    int intLength = [objData length];
    if (intLength == 0) return nil;
    
    // Setup the String-based Result placeholder and pointer within that placeholder
    strResult = (char *)calloc(((intLength + 2) / 3) * 4, sizeof(char));
    objPointer = strResult;
    
    // Iterate through everything
    while (intLength > 2) { // keep going until we have less than 24 bits
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
        *objPointer++ = _base64EncodingTable[((objRawData[1] & 0x0f) << 2) + (objRawData[2] >> 6)];
        *objPointer++ = _base64EncodingTable[objRawData[2] & 0x3f];
        
        // we just handled 3 octets (24 bits) of data
        objRawData += 3;
        intLength -= 3; 
    }
    
    // now deal with the tail end of things
    if (intLength != 0) {
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        if (intLength > 1) {
            *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
            *objPointer++ = _base64EncodingTable[(objRawData[1] & 0x0f) << 2];
            *objPointer++ = '=';
        } else {
            *objPointer++ = _base64EncodingTable[(objRawData[0] & 0x03) << 4];
            *objPointer++ = '=';
            *objPointer++ = '=';
        }
    }
    
    // Terminate the string-based result
    *objPointer = '\0';
    
    // Return the results as an NSString object
    return [NSString stringWithCString:strResult encoding:NSASCIIStringEncoding];
}

- (NSData *)decodeBase64WithString:(NSString *)strBase64 {
    const char * objPointer = [strBase64 cStringUsingEncoding:NSASCIIStringEncoding];
    int intLength = strlen(objPointer);
    int intCurrent;
    int i = 0, j = 0, k;
    
    unsigned char * objResult;
    objResult = calloc(intLength, sizeof(char));
    
    // Run through the whole string, converting as we go
    while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
        if (intCurrent == '=') {
            if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
                // the padding character is invalid at this point -- so this entire string is invalid
                free(objResult);
                return nil;
            }
            continue;
        }
        
        intCurrent = _base64DecodingTable[intCurrent];
        if (intCurrent == -1) {
            // we're at a whitespace -- simply skip over
            continue;
        } else if (intCurrent == -2) {
            // we're at an invalid character
            free(objResult);
            return nil;
        }
        
        switch (i % 4) {
            case 0:
                objResult[j] = intCurrent << 2;
                break;
                
            case 1:
                objResult[j++] |= intCurrent >> 4;
                objResult[j] = (intCurrent & 0x0f) << 4;
                break;
                
            case 2:
                objResult[j++] |= intCurrent >>2;
                objResult[j] = (intCurrent & 0x03) << 6;
                break;
                
            case 3:
                objResult[j++] |= intCurrent;
                break;
        }
        i++;
    }
    
    // mop things up if we ended on a boundary
    k = j;
    if (intCurrent == '=') {
        switch (i % 4) {
            case 1:
                // Invalid state
                free(objResult);
                return nil;
                
            case 2:
                k++;
                // flow through
            case 3:
                objResult[k] = 0;
        }
    }
    
    // Cleanup and setup the return NSData
    NSData * objData = [[[NSData alloc] initWithBytes:objResult length:j] autorelease];
    free(objResult);
    return objData;
}


-(NSString*)textToDecChar:(NSString *) input    {
    
    int decCharArray[[entryTextView.text length]];
    
    for (int i=0; i<[entryTextView.text length]; i++) {
        decCharArray[i] = [entryTextView.text characterAtIndex:i];
    }

     // Now I want to convert that int array 
    
    NSString *returnString = @"";
    
    for (int i = 0; i < (sizeof(decCharArray)/sizeof(decCharArray[0]) ); i++)   {
        returnString = [returnString stringByAppendingString:[NSString stringWithFormat:@"%d", decCharArray[i]]];
        returnString = [returnString stringByAppendingString:@" "];     //like 1 space between characters
    }
    
    return returnString;
}

-(NSString *)decChartoText:(NSString *)input    {
        
    NSArray *components = [input componentsSeparatedByString:@" "];
    NSUInteger len = [components count];
    char new_str[len+1];
    
    int i;
    for (i = 0; i < len; ++i)
        new_str[i] = [[components objectAtIndex:i] intValue];
    
    new_str[i] = '\0';
    
    return [NSString stringWithCString:new_str
                              encoding:NSASCIIStringEncoding];

}


- (NSString *) stringFromHex:(NSString *)input
{   
    NSMutableString * newString = [[[NSMutableString alloc] init] autorelease];
    
    NSArray * components = [input componentsSeparatedByString:@" "];
    for ( NSString * component in components ) {
        int value = 0;
        sscanf([component cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        [newString appendFormat:@"%c", (char)value];
    }
    
    return newString;
}


-(IBAction)entryEncodeButtonClicked   {
//    if ([entryTextView.text length] != 0)   {
        decCharView.text = [self textToDecChar: entryTextView.text];
        hexView.text = [self stringToHex:entryTextView.text];
        base64View.text = [self encodeBase64WithString: entryTextView.text];    
        binaryView.text = [self bitsForString:entryTextView.text];
//    }
}

- (NSString *) stringToHex:(NSString *)str
{   
    NSUInteger len = [str length];
    unichar *chars = malloc(len * sizeof(unichar));
    [str getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
        [hexString appendString:@" "];
    }
    free(chars);
    
    return [hexString autorelease];
}




- (NSString *)bits:(NSInteger)value forSize:(int)size {
    const int shift = 8*size - 1;
    const unsigned mask = 1 << shift;
    NSMutableString *result = [NSMutableString string];
    for (int i = 1; i <= shift + 1; i++ ) {
        [result appendString:(value & mask ? @"1" : @"0")];
        value <<= 1;
        if (i % 8 == 0) {
            [result appendString:@" "];
        }
    }
    return result;
}

- (NSString *)bitsForInteger:(NSInteger)value {
    return [self bits:value forSize:sizeof(NSInteger)];
}

- (NSString *)bitsForString:(NSString *)value {
    const char *cString = [value UTF8String];
    int length = strlen(cString);
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        [result appendString:[self bits:*cString++ forSize:sizeof(char)]];
    }
    return result;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(IBAction)backgroundTapped:(id)sender  {
    [entryTextView resignFirstResponder];
    [binaryView resignFirstResponder];
    [hexView resignFirstResponder];
    [base64View resignFirstResponder];
    [decCharView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        if ([textView isEqual: entryTextView])  {
            [self entryEncodeButtonClicked];
        }
        if ([textView isEqual: binaryView])  {
            [self binaryDecodeButtonClicked];
        }
        if ([textView isEqual: hexView])  {
            [self hexDecodeButtonClicked];
        }
        if ([textView isEqual: base64View])  {
            [self base64DecodeButtonClicked];
        }
        if ([textView isEqual: decCharView])  {
            [self decCharViewButtonClicked];
        }
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [entryTextView release];
    [binaryView release];
    [hexView release];
    [base64View release];
    [decCharView release];
    [super dealloc];
}

@end

