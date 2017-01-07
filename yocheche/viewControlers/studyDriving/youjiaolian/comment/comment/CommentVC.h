//
//  CommentVC.h
//  yocheche
//
//  Created by carcool on 8/8/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface CommentVC : YCCViewController<UITextViewDelegate>
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,retain)NSDictionary *coachData;
@property(nonatomic,retain)IBOutlet UILabel *labelTextViewPlaceholder;
@property(nonatomic,retain)IBOutlet UITextView *textViewComment;
@property(nonatomic,retain)IBOutlet UIImageView *imgGood;
@property(nonatomic,assign)NSString *goodComment;//1:good 
@end
