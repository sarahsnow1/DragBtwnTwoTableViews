    //
//  RootViewController.m
//  DragBtwnTwoTableViews
//
//  Created by Sarah Lensing on 5/4/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

- (void)viewDidLoad {
	
	[self.view setBackgroundColor: [UIColor scrollViewTexturedBackgroundColor]];
	
	twoTableViewController = [[TwoTableViewController alloc] init];
	[self.view addSubview: twoTableViewController.view];
//	[twoTableViewController release];
	
    [super viewDidLoad];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
