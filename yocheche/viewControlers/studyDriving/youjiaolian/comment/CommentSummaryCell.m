//
//  CommentSummaryCell.m
//  yocheche
//
//  Created by carcool on 2/19/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "CommentSummaryCell.h"

@implementation CommentSummaryCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    self.m_aryBtns=[NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelNum.text=[[self.data objectForKey:@"goods"] stringValue];
    
    for (UIButton *btn in self.m_aryBtns)
    {
        [btn removeFromSuperview];
    }
    [self.m_aryBtns removeAllObjects];
    
    float btnWidth=(300-40)/3.0;
    NSInteger i=0;
    for (NSString *dic in (NSArray*)[self.data objectForKey:@"maxTags"])
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn.layer setBorderWidth:0.5];
        [btn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [btn setFrame:CGRectMake(180,8+(i/1)*(30+8), btnWidth, 30)];
        [btn setTitle:dic forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        btn.tag=i;
        [self.m_aryBtns addObject:btn];
        [self.contentBG addSubview:btn];
        i++;
    }
    
    if ([(NSArray*)[self.data objectForKey:@"maxTags"] count]>0)
    {
        self.labelNote.hidden=YES;
    }
    else
    {
        self.labelNote.hidden=NO;
    }
}
@end
