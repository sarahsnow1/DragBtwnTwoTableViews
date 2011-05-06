    //
//  TwoTableViewController.m
//  DragBtwnTwoTableViews
//
//  Created by Sarah Lensing on 5/4/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "TwoTableViewController.h"


@implementation TwoTableViewController

@synthesize moveableView = _moveableView;
@synthesize arrayA;
@synthesize arrayB;

- (void)viewDidLoad {
	
	panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
	[panGesture setDelegate: self];
//	[self.view setBackgroundColor:[UIColor lightGrayColor]];
	[self.view addGestureRecognizer:panGesture];
	
	tableViewA = [[DBTableView alloc] initWithFrame:CGRectMake(100, 50, 200, 600) style:UITableViewStylePlain delegate: self];
	[tableViewA setBackgroundColor:[UIColor viewFlipsideBackgroundColor]];
	[tableViewA setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[tableViewA setRowHeight:50];
	[tableViewA setDataSource:self];
	[tableViewA setDelegate:self];
	[tableViewA setDelaysContentTouches:NO];
	[tableViewA setTag:1000];
	[tableViewA setTitle:@"A"];
	[self.view addSubview:tableViewA];
	[tableViewA release];
	
	tableViewB = [[DBTableView alloc] initWithFrame:CGRectMake(self.view.frame.size.height-100-200, 50, 200, 600) style:UITableViewStylePlain delegate: self];
	[tableViewB setBackgroundColor:[UIColor viewFlipsideBackgroundColor]];
	[tableViewB setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[tableViewB setRowHeight:50];
	[tableViewB setDataSource:self];
	[tableViewB setDelegate:self];
	[tableViewB setDelaysContentTouches:NO];
	[tableViewB setTag:2000];
	[tableViewB setTitle:@"B"];
	[self.view addSubview:tableViewB];
	[tableViewB release];
	
	_moveableView = [[DBView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
	[_moveableView setBackgroundColor: [UIColor greenColor]];
	[_moveableView setHidden: YES];
	[self.view addSubview:_moveableView];
	[_moveableView release];
	
	arrayA = [[NSMutableArray alloc] initWithObjects: @"array A - value 0", @"array A - value 1", @"array A - value 2", nil ];
	arrayB = [[NSMutableArray alloc] initWithObjects: @"array B - value 0", @"array B - value 1", @"array B - value 2", @"array B - value 3", @"array B - value 4", @"array B - value 5", nil ];
	
    [super viewDidLoad];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return (indexPath == pathToAdjustAlphaAndHeight) ? pathToAdjustHeight : 50;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (tableView == tableViewA) ? (arrayA.count) : (arrayB.count);
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellSelector = @"Cell";
	
	UITableViewCell *cell;
	
	cell = (DraggableTableViewCell *)[tableView dequeueReusableCellWithIdentifier: cellSelector];
	
	if (!cell) {
		cell = [[DraggableTableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:cellSelector delegate: self];
	}
	
	if (tableView == tableViewA) {
		[cell.textLabel setText: [arrayA objectAtIndex: indexPath.row]];
	}
	else { //tableViewB
		[cell.textLabel setText: [arrayB objectAtIndex: indexPath.row]];
	}

	
	return cell;
}
				
#pragma mark UIAnimation functions
- (void)animateBackToOrigin {
	
	pathToAdjustHeight = 50;
	[fromTableView reloadData];
	
	[UIView animateWithDuration: 0.5f 
					  animations:^{ 
						 [_moveableView setCenter:_originPoint];
					 }
					 completion:^(BOOL finished) {
						 [_moveableView setHidden: YES];
						 [[fromTableView cellForRowAtIndexPath:pathToAdjustAlphaAndHeight].contentView
						  setHidden: NO];
					 }
	 ];
}

- (void)animateToEndOfA {
	
	
	[UIView animateWithDuration: 0.5f 
					 animations:^{ 
						 [_moveableView setCenter: CGPointMake(tableViewA.frame.origin.x+tableViewA.frame.size.width/2, 50*(arrayA.count+1))];
					 }
					 completion:^(BOOL finished) {
						 [_moveableView setHidden: YES];
						 [[fromTableView cellForRowAtIndexPath:pathToAdjustAlphaAndHeight].contentView setHidden: NO];
						 pathToAdjustHeight = 50;
						 [arrayA addObject:[arrayB objectAtIndex:rowMoving]];
						 [arrayB removeObjectAtIndex: rowMoving];
						 [tableViewA reloadData];
						 [tableViewB reloadData];
					 }
	 ];
}

- (void)animateToEndOfB {
	
	[UIView animateWithDuration: 0.5f 
					 animations:^{ 
						 [_moveableView setCenter: CGPointMake(tableViewB.frame.origin.x+tableViewB.frame.size.width/2, 50*(arrayB.count+1))];
					 }
					 completion:^(BOOL finished) {
						 [_moveableView setHidden: YES];
						 [[fromTableView cellForRowAtIndexPath:pathToAdjustAlphaAndHeight].contentView setHidden: NO];
						 pathToAdjustHeight = 50;
						 [arrayB addObject:[arrayA objectAtIndex:rowMoving]];
						 [arrayA removeObjectAtIndex: rowMoving];
						 [tableViewB reloadData];
						 [tableViewA reloadData];
					 }
	 ];
}


#pragma mark UIGestureRecognizer delegate functions
- (void)panRecognized:(UIPanGestureRecognizer *)inRecognizer {

	if (inRecognizer.state == UIGestureRecognizerStateBegan) {
		_originPoint = [panGesture locationInView: self.view];
		[_moveableView setCenter: _originPoint];
		[_moveableView setHidden: NO];
		
		[[fromTableView cellForRowAtIndexPath:pathToAdjustAlphaAndHeight].contentView setHidden: YES];
		
		DLog(@"FIRST LOCATION %i",_originPoint.x);
	}
	else if(inRecognizer.state == UIGestureRecognizerStateChanged)
	{
		DLog(@"%@",[fromTableView title]);
		
		[_moveableView setCenter: [panGesture locationInView: self.view]];

		if (CGRectContainsPoint([tableViewA frame], [panGesture locationInView: self.view])) {
			DLog(@"inside A");
			
			if ([[fromTableView title] isEqualToString: @"A"]) {
				pathToAdjustHeight = 50;
			}
			else {
				pathToAdjustHeight = 0;
			}			
		}
		else if (CGRectContainsPoint([tableViewB frame], [panGesture locationInView: self.view])) {
			DLog(@"inside B");
			
			if ([[fromTableView title] isEqualToString: @"B"]) {
				pathToAdjustHeight = 50;
			}
			else {
				pathToAdjustHeight = 0;
			}

		}
		else {
			pathToAdjustHeight = 0;
		}
		[fromTableView reloadData];
		
	}
	else if (inRecognizer.state == UIGestureRecognizerStateEnded) {

		if (CGRectContainsPoint([tableViewB frame], [panGesture locationInView: self.view]) && [[fromTableView title] isEqualToString: @"A"]) { //moved from A to B
			DLog(@" MOVED A to B");
			[self animateToEndOfB];
		}
		else if (CGRectContainsPoint([tableViewA frame], [panGesture locationInView: self.view]) && [[fromTableView title] isEqualToString: @"B"]) { //moved from B to A
			DLog(@" MOVED B to A");
			[self animateToEndOfA];
		}
		else {
			[self animateBackToOrigin];
		}
	}
}



- (void)draggableTableViewCellSelected: (DraggableTableViewCell *)inCell {
	
	DLog(@"%@",[inCell.textLabel text]);
	pathToAdjustAlphaAndHeight = [fromTableView indexPathForRowAtPoint:[fromTableView convertPoint:inCell.center fromView:fromTableView]];
	rowMoving = pathToAdjustAlphaAndHeight.row;
	[_moveableView.titleLabel setText: [inCell.textLabel text]];
	
}

- (void)dbTableViewSelected: (DBTableView *)inTableView {

	fromTableView = inTableView;
}


-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	DLog(@"moved");
}


- (void)viewDidUnload {
    [super viewDidUnload];

}


- (void)dealloc {
    [super dealloc];
}


@end
