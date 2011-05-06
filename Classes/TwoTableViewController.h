//
//  TwoTableViewController.h
//  DragBtwnTwoTableViews
//
//  Created by Sarah Lensing on 5/4/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBView.h"
#import "DBTableView.h"
#import "DraggableTableViewCell.h"

@interface TwoTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate> {

	UIPanGestureRecognizer *panGesture;
	DBTableView *fromTableView;
	CGPoint _originPoint;
	BOOL _validOriginPoint;
	
	int pathToAdjustHeight;
	NSIndexPath *pathToAdjustAlphaAndHeight;
	DBView *_moveableView;
	DBTableView *tableViewA;
	DBTableView *tableViewB;
	
	int rowMoving;
	NSMutableArray *arrayA;
	NSMutableArray *arrayB;
}

@property (nonatomic, retain) UIView *moveableView;
@property (nonatomic, retain) NSMutableArray *arrayA;
@property (nonatomic, retain) NSMutableArray *arrayB;

@end
