//
//  PostTagsCell.m
//  yocheche
//
//  Created by carcool on 9/22/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PostTagsCell.h"

@implementation PostTagsCell

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
    [self.labelContent removeFromSuperview];
    self.labelContent=nil;
    [self.contentBG removeFromSuperview];
    self.contentBG=nil;
    //height
    NSMutableString *tagsContent=[NSMutableString stringWithString:@""];
    for (NSString *tag in [self.data objectForKey:@"tags"])
    {
        [tagsContent appendString:[NSString stringWithFormat:@"#%@ ",tag]];
    }
    self.contentHeight=[MyFounctions calculateLabelHeightWithString:tagsContent Width:240 font:[UIFont systemFontOfSize:14]];
    
    if (![tagsContent isEqualToString:@""])
    {
        self.labelContent=[[UILabel alloc] initWithFrame:CGRectMake(50,5,240, self.contentHeight)];
        [self.labelContent setNumberOfLines:0];
        [self.labelContent setTextColor:YCC_TextColor];
        [self.labelContent setFont:[UIFont systemFontOfSize:14.0]];
        self.labelContent.text=tagsContent;
        //    NSLog(@"tagsContent :%@",tagsContent);
        self.contentBG=[[UIView alloc] initWithFrame:CGRectMake(10, 0,300, self.contentHeight+10)];
        if ([tagsContent isEqualToString:@""])
        {
            [self.contentBG setFrame:CGRectMake(10, 0, 300, 0)];
        }
        [self.contentBG setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.contentBG];
        [self.contentBG addSubview:self.labelContent];
    }
    
}
@end
