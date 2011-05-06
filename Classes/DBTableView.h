//
//  DBTableView.h
//  DragBtwnTwoTableViews
//
//  Created by Sarah Lensing on 5/5/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DBTableView : UITableView {
	
	id delegate;
	NSString *_title;
}

@property(nonatomic, retain) NSString *title;


- (id)initWithFrame:(CGRect)frame style: (UITableViewStyle )inStyle delegate: (id)inDelegate;

@end
