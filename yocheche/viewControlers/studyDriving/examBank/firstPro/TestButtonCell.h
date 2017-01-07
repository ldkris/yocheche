//
//  TestButtonCell.h
//  weixueche
//
//  Created by carcool on 12/14/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestPageView.h"
@interface TestButtonCell : UITableViewCell
@property(nonatomic,retain)IBOutlet MyButton *button;
@property(nonatomic,assign)TestPageView *delegate;
@end
