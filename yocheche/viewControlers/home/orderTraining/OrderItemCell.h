//
//  OrderItemCell.h
//  yocheche
//
//  Created by carcool on 2/4/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderTrainingVC;
@interface OrderItemCell : UITableViewCell
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)OrderTrainingVC *delegate;
@property(nonatomic,retain)NSMutableDictionary *data;
@property(nonatomic,assign)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)UILabel *labelCount;
@property(nonatomic,assign)IBOutlet UIImageView *imgSelect;
@property(nonatomic,retain)NSMutableArray *m_aryAvatars;
-(void)updateView;
@end
