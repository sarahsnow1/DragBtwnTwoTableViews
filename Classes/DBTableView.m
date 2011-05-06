//
//  DBTableView.m
//  DragBtwnTwoTableViews
//
//  Created by Sarah Lensing on 5/5/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "DBTableView.h"

@implementation DBTableView

@synthesize title = _title;

- (id)initWithFrame:(CGRect)frame style: (UITableViewStyle )inStyle delegate: (id)inDelegate{
    
    self = [super initWithFrame:frame style: inStyle];
    if (self) {
        delegate = inDelegate;
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if ([delegate respondsToSelector: @selector(dbTableViewSelected:)]) {
		[delegate dbTableViewSelected: self];
	}
	
	[super touchesBegan:touches withEvent:event];
}


- (void)dealloc {
    [super dealloc];
}


@end
