//
//  MyCenterTopCell.h
//  yocheche
//
//  Created by carcool on 6/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyCenterView;
@interface MyCenterTopCell : UITableViewCell
@property(nonatomic,assign)MyCenterView *delegate;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet MyButton *btnEdit;
@property(nonatomic,retain)IBOutlet UILabel *labelSign;
@property(nonatomic,retain)IBOutlet UILabel *labelPostNum;
@property(nonatomic,retain)IBOutlet UILabel *labelFollowNum;
@property(nonatomic,retain)IBOutlet UILabel *labelFansNum;
@property(nonatomic,retain)IBOutlet UILabel *labelLikeNum;
@property(nonatomic,retain)IBOutlet UILabel *labelSite;
@property(nonatomic,retain)IBOutlet UILabel *labelInfo;
@property(nonatomic,retain)IBOutlet UILabel *labelArea;
@property(nonatomic,retain)IBOutlet UIView *topBG;
@property(nonatomic,retain)IBOutlet UIView *bottomBG;

-(void)updateView;
@end
