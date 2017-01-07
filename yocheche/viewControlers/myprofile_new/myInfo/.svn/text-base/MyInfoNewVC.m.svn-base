//
//  MyInfoNewVC.m
//  yocheche
//
//  Created by carcool on 9/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyInfoNewVC.h"
#import <QiniuSDK.h>
#import "EditTextInfoVC.h"
#import "MyInfoNewCell.h"
@interface MyInfoNewVC ()

@end

@implementation MyInfoNewVC
@synthesize picker,pickerView,doneBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"账号设置";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.btn.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.btn.layer setBorderWidth:0.5];
    [self.btn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.btn];
    
    self.m_aryHoroscope=[NSArray arrayWithObjects:@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座", nil];
    self.m_aryMarry=[NSArray arrayWithObjects:@"保密",@"已婚",@"单身", nil];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-40-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self updateData];
    [MobClick beginLogPageView:@"MyInfoNewVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"MyInfoNewVC"];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"info.user.get",[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"method",@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.preData=[NSMutableDictionary dictionaryWithDictionary:req.m_data];
            [self updateView];
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
-(void)updateView
{
//    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.preData objectForKey:@"userpic"]]];
//    self.labelName.text=[self.preData objectForKey:@"nickname"];
//    self.labelAge.text=[self.preData objectForKey:@"age"];
//    self.labelHoroscope.text=[self.preData objectForKey:@"horoscope"];
//    if ([[self.preData objectForKey:@"sex"] integerValue]==1)
//    {
//        [self.imgBoy setImage:[UIImage imageNamed:@"selectScheme_on"]];
//        [self.imgGirl setImage:[UIImage imageNamed:@"selectScheme_off"]];
//    }
//    else if ([[self.preData objectForKey:@"sex"] integerValue]==2)
//    {
//        [self.imgBoy setImage:[UIImage imageNamed:@"selectScheme_off"]];
//        [self.imgGirl setImage:[UIImage imageNamed:@"selectScheme_on"]];
//    }
//    self.labelMobile.text=[self.preData objectForKey:@"phone"];
    [self.m_tableView reloadData];
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
    MyInfoNewCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"MyInfoNewCell" owner:nil options:nil] objectAtIndex:0];
    cell.delegate=self;
    cell.preData=self.preData;
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 520;
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
-(void)showPickerViewBtnPressed
{
    [self addBlackBGView];
    UIButton *btnRmove=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnRmove setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [btnRmove addTarget:self action:@selector(removeSelectPhotoTypeView) forControlEvents:UIControlEventTouchUpInside];
    [self.blackBG addSubview:btnRmove];
    [self.actionSheetBG setFrame:CGRectMake(0, Screen_Height-120, Screen_Width, 120)];
    [self.view addSubview:self.actionSheetBG];
}
-(void)removeSelectPhotoTypeView
{
    [self removeBLackBGView];
    [self.actionSheetBG removeFromSuperview];
}
-(IBAction)cameraOrAlbumBtnPressed:(id)sender
{
    [self removeBLackBGView];
    [self.actionSheetBG removeFromSuperview];
    UIButton *btnAvatar=(UIButton*)sender;
    if (btnAvatar.tag==0)//拍照
    {
        [self showPickVC:0];
    }
    else//相册
    {
        [self showPickVC:1];
    }
}
#pragma mark ----------------- upload avatar ------------------
-(void)showPickVC:(NSInteger)source//0:camera 1:album
{
    self.picker=nil;
    self.picker = [[UIImagePickerController alloc]init];
    picker.view.backgroundColor = [UIColor orangeColor];
    UIImagePickerControllerSourceType sourcheType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if (source==0)
    {
        sourcheType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    picker.sourceType = sourcheType;
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    [self presentViewController:picker animated:YES completion:^{
        [self stopLoadingWithBG];
    }];
    
}
#pragma mark ------ uiimagepickercontroller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* img = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *dataimg = UIImageJPEGRepresentation(img, 0.4);
    
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/getUptoken.yo";
    [req setParams:@[@"U1000",[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"type",@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            //upload image
            NSString *token = [req.m_data objectForKey:@"uptoken"];
            NSString *fname=[NSString stringWithFormat:@"%@.jpg",[req.m_data objectForKey:@"fname"]];
            QNUploadManager *upManager = [[QNUploadManager alloc] init];
            [upManager putData:dataimg key:fname token:token
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          NSLog(@"info :%@", info);
                          NSLog(@"resp :%@", resp);
                          [self showLoadingWithBG];
                          Http *req=[[Http alloc] init];
                          [req setParams:@[@"pic.user.put",[[MyFounctions getUserInfo] objectForKey:@"account"],fname] forKeys:@[@"method",@"account",@"filename"]];
                          [req startWithBlock:^{
                              [self stopLoadingWithBG];
                              if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
                              {
                                  [self showMessage:@"上传成功！"];
                                  [self updateData];
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
                          
                      } option:nil];
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
    
    
    
    [self.picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark --------- uipicker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(self.pickerView.tag==0)
    {
        return self.m_aryHoroscope.count;
    }
    else
    {
        return self.m_aryMarry.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str=[self.m_aryHoroscope objectAtIndex:row];
    if(self.pickerView.tag==0)
    {
        str=[self.m_aryHoroscope objectAtIndex:row];
    }
    else
    {
        str=[self.m_aryMarry objectAtIndex:row];
    }
    return str;
}

//creat select horoscope list
-(void)creatPickerView
{
    self.pickerView = [[ UIPickerView alloc] initWithFrame:CGRectMake(0, Screen_Height-180, Screen_Width, 180)];
    [self.pickerView setBackgroundColor:[UIColor whiteColor]];
    pickerView.delegate = self;
    pickerView.dataSource =  self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.tag=0;
    
    [self.view addSubview:pickerView];
    
    self.doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setFrame: CGRectMake(0, Screen_Height-180-40, Screen_Width, 40)];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:YCC_Green];
    [doneBtn addTarget:self action:@selector(selectDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
    
    //    self.shieldView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-PARENT_Y(doneBtn))];
    //    [self.shieldView setBackgroundColor:[UIColor clearColor]];
    //    [self.view addSubview:self.shieldView];
    
}
-(void)selectDone
{
    NSInteger index= [self.pickerView selectedRowInComponent:0];
    [self setMyUserInfo:[self.m_aryHoroscope objectAtIndex:index] key:@"horoscope"];
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
}
//creat select marry list
-(void)creatPickerViewForMarry
{
    self.pickerView = [[ UIPickerView alloc] initWithFrame:CGRectMake(0, Screen_Height-180, Screen_Width, 180)];
    [self.pickerView setBackgroundColor:[UIColor whiteColor]];
    pickerView.delegate = self;
    pickerView.dataSource =  self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.tag=1;
    
    [self.view addSubview:pickerView];
    
    self.doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setFrame: CGRectMake(0, Screen_Height-180-40, Screen_Width, 40)];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:YCC_Green];
    [doneBtn addTarget:self action:@selector(selectDoneForMarry) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
    
    //    self.shieldView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-PARENT_Y(doneBtn))];
    //    [self.shieldView setBackgroundColor:[UIColor clearColor]];
    //    [self.view addSubview:self.shieldView];
    
}
-(void)selectDoneForMarry
{
    NSInteger index= [self.pickerView selectedRowInComponent:0];
    [self setMyUserInfo:[NSString stringWithFormat:@"%d",index] key:@"marital"];
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
}

#pragma mark ----------- event response -------------------- 
-(void)editNameBtnPressed
{
    EditTextInfoVC *vc=[[EditTextInfoVC alloc] init];
    vc.title=@"修改昵称";
    vc.modifiedKey=@"nickname";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)editAgeBtnPressed
{
    EditTextInfoVC *vc=[[EditTextInfoVC alloc] init];
    vc.title=@"修改年龄";
    vc.modifiedKey=@"age";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)editHoroscopeBtnPressed
{
    [self creatPickerView];
}
-(void)sexBtnPressed:(NSString*)sexTag
{
    [self setMyUserInfo:sexTag key:@"sex"];
}
-(void)editMobileBtnPressed
{
    EditTextInfoVC *vc=[[EditTextInfoVC alloc] init];
    vc.title=@"绑定手机";
    vc.modifiedKey=@"phone";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)editMySignBtnPressed
{
    EditTextInfoVC *vc=[[EditTextInfoVC alloc] init];
    vc.title=@"个性签名";
    vc.modifiedKey=@"resume";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)editAreaBtnPressed
{
    EditTextInfoVC *vc=[[EditTextInfoVC alloc] init];
    vc.title=@"常居住地";
    vc.modifiedKey=@"area";
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)logoutBtnPressed:(id)sender
{
    [MobClick profileSignOff];
    [MyFounctions removeUserInfo];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appdelegate.m_homeVC showWelcomeVC];
    appdelegate.m_homeVC.isLogged=NO;
}
-(void)setMyUserInfo:(NSString*)content key:(NSString*)key
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"info.user.put",[[MyFounctions getUserInfo] objectForKey:@"account"],content] forKeys:@[@"method",@"account",key]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self updateData];
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
