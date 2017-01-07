//
//  PostCommentCell.m
//  yocheche
//
//  Created by carcool on 8/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PostCommentCell.h"

@implementation PostCommentCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    NSMutableArray *aryComment=[NSMutableArray arrayWithArray:[self.data objectForKey:@"userComments"]];
    self.labelComment1.hidden=YES;
    self.labelComment2.hidden=YES;
    self.labelComment3.hidden=YES;
    self.labelName1.hidden=YES;
    self.labelName2.hidden=YES;
    self.labelName3.hidden=YES;
    NSInteger i=0;
    for (NSDictionary *comment in aryComment)
    {
        if (i==0)
        {
            self.labelName1.text=[comment objectForKey:@"nikename"];
            self.labelComment1.text=[comment objectForKey:@"content"];
            self.labelName1.hidden=NO;
            self.labelComment1.hidden=NO;
        }
        else if (i==1)
        {
            self.labelName2.text=[comment objectForKey:@"nikename"];
            self.labelComment2.text=[comment objectForKey:@"content"];
            self.labelName2.hidden=NO;
            self.labelComment2.hidden=NO;
        }
        else if (i==2)
        {
            self.labelName3.text=[comment objectForKey:@"nikename"];
            self.labelComment3.text=[comment objectForKey:@"content"];
            self.labelName3.hidden=NO;
            self.labelComment3.hidden=NO;
        }
        i++;
    }

}
@end
