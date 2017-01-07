//
//  OtherCenterActionCell.m
//  yocheche
//
//  Created by carcool on 8/17/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OtherCenterActionCell.h"

@implementation OtherCenterActionCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.btn1.hidden=YES;
    self.btn2.hidden=YES;
    self.btn3.hidden=YES;
    NSInteger i=0;
    for (NSDictionary *dic in self.m_aryData)
    {
        if (i==0)
        {
            [self.img1 setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"imgrul"]]];
            self.btn1.hidden=NO;
        }
        else if (i==1)
        {
            [self.img2 setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"imgrul"]]];
            self.btn2.hidden=NO;
        }
        else if (i==2)
        {
            [self.img3 setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"imgrul"]]];
            self.btn3.hidden=NO;
        }
        i++;
    }
}
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [self.vcDelegate showPostVCFromCenter:[self.m_aryData objectAtIndex:btn.tag]];
}
@end
