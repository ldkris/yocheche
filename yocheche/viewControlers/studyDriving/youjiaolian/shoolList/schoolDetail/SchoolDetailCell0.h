//
//  SchoolDetailCell0.h
//  yocheche
//
//  Created by carcool on 12/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolDetailCell0 : UITableViewCell<ImagePlayerViewDelegate>
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UILabel *labelName;
@property(nonatomic,assign)IBOutlet UILabel *labelAddress;
@property(nonatomic,assign)IBOutlet UILabel *labelPhone;
@property (retain, nonatomic)IBOutlet ImagePlayerView *imagePlayerView;
-(void)updateView;
@end
