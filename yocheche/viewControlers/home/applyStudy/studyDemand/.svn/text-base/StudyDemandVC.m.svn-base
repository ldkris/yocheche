//
//  StudyDemandVC.m
//  yocheche
//
//  Created by carcool on 3/16/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "StudyDemandVC.h"
#import "ApplyStudyVC.h"
#import "SearchLocationVC.h"
#import "MyGrabedListVC.h"
#import "WebViewVC.h"
@interface StudyDemandVC ()

@end

@implementation StudyDemandVC
@synthesize doneBtn,pickerView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"学车信息";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"报名流程"];
    [self.rightNaviBtn addTarget:self action:@selector(showSignInProgress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    [self.labelDiscount setFrame:CGRectMake(0, Screen_Height-70, Screen_Width, 20)];
    [self.view addSubview:self.labelDiscount];
    [self.contentBG setClipsToBounds:YES];
    [self.contentBG.layer setCornerRadius:3.0];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    //profile info
    [self.contentBG2 setClipsToBounds:YES];
    [self.contentBG2.layer setCornerRadius:3.0];
    [self.lineView3 setBackgroundColor:YCC_GrayBG];
    self.textfieldName.delegate=self;
    self.textfieldName.returnKeyType=UIReturnKeyDone;
    self.textfieldMobile.delegate=self;
    self.textfieldMobile.returnKeyType=UIReturnKeyDone;
    
    self.inputProfileNeed=1;
    self.licenseType=-1;
    self.m_aryData=[NSMutableArray array];
    self.m_currentSelectArray=[NSMutableArray arrayWithObjects:@"C1手动档",@"C2自动档", nil];
    [self checkIfNeedInputProfile];
    [self getLevelCode];
    
    self.m_currentLocation=(CLLocationCoordinate2D){0.0};
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}
-(void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
#pragma mark ---------- BMKLocationServiceDelegate
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    //发起反向地理编码检索
    if (userLocation.location.coordinate.latitude>0)
    {
        self.m_currentLocation= (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    }
    else
    {
        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        self.m_currentLocation= (CLLocationCoordinate2D){appdelegate.m_currentLocation.latitude, appdelegate.m_currentLocation.longitude};
    }
    
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = self.m_currentLocation;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}
#pragma mark --------- BMKGeoCodeSearch delegate
//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        self.labelAddress.text=result.address;
        self.m_currentAddress=result.address;
        _searcher.delegate = nil;
        [_locService stopUserLocationService];
        _locService.delegate=nil;
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)checkIfNeedInputProfile
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grab/checkUserInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.inputProfileNeed=[[req.m_data objectForKey:@"status"] integerValue];
            if (self.inputProfileNeed==2)
            {
                self.labelNote.hidden=YES;
                self.contentBG2.hidden=YES;
            }
            [self getFeeData];
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
-(void)getFeeData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grab/getDriveFeeList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryData removeAllObjects];
            self.m_aryData=[req.m_data objectForKey:@"fees"];
            self.showData=req.m_data;
            self.labelDiscount.text=[self.showData objectForKey:@"desc"];
            self.labelSignNum.text=[NSString stringWithFormat:@"%d人已报名",[[self.showData objectForKey:@"applyNum"] integerValue]];
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
-(void)getLevelCode
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grab/getGrabIndexInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
//    [self showLoadingWithBG];
    [req startWithBlock:^{
//        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=req.m_data;
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
#pragma mark -------- uipicker view
-(IBAction)creatPickerView:(id)sender
{
    self.pickerView = [[ UIPickerView alloc] initWithFrame:CGRectMake(0, Screen_Height-160, Screen_Width, 160)];
    self.pickerView.backgroundColor=[UIColor whiteColor];
    pickerView.delegate = self;
    pickerView.dataSource =  self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.tag=0;
    [self.view addSubview:pickerView];
    
    self.doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setFrame: CGRectMake(0, Screen_Height-160-40, Screen_Width, 40)];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:YCC_Green];
    [doneBtn addTarget:self action:@selector(selectDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
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
    self.licenseType= [self.pickerView selectedRowInComponent:0];
    self.labelType.text=[self.m_currentSelectArray objectAtIndex:self.licenseType];
    self.labelPrice.text=[NSString stringWithFormat:@"%d-%d",[[[self.m_aryData objectAtIndex:self.licenseType] objectForKey:@"minFee"] integerValue],[[[self.m_aryData objectAtIndex:self.licenseType] objectForKey:@"maxFee"] integerValue]];
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
}
#pragma mark ---------- textfield delegate ------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ------- event response --------
-(void)showSignInProgress
{
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.title=@"报名流程";
    vc.urlStr=[self.showData objectForKey:@"applyUrl"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)showSearchLocationVC:(id)sender
{
    SearchLocationVC *vc=[[SearchLocationVC alloc] init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)submitBtnPressed:(id)sender
{
    if (self.licenseType<0)
    {
        [self showMessage:@"请选择驾照类型"];
        return;
    }
    if (self.inputProfileNeed==1)
    {
        if ([self.textfieldName.text isEqualToString:@""])
        {
            [self showMessage:@"请输入姓名"];
            return;
        }
        else if ([self.textfieldMobile.text isEqualToString:@""])
        {
            [self showMessage:@"请输入手机号"];
            return;
        }
    }
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grab/putLaunchOrderInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.licenseType+1],self.m_currentAddress,[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude],[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude],self.textfieldName.text,self.textfieldMobile.text,[self.data objectForKey:@"levelcode"],@"1",self.coachID] forKeys:@[@"account",@"driverType",@"space",@"lng",@"lat",@"username",@"mobile",@"levelcode",@"source",@"coachid"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            MyGrabedListVC *vc=[[MyGrabedListVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
