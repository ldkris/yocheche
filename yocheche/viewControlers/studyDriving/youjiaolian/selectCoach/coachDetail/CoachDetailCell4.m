//
//  CoachDetailCell4.m
//  yocheche
//
//  Created by carcool on 8/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CoachDetailCell4.h"
#import "AllStudentsVC.h"
@implementation CoachDetailCell4

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    for (UIView *subview in [self subviews])
    {
        if (subview.frame.size.width!=Screen_Width)
        {
            [subview removeFromSuperview];
        }
    }
    NSInteger i=0;
    for (NSDictionary *dic in self.m_aryStudent)
    {
        if (i<=10)
        {
            WebImageViewNormal *img=[[WebImageViewNormal alloc] initWithFrame:CGRectMake(16+(16+60)*(i%4), 20+70*(i/4), 60, 60)];
            [img setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]];
            img.userInteractionEnabled=YES;
            [self addSubview:img];
            UIButton *btnShow=[UIButton buttonWithType:UIButtonTypeCustom];
            btnShow.tag=i;
            [btnShow setFrame:CGRectMake(0, 0, 60, 60)];
            [btnShow addTarget:self action:@selector(showStudentCenterVC:) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btnShow];
        }
        i++;
    }
    if (i>=11)
    {
        i=11;
        [self.moreView setFrame:CGRectMake(16+(16+60)*(i%4), 20+70*(i/4), 60, 60)];
        [self addSubview:self.moreView];
    }
}
-(IBAction)showMoreStudents:(id)sender
{
    AllStudentsVC *vc=[[AllStudentsVC alloc] init];
    vc.delegate=self.delegate;
    [self.delegate.navigationController pushViewController:vc animated:YES];
}
-(IBAction)showStudentCenterVC:(id)sender
{
    UIButton *btnShow=(UIButton*)sender;
    [self.delegate showStudentCenterVC:[[self.m_aryStudent objectAtIndex:btnShow.tag] objectForKey:@"account"]];
}
@end
