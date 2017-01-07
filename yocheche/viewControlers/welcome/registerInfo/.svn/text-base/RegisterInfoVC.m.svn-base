//
//  RegisterInfoVC.m
//  yocheche
//
//  Created by carcool on 9/8/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RegisterInfoVC.h"
#import <QiniuSDK.h>
@interface RegisterInfoVC ()

@end

@implementation RegisterInfoVC
@synthesize picker;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"注册";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    
    self.haveUploadAvatar=NO;
    [self.btn setColor:YCC_Green];
    self.textfieldName.delegate=self;
    self.sexType=2;
    if (self.sexType==1)
    {
        [self.imgBoy setImage:[UIImage imageNamed:@"selectScheme_on"]];
        [self.imgGirl setImage:[UIImage imageNamed:@"selectScheme_off"]];
    }
    else
    {
        [self.imgBoy setImage:[UIImage imageNamed:@"selectScheme_off"]];
        [self.imgGirl setImage:[UIImage imageNamed:@"selectScheme_on"]];
    }
    [self.actionSheetBG setBackgroundColor:[UIColor clearColor]];
    
    self.textfieldName.delegate=self;
    self.textfieldName.returnKeyType=UIReturnKeyDone;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------------- textfield delegate ---------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    float textfiled_y=[textField convertRect:self.view.frame toView:nil].origin.y;
    if (textfiled_y>Screen_Height-KEYBOARD_HEIGHT)
    {
        float _y=Screen_Height-KEYBOARD_HEIGHT-textfiled_y;
        [self.view setFrame:CGRectMake(PARENT_X(self.view),_y , PARENT_WIDTH(self.view)+_y, PARENT_HEIGHT(self.view))];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view setFrame:CGRectMake(PARENT_X(self.view),0 , PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
    [textField resignFirstResponder];
    return YES;
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
            [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[req.m_data objectForKey:@"userpic"]]];
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
                                  self.haveUploadAvatar=YES;
                                  [self showMessage:@"上传头像成功！"];
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

#pragma mark --------------- event response ----------------
-(IBAction)sexBtnPressed:(id)sender
{
    UIButton *btnSex=(UIButton*)sender;
    self.sexType=btnSex.tag;
    if (self.sexType==1)
    {
        [self.imgBoy setImage:[UIImage imageNamed:@"selectScheme_on"]];
        [self.imgGirl setImage:[UIImage imageNamed:@"selectScheme_off"]];
    }
    else
    {
        [self.imgBoy setImage:[UIImage imageNamed:@"selectScheme_off"]];
        [self.imgGirl setImage:[UIImage imageNamed:@"selectScheme_on"]];
    }
}
-(IBAction)setAvatarBtnPressed:(id)sender
{
    [self addBlackBGView];
    [self.actionSheetBG setFrame:CGRectMake(0, Screen_Height-120, Screen_Width, 120)];
    [self.view addSubview:self.actionSheetBG];
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
-(IBAction)doneBtnPressed:(id)sender
{
    if (self.haveUploadAvatar==NO)
    {
        [self showMessage:@"请上传头像"];
        return;
    }
    if ([self.textfieldName.text isEqualToString:@""])
    {
        [self showMessage:@"请设置昵称"];
        return;
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"info.user.put",[[MyFounctions getUserInfo] objectForKey:@"account"],self.textfieldName.text,[NSString stringWithFormat:@"%d",self.sexType]] forKeys:@[@"method",@"account",@"nickname",@"sex"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.delegate.delegate dismissViewControllerAnimated:YES completion:^{
                
            }];
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
