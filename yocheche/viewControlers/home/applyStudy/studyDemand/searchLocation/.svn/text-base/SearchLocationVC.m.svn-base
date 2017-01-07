//
//  SearchLocationVC.m
//  yocheche
//
//  Created by carcool on 3/17/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "SearchLocationVC.h"
#import "StudyDemandVC.h"
#import "ApplyStudyVC.h"
#import "SearchLocationCell.h"
@interface SearchLocationVC ()

@end

@implementation SearchLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"位置搜索";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"确定"];
    [self.rightNaviBtn addTarget:self action:@selector(doneBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.index=-1;
    self.m_aryData=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64+40, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self.btnSearch setColor:YCC_Green];
    self.textfieldSearch.delegate=self;
    self.textfieldSearch.returnKeyType=UIReturnKeySearch;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)searchBtnPressed:(id)sender
{
    if ([self.textfieldSearch.text isEqualToString:@""])
    {
        [self showMessage:@"请输入搜索地址"];
        return;
    }
    Http *req=[[Http alloc] init];
    req.socialMethord=@"search/searchBaiduAreaList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.delegate.data objectForKey:@"cityCode"],self.textfieldSearch.text] forKeys:@[@"account",@"cityCode",@"query"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryData removeAllObjects];
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"areas"]];
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
-(void)doneBtnPressed
{
    if (self.index<0)
    {
        [self showMessage:@"请搜索选择地址"];
    }
    else
    {
        self.delegate.m_currentLocation=(CLLocationCoordinate2D){[[[self.m_aryData objectAtIndex:self.index] objectForKey:@"lat"] floatValue],[[[self.m_aryData objectAtIndex:self.index] objectForKey:@"lng"] floatValue] };
        self.delegate.m_currentAddress=[[self.m_aryData objectAtIndex:self.index] objectForKey:@"address"];
        self.delegate.labelAddress.text=self.delegate.m_currentAddress;
        [self popSelfViewContriller];
    }
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchLocationCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SearchLocationCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SearchLocationCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
    }
    cell.data=[self.m_aryData objectAtIndex:indexPath.row];
    cell.index=indexPath.row;
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
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
#pragma mark ------- event response -----------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self searchBtnPressed:nil];
    return YES;
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
