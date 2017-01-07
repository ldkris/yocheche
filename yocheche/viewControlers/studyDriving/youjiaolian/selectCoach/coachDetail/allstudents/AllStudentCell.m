//
//  AllStudentCell.m
//  yocheche
//
//  Created by carcool on 9/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "AllStudentCell.h"
#import "OtherCenterVC.h"
@implementation AllStudentCell

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
    self.img1.hidden=YES;
    self.img2.hidden=YES;
    self.img3.hidden=YES;
    NSInteger i=0;
    for (NSDictionary *dic in self.m_aryData)
    {
        if (i==0)
        {
            [self.img1 setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"userpic"]]];
            self.btn1.hidden=NO;
            self.img1.hidden=NO;
        }
        else if (i==1)
        {
            [self.img2 setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"userpic"]]];
            self.btn2.hidden=NO;
            self.img2.hidden=NO;
        }
        else if (i==2)
        {
            [self.img3 setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"userpic"]]];
            self.btn3.hidden=NO;
            self.img3.hidden=NO;
        }
        i++;
    }
}
-(IBAction)showOtherCenterVC:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObject:[[self.m_aryData objectAtIndex:btn.tag] objectForKey:@"account"] forKey:@"account"];
    [self.delegate.navigationController pushViewController:vc animated:YES];
}
@end
