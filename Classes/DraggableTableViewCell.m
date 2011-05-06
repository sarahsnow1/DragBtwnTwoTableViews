//
//  DraggableTableViewCell.m
//  DragBtwnTwoTableViews
//
//  Created by Sarah Lensing on 5/5/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "DraggableTableViewCell.h"


@implementation DraggableTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate: (id)inDelegate{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        delegate = inDelegate;
		
		[self.textLabel setTextAlignment:UITextAlignmentCenter];
		[self.textLabel setFont:[UIFont boldSystemFontOfSize:20]];
		[self.textLabel setBackgroundColor: [UIColor clearColor]];
		[self.contentView setBackgroundColor:[UIColor greenColor]];
    }
    return self;
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if ([delegate respondsToSelector: @selector(draggableTableViewCellSelected:)]) {
		[delegate draggableTableViewCellSelected: self];
	}
 
	[super touchesBegan:touches withEvent:event];
}


- (void)dealloc {
    [super dealloc];
}


@end
