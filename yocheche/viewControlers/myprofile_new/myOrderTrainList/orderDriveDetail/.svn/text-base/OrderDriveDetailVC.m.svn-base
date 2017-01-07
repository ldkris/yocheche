//
//  OrderDriveDetailVC.m
//  yocheche
//
//  Created by carcool on 9/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OrderDriveDetailVC.h"
#import "DriveDetailCellTop.h"
#import "DriveDetailCellFailReason.h"
#import "CommentCell.h"
#import "CoachDetailVC.h"
#import "OtherCenterVC.h"
@interface OrderDriveDetailVC ()

@end

@implementation OrderDriveDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的练车";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.m_aryShowed=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self updateData];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"find.apply.detail",[self.preData objectForKey:@"applyid"]] forKeys:@[@"method",@"applyid"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=req.m_data;
            if ([[self.data objectForKey:@"status"] integerValue]==2||[[self.data objectForKey:@"status"] integerValue]==5)
            {
                self.m_aryShowed=[NSMutableArray arrayWithObjects:@"top",@"reason", nil];
            }
            else
            {
                self.m_aryShowed=[NSMutableArray arrayWithObjects:@"top", nil];
                if (![[[self.data objectForKey:@"student"] objectForKey:@"stu_createtime"] isEqualToString:@""])
                {
                    [self.m_aryShowed addObject:@"comment"];
                }
                if (![[self.data objectForKey:@"teaching_log"] isEqualToString:@""])
                {
                    [self.m_aryShowed addObject:@"log"];
                }
            }
            [self.m_tableView reloadData];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryShowed.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"top"])
    {
        DriveDetailCellTop *cell=[tableView dequeueReusableCellWithIdentifier:@"DriveDetailCellTop"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"DriveDetailCellTop" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.data=self.data;
        [cell updateView];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"reason"])
    {
        DriveDetailCellFailReason *cell=[tableView dequeueReusableCellWithIdentifier:@"DriveDetailCellFailReason"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"DriveDetailCellFailReason" owner:nil options:nil] objectAtIndex:0];
        }
        cell.labelReason.text=[self.data objectForKey:@"reason_desc"];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"comment"])
    {
        CommentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.data=self.data;
        //updateView
        float comtentHeight=[MyFounctions calculateLabelHeightWithString:[[self.data objectForKey:@"student"] objectForKey:@"stu_content"] Width:224 font:[UIFont systemFontOfSize:14.0]];
        cell.contentHeight=comtentHeight;
        [cell updateViewForOrderDriveComment];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"log"])
    {
        CommentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=nil;
        }
        //updateView
        [cell.bottomBG removeFromSuperview];
        float comtentHeight=[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"teaching_log"]  Width:224 font:[UIFont systemFontOfSize:14.0]];
        cell.contentHeight=comtentHeight;
        if (cell.labelContent)
        {
            [cell.labelContent removeFromSuperview];
            cell.labelContent=nil;
        }
        cell.labelContent=[[UILabel alloc] initWithFrame:CGRectMake(83, 70, 224, cell.contentHeight)];
        cell.labelContent.text=[self.data objectForKey:@"teaching_log"];
        [cell.labelContent setTextColor:[UIColor darkGrayColor]];
        [cell.labelContent setFont:[UIFont systemFontOfSize:14.0]];
        cell.labelContent.numberOfLines=0;
        [cell addSubview:cell.labelContent];
        
        cell.labelTime.text=[NSString stringWithFormat:@"%@ %@-%@",[[self.data objectForKey:@"coach"] objectForKey:@"coa_date"],[[self.data objectForKey:@"coach"] objectForKey:@"coa_begintime"],[[self.data objectForKey:@"coach"] objectForKey:@"coa_endtime"]];
        [cell.avatar setWebImageViewWithURL:[NSURL URLWithString:[[self.data objectForKey:@"coach"] objectForKey:@"coa_pic"]]];
        cell.labelName.text=[[self.data objectForKey:@"coach"] objectForKey:@"coa_idcname"];
        return cell;
    }

    else
    {
        return [[UITableViewCell alloc] init];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"top"])
    {
        return  140;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"reason"])
    {
        return 90;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"comment"])
    {
        return 70+[MyFounctions calculateLabelHeightWithString:[[self.data objectForKey:@"student"] objectForKey:@"stu_content"] Width:224 font:[UIFont systemFontOfSize:14.0]]+40;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"log"])
    {
        return 70+[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"teaching_log"]  Width:224 font:[UIFont systemFontOfSize:14.0]]+15;
    }

    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -------- drive detail top delegate -------
-(void)showCoachDetailVC:(NSString *)coachID
{
    CoachDetailVC *vc=[[CoachDetailVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObjects:@[coachID] forKeys:@[@"coachId"]];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -------- comment cell delegate ------
-(void)showOtherCenterVCTappedAvatar:(NSString *)account
{
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObject:account forKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
