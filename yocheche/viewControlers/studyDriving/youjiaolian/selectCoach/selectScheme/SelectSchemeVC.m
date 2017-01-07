//
//  SelectSchemeVC.m
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SelectSchemeVC.h"
#import "CoachDetailCell0.h"
#import "SchemeCell.h"
#import "NoteCourseVC.h"
@interface SelectSchemeVC ()

@end

@implementation SelectSchemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"选择方案";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.selectedIndex=-1;
    [self addTableView];
    [self.m_tableView setFrame: CGRectMake(0,64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.delegate.feeArray.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        CoachDetailCell0 *cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCell0" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self.delegate;
        [cell updateViews];
        return cell;
    }
    else
    {
        SchemeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SchemeCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"SchemeCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.index=indexPath.row-1;
        [cell updateView];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (indexPath.row==0)
    {
        height=290;
    }
    else
    {
        height=226;
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
#pragma mark -------- event response
-(void)setSelectedScheme:(NSInteger)index
{
    self.selectedIndex=index;
//    [self.btn setTitle:[NSString stringWithFormat:@"确定方案 %d",index] forState:UIControlStateNormal];
    [self.m_tableView reloadData];
}
-(IBAction)nextStepBtnPressed:(id)sender
{
    if(self.selectedIndex>=0)
    {
        NSMutableDictionary *user=[NSMutableDictionary dictionaryWithDictionary:[MyFounctions getUserInfo]];
        [user setObject:self.delegate.coachData forKey:@"coach"];
        [user setObject:[self.delegate.feeArray objectAtIndex:self.selectedIndex] forKey:@"fee"];
        [user setObject:self.delegate.schoolData forKey:@"school"];
        [MyFounctions saveUserInfo:(NSDictionary*)user];
        NoteCourseVC *vc=[[NoteCourseVC alloc] init];
        vc.delegate=self.delegate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [self showMessage:@"请选择学车方案"];
    }
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
