//
//  FiltrateSchoolVC.m
//  yocheche
//
//  Created by carcool on 11/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "FiltrateSchoolVC.h"
#import "FixLocationVC.h"
#import "FiltrateSchoolCell.h"
@interface FiltrateSchoolVC ()

@end

@implementation FiltrateSchoolVC
@synthesize pickerView,doneBtn,shieldView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"筛选和排序";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitleWithTwoWords:@"清除"];
    [self.rightNaviBtn addTarget:self action:@selector(clearParams) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_arySort=[NSMutableArray arrayWithObjects:@"综合",@"学员数由少到多",@"学员数由多到少",@"好评由少到多",@"好评由多到少",@"价格从低到高",@"价格从高到低",nil];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"筛选驾校"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"筛选驾校"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FiltrateSchoolCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"FiltrateSchoolCell" owner:nil options:nil] objectAtIndex:0];
    cell.delegate=self;
    [cell updateViews];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
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

#pragma mark -------- uipicker view
-(void)creatPickerView:(NSInteger)index
{
    self.m_tableView.userInteractionEnabled=NO;
    if (index==1)
    {
        self.m_currentSelectArray=self.m_arySort;
        self.currentSelectKey=@"orderType";
    }
    
    
    self.pickerView = [[ UIPickerView alloc] initWithFrame:CGRectMake(0, Screen_Height-160, Screen_Width, 160)];
    self.pickerView.backgroundColor=[UIColor whiteColor];
    pickerView.delegate = self;
    pickerView.dataSource =  self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.tag=index;
    [self.view addSubview:pickerView];
    
    self.doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setFrame: CGRectMake(0, Screen_Height-160-40, Screen_Width, 40)];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:YCC_Green];
    [doneBtn addTarget:self action:@selector(selectDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
    
    self.shieldView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-PARENT_Y(doneBtn))];
    [self.shieldView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.shieldView];
    
}
#pragma mark --------- uipicker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.m_currentSelectArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.m_currentSelectArray objectAtIndex:row];
}
-(void)selectDone
{
    self.m_tableView.userInteractionEnabled=YES;
    NSInteger index= [self.pickerView selectedRowInComponent:0];
    if (self.pickerView.tag==1)
    {
        [self.m_filtrateData setObject:[NSString stringWithFormat:@"%d",index] forKey:self.currentSelectKey];
    }
    [self.m_tableView reloadData];
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
    [self.shieldView removeFromSuperview];
    self.shieldView=nil;
}
#pragma mark ------ event response
-(void)clearParams
{
    self.m_filtrateData=[NSMutableDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude],[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude],@"0",@""] forKeys:@[@"lat",@"lng",@"orderType",@"dsname"]];
    self.m_currentAddress=self.delegate.m_currentAddress;
    [self.m_tableView reloadData];
}
-(void)showFixLocationVC
{
    FixLocationVC *vc=[[FixLocationVC alloc] init];
    vc.FixLocationVCDelegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)setLocation:(CLLocationCoordinate2D)loc address:(NSString *)district
{
    self.m_currentLocation=CLLocationCoordinate2DMake(loc.latitude, loc.longitude);
    self.m_currentAddress=district;
    [self.m_tableView reloadData];
}
-(IBAction)filtrateBtnPressed:(id)sender
{
    [self popSelfViewContriller];
    self.delegate.pageIndex=1;
    
    self.delegate.m_currentAddress=self.m_currentAddress;
    self.delegate.m_flitrateData=[NSMutableDictionary dictionaryWithDictionary:self.m_filtrateData];
    [self.delegate setLocation:self.m_currentLocation address:self.m_currentAddress];
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
