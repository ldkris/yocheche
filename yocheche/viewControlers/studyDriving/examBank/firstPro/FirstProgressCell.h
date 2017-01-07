//
//  FirstProgressCell.h
//  yocheche
//
//  Created by carcool on 7/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstProgressVC.h"
@interface FirstProgressCell : UITableViewCell
@property(nonatomic,assign) FirstProgressVC *delegate;
@property(nonatomic,assign)IBOutlet UIView *itemBG0;
@property(nonatomic,assign)IBOutlet UIView *itemBG1;
@property(nonatomic,assign)IBOutlet UIView *itemBG2;
@end
