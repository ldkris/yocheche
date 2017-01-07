//
//  CommentCoachTagCell.h
//  yocheche
//
//  Created by carcool on 2/18/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCoachTagCell : UITableViewCell
@property(nonatomic,retain)UIView *contentBG;
@property(nonatomic,retain)NSArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryBtns;
-(void)updateView;
@end
