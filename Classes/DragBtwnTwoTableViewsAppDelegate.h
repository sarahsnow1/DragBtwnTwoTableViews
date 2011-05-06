//
//  DragBtwnTwoTableViewsAppDelegate.h
//  DragBtwnTwoTableViews
//
//  Created by Sarah Lensing on 5/4/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface DragBtwnTwoTableViewsAppDelegate : NSObject <UIApplicationDelegate> {
	RootViewController *rootViewController;
	UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

