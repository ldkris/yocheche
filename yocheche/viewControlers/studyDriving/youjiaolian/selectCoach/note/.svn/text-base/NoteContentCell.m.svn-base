//
//  NoteContentCell.m
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "NoteContentCell.h"

@implementation NoteContentCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    if ([self.labelContent superview])
    {
        [self.labelContent removeFromSuperview];
        self.labelContent=nil;
    }
    self.labelContent=[[UILabel alloc] initWithFrame:CGRectMake(20, 5, Screen_Width-40, self.strHeight)];
    self.labelContent.numberOfLines=0;
    [self.labelContent setTextColor:[UIColor darkGrayColor]];
    [self.labelContent setFont:[UIFont systemFontOfSize:15.0]];
    self.labelContent.text=self.strNote;
    [self addSubview:self.labelContent];
}
@end
