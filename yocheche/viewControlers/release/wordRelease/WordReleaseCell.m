//
//  WordReleaseCell.m
//  yocheche
//
//  Created by carcool on 1/19/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "WordReleaseCell.h"
#import "WordReleaseVC.h"
@implementation WordReleaseCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:YCC_GrayBG];
    self.textViewContent.delegate=self;
    self.textViewContent.returnKeyType=UIReturnKeyDone;
    self.textViewContent.tag=0;
    self.textViewTag.delegate=self;
    self.textViewTag.returnKeyType=UIReturnKeyDone;
    self.textViewTag.tag=1;
    self.m_aryCategoryTags=[NSMutableArray array];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self createCategoryTagsView];
}
-(void)createCategoryTagsView
{
    NSInteger i=0;
    while (i<self.m_aryCategoryTags.count)
    {
        UIButton *btnTag=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnTag setFrame:CGRectMake(15+(i%3)*(260/3.0+15), 245+i/3*40, 260.0/3.0, 30)];
        [btnTag setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnTag setBackgroundColor:[UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1]];
        [btnTag.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        btnTag.tag=i;
        [btnTag setTitle:[NSString stringWithFormat:@"#%@",[[self.m_aryCategoryTags objectAtIndex:i] objectForKey:@"name"]] forState:UIControlStateNormal];
        [btnTag addTarget:self action:@selector(categoryTagBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnTag];
        NSLog(@"btnTag :%@",btnTag);
        i++;
    }
}
#pragma mark ---------------  textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.tag==0)
    {
        self.labelContentDefault.hidden=YES;
    }
    else
    {
        self.labelTagDefault.hidden=YES;
    }
    float textfiled_y=[textView convertRect:self.delegate.view.frame toView:nil].origin.y;
    if (textfiled_y+150>Screen_Height-KEYBOARD_HEIGHT)
    {
        float _y=Screen_Height-KEYBOARD_HEIGHT-textfiled_y-150;
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view),PARENT_Y(self.delegate.view)+_y , PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        
        //keyboard back reset view frame
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view),0, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
        
        if ([self.textViewContent.text isEqualToString:@""]||[self.textViewContent.text isEqualToString:@"#"])
        {
            self.labelContentDefault.hidden=NO;
            self.textViewContent.text=@"";
        }
        else
        {
            self.labelContentDefault.hidden=YES;
        }
        if ([self.textViewTag.text isEqualToString:@""]||[self.textViewTag.text isEqualToString:@"#"])
        {
            self.labelTagDefault.hidden=NO;
            self.textViewTag.text=@"";
        }
        else
        {
            self.labelTagDefault.hidden=YES;
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

#pragma mark -------- event response -----------
-(IBAction)contentBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)
    {
        if (![self.textViewContent isFirstResponder])
        {
            [self.textViewContent becomeFirstResponder];
            self.labelContentDefault.hidden=YES;
        }
        else
        {
            [self.textViewContent resignFirstResponder];
            if ([self.textViewContent.text isEqualToString:@""])
            {
                self.labelContentDefault.hidden=NO;
            }
            else
            {
                self.labelContentDefault.hidden=YES;
            }
        }
    }
    else
    {
        if (![self.textViewTag isFirstResponder])
        {
            [self.textViewTag becomeFirstResponder];
            self.labelTagDefault.hidden=YES;
            if ([self.textViewTag.text isEqualToString:@""])
            {
                self.textViewTag.text=@"#";
            }
        }
        else
        {
            [self.textViewTag resignFirstResponder];
            if ([self.textViewTag.text isEqualToString:@""])
            {
                self.labelTagDefault.hidden=NO;
            }
            else
            {
                self.labelTagDefault.hidden=YES;
            }
        }
    }
    
}
-(IBAction)categoryTagBtnPressed:(id)sender
{
    UIButton *btnTag=(UIButton*)sender;
    NSMutableString *tags=[NSMutableString stringWithString:self.textViewTag.text];
    [tags appendString:[NSString stringWithFormat:@" #%@",[[self.m_aryCategoryTags objectAtIndex:btnTag.tag] objectForKey:@"name"]]];
    self.textViewTag.text=tags;
    self.labelTagDefault.hidden=YES;
}
@end
