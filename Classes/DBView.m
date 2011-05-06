//
//  DBView.m
//  DragBtwnTwoTableViews
//
//  Created by Sarah Lensing on 5/5/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "DBView.h"


@implementation DBView

@synthesize titleLabel = _titleLabel;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		_titleLabel = [[UILabel alloc] initWithFrame: frame];
		[_titleLabel setBackgroundColor: [UIColor clearColor]];
		[_titleLabel setTextAlignment:UITextAlignmentCenter];
		[_titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
		[self addSubview: _titleLabel];
		[_titleLabel release];
    }
    return self;
}



- (void)dealloc {
    [super dealloc];
}


@end
