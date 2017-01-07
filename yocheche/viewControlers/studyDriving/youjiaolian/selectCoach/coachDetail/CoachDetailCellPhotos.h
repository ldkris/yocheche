//
//  CoachDetailCellPhotos.h
//  yocheche
//
//  Created by carcool on 2/20/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachDetailVC.h"
@interface CoachDetailCellPhotos : UITableViewCell<ImagePlayerViewDelegate>
@property(nonatomic,assign)CoachDetailVC *delegate;
@property (retain, nonatomic)IBOutlet ImagePlayerView *imagePlayerView;
-(void)updateViews;
@end
