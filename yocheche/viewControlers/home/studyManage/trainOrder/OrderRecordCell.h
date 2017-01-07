//
//  OrderRecordCell.h
//  yocheche
//
//  Created by carcool on 2/18/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderRecordCell;
@protocol OrderRecordCellDelegate <NSObject>
-(void)cancelOrderDrive:(NSDictionary*)data;
//-(void)showCommentVC:(NSDictionary *)data;
@end

@interface OrderRecordCell : UITableViewCell
@property(nonatomic,assign)id<OrderRecordCellDelegate> delegate;
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UILabel *labelState;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelSchool;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
-(void)updateView;
@end
