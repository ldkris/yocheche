//
//  SchoolDetailCell2.h
//  yocheche
//
//  Created by carcool on 12/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolDetailCell2 : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)NSInteger descriptionExpand;
@property(nonatomic,assign)IBOutlet UIImageView *imgJt;
@property(nonatomic,assign)IBOutlet UILabel *labelExpand;
-(void)updateView;
@end
