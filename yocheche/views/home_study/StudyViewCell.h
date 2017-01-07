//
//  StudyViewCell.h
//  yocheche
//
//  Created by carcool on 6/29/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyView.h"
@interface StudyViewCell : UITableViewCell
@property(nonatomic,retain)StudyView *delegate;
@property(nonatomic,assign)IBOutlet UILabel *labelNum;
@property(nonatomic,assign)IBOutlet UILabel *labelSignInNum;
@end
