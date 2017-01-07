//
//  FollowAdverCell.h
//  yocheche
//
//  Created by carcool on 6/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowAdverCell : UITableViewCell<ImagePlayerViewDelegate>
@property(nonatomic,retain)NSMutableArray *m_aryAdvers;
@property (retain, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;
-(void)creatPageScrollview;
@end
