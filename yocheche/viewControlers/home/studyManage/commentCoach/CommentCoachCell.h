//
//  CommentCoachCell.h
//  yocheche
//
//  Created by carcool on 2/16/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCoachCell : UITableViewCell<UITextViewDelegate>
@property(nonatomic,retain)IBOutlet UITextView *textViewContent;
@property(nonatomic,retain)IBOutlet UIButton *btnWriteConetnt;
@property(nonatomic,retain)IBOutlet UILabel *labelContentDefault;
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UIView *lineView1;
@property(nonatomic,assign)IBOutlet UIImageView *imgStar1;
@property(nonatomic,assign)IBOutlet UIImageView *imgStar2;
@property(nonatomic,assign)IBOutlet UIImageView *imgStar3;
@property(nonatomic,assign)IBOutlet UIImageView *imgStar4;
@property(nonatomic,assign)IBOutlet UIImageView *imgStar5;
@property(nonatomic,assign)IBOutlet UILabel *labelGrade;
@property(nonatomic,assign)NSInteger starNum;
@end
