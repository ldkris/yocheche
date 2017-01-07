//
//  OtherCenterActionCell.h
//  yocheche
//
//  Created by carcool on 8/17/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebImageViewNormal.h"
@protocol OtherCenterActionCellDelegate <NSObject>
-(void)showPostVCFromCenter:(NSDictionary*)preData;
@end
@interface OtherCenterActionCell : UITableViewCell
@property(nonatomic,assign)id<OtherCenterActionCellDelegate> vcDelegate;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *img1;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *img2;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *img3;
@property(nonatomic,retain)IBOutlet UIButton *btn1;
@property(nonatomic,retain)IBOutlet UIButton *btn2;
@property(nonatomic,retain)IBOutlet UIButton *btn3;
@property(nonatomic,retain)NSMutableArray *m_aryData;
-(void)updateView;
@end
