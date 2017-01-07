//
//  MyInfoVC.m
//  yocheche
//
//  Created by carcool on 8/11/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyInfoVC.h"
#import "MyInfoCell.h"
#import <QiniuSDK.h>
#import "SelectSchoolVC.h"
#import "EditBasicInfoVC.h"
@interface MyInfoVC ()

@end

@implementation MyInfoVC
@synthesize picker;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"个人资料";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"保存"];
    [self.rightNaviBtn addTarget:self action:@selector(saveAndPopSelf) forControlEvents:UIControlEventTouchUpInside];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
    [self updateData];
}
-(void)saveAndPopSelf
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"info.user.put",[[MyFounctions getUserInfo] objectForKey:@"account"],[self.data objectForKey:@"nickname"],[self.data objectForKey:@"sex"],[self.data objectForKey:@"age"],[self.data objectForKey:@"marital"],[self.data objectForKey:@"collegecode"],[self.data objectForKey:@"company"],[self.data objectForKey:@"mycar"]] forKeys:@[@"method",@"account",@"nickname",@"sex",@"age",@"marital",@"collegecode",@"company",@"mycar"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self popSelfViewContriller];
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



-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"info.user.get",[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"method",@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=[NSMutableDictionary dictionaryWithDictionary:req.m_data];
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
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyInfoCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MyInfoCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
    }
    cell.data=self.data;
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
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

#pragma mark -------- event response
-(void)uploadAvatar
{
    [self showPickVC];
}
-(void)showPickVC
{
    self.picker=nil;
    self.picker = [[UIImagePickerController alloc]init];
    picker.view.backgroundColor = [UIColor orangeColor];
    UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.sourceType = sourcheType;
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    [self presentViewController:picker animated:YES completion:^{
        [self stopLoadingWithBG];
    }];
    
}
-(void)showSelectSchoolVC
{
    SelectSchoolVC *vc=[[SelectSchoolVC alloc] init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)showEditBasicInfoVC
{
    EditBasicInfoVC *vc=[[EditBasicInfoVC alloc] init];
    vc.delegate=self;
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
