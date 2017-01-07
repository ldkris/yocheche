//
//  SchoolCell.h
//  yocheche
//
//  Created by carcool on 11/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)IBOutlet UIView *contentBG;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,retain)IBOutlet UIImageView *imgZhiying;
@property(nonatomic,retain)IBOutlet UIImageView *imgFens;
@property(nonatomic,assign)IBOutlet UILabel *labelName;
@property(nonatomic,assign)IBOutlet UILabel *labelPrice;
@property(nonatomic,assign)IBOutlet UILabel *labelDistance;
@property(nonatomic,assign)IBOutlet UILabel *labelPeople;
@property(nonatomic,assign)IBOutlet UILabel *labelGood;
-(void)updateView;
@end
