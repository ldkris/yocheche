//
//  SelectSchoolVC.m
//  yocheche
//
//  Created by carcool on 8/14/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SelectSchoolVC.h"
#import "SelectSchoolCell.h"
@interface SelectSchoolVC ()

@end

@implementation SelectSchoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"选择院校";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.selectType=0;
    self.m_aryProvince=[NSMutableArray array];
    self.m_arySchool=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame: CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
    [self updateData];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"province.all.get"] forKeys:@[@"method"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.m_aryProvince=[req.m_data objectForKey:@"provinces"];
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
-(void)updateSchoolData:(NSString*)provinceCode
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"college.all.get",provinceCode] forKeys:@[@"method",@"levelcode"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.m_arySchool=[req.m_data objectForKey:@"colleges"];
            self.selectType=1;
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
    if (self.selectType==0)
    {
        return self.m_aryProvince.count;
    }
    else
    {
        return self.m_arySchool.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectSchoolCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectSchoolCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SelectSchoolCell" owner:nil options:nil] objectAtIndex:0];
    }
    if (self.selectType==0)
    {
        cell.labelTitle.text=[[self.m_aryProvince objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
    else
    {
        cell.labelTitle.text=[[self.m_arySchool objectAtIndex:indexPath.row] objectForKey:@"collegename"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectType==0)
    {
        [self updateSchoolData:[[self.m_aryProvince objectAtIndex:indexPath.row] objectForKey:@"levelcode"]];
    }
    else
    {
        [self.delegate.data setObject:[[self.m_arySchool objectAtIndex:indexPath.row] objectForKey:@"collegename"] forKey:@"collegename"];
        [self.delegate.data setObject:[[self.m_arySchool objectAtIndex:indexPath.row] objectForKey:@"collegecode"] forKey:@"collegecode"];
        [self.delegate.m_tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
