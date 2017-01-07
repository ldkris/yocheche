//
//  FlitrateCoachCell.h
//  yocheche
//
//  Created by carcool on 8/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlitrateCoachVC.h"
@interface FlitrateCoachCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,assign)FlitrateCoachVC *delegate;
@property(nonatomic,retain)IBOutlet UILabel *labelAddress;
@property(nonatomic,retain)IBOutlet UILabel *labelLisenceType;
@property(nonatomic,retain)IBOutlet UILabel *labelSort;
@property(nonatomic,retain)IBOutlet UITextField *textFieldSchool;
-(void)updateViews;
@end
