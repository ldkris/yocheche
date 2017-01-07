//
//  FlitrateCoachVC.h
//  yocheche
//
//  Created by carcool on 7/27/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "SchoolListVC.h"
@interface FlitrateCoachVC : YCCViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,retain)UIPickerView* pickerView;
@property(nonatomic,retain)UIButton *doneBtn;
@property(nonatomic,retain)UIView *shieldView;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,retain)NSString *m_currentAddress;
@property(nonatomic,retain)NSMutableArray *m_arySort;
@property(nonatomic,retain)NSMutableArray *m_aryLicenseType;
@property(nonatomic,retain)NSMutableArray *m_currentSelectArray;
@property(nonatomic,retain)NSString *currentSelectKey;
@property(nonatomic,assign)SchoolListVC *delegate;
@property(nonatomic,retain)NSMutableDictionary *m_filtrateData;
-(void)creatPickerView:(NSInteger)index;
-(void)showFixLocationVC;
-(void)selectDone;
@end
