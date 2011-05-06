//
//  DraggableTableViewCell.h
//  DragBtwnTwoTableViews
//
//  Created by Sarah Lensing on 5/5/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DraggableTableViewCell : UITableViewCell {

	id delegate;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate: (id)inDelegate;

@end
