//
//  ASCII_Converter_PlusAppDelegate.h
//  ASCII Converter Plus
//
//  Created by Luke Reichold on 6/6/11.
//  Copyright 2011 Luke Reichold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCII_Converter_PlusAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
