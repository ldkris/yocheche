//
//  NoteCourseVC.m
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "NoteCourseVC.h"
#import "CoachDetailCell0.h"
#import "NoteContentCell.h"
#import "InputInviteCodeVC.h"
@interface NoteCourseVC ()

@end

@implementation NoteCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"友情提示";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *user=[MyFounctions getUserInfo];
    self.strNote=[NSString stringWithFormat:@"      非常感谢您选择%@%@开启您定驾驶生涯！\n      为了保证您定教学质量，%@实行教练分科教学制度。\n      %@承诺由您选择%@负责您定科目二教学。您的其他科目教练会由驾校安排其他专业教练为您教学。\n      注：\n      实行分科教学定驾校都会作出上述承诺。",[[user objectForKey:@"school"] objectForKey:@"name"],[[user objectForKey:@"coach"] objectForKey:@"name"],[[user objectForKey:@"school"] objectForKey:@"name"],[[user objectForKey:@"school"] objectForKey:@"name"],[[user objectForKey:@"coach"] objectForKey:@"name"]];
    self.strHeight=[MyFounctions calculateLabelHeightWithString:self.strNote Width:280.0 font:[UIFont systemFontOfSize:15.0]];
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
    return 2;
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
        NoteContentCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"NoteContentCell" owner:nil options:nil] objectAtIndex:0];
        cell.strNote=self.strNote;
        cell.strHeight=self.strHeight;
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
        height=self.strHeight+5+5;
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
#pragma mark ----------- event response
-(IBAction)nextStepBtnPressed:(id)sender
{
    InputInviteCodeVC *vc=[[InputInviteCodeVC alloc] init];
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
