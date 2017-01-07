//
//  StudyDemandVC.h
//  yocheche
//
//  Created by carcool on 3/16/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import <BaiduMapAPI/BMapKit.h>
@class ApplyStudyVC;
@interface StudyDemandVC : YCCViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_searcher;
}
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,retain)NSString *m_currentAddress;
@property(nonatomic,retain)NSString *coachID;
@property(nonatomic,retain)NSDictionary *showData;
@property(nonatomic,retain)IBOutlet UILabel *labelSignNum;
@property(nonatomic,retain)IBOutlet UILabel *labelDiscount;
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,assign)IBOutlet UIView *contentBG;
@property(nonatomic,assign)IBOutlet UILabel *labelType;
@property(nonatomic,assign)IBOutlet UILabel *labelAddress;
@property(nonatomic,assign)IBOutlet UILabel *labelPrice;
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UIView *lineView1;
//profile view
@property(nonatomic,assign)IBOutlet UIView *contentBG2;
@property(nonatomic,assign)IBOutlet UIView *lineView3;
@property(nonatomic,assign)IBOutlet UILabel *labelNote;
@property(nonatomic,assign)IBOutlet UITextField *textfieldName;
@property(nonatomic,assign)IBOutlet UITextField *textfieldMobile;
@property(nonatomic,assign)NSInteger inputProfileNeed;
@property(nonatomic,assign)NSInteger licenseType;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_currentSelectArray;
@property(nonatomic,retain)UIPickerView* pickerView;
@property(nonatomic,retain)UIButton *doneBtn;
@end
