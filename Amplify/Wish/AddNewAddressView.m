//
//  AddNewAddressView.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "AddNewAddressView.h"
#import "AddNewAddressModel.h"
#import "CacheAddressModel.h"
#import "WishAndComModel.h"

@interface AddNewAddressView (){
    AddNewAddressModel * addNewAddressModel;
    
    
    NSArray * titlesArr;
    
    //填入的数值
    NSMutableArray * infoArray;
    
    //addressInfoView原始的坐标
    CGPoint  addressInfoViewPoint;
    
    
    //当前选中的省
    Province * currentSelectProvince;
    //当前选中的市
    City * currentSelectCity;
    //当前选中的区
    Area * currentSelectArea;
    
    
    NSString * wishId ;
    NSString * comId;
    NSString * addressId;
}

@end

@implementation AddNewAddressView

-(void)initBaseView:(BaseView*)baseView{
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT);
    
    
    if (self.baseViewModel) {
        if ([self.baseViewModel isKindOfClass:[CacheAddressModel class]]) {
            CacheAddressModel * currentAddNewAddressModel = (CacheAddressModel*)self.baseViewModel;
            
            self.personTxt.text = currentAddNewAddressModel.name;
            self.phoneTxt.text = currentAddNewAddressModel.phone;
            self.jieTxt.text = currentAddNewAddressModel.addressInfo;
            self.youTxt.text = currentAddNewAddressModel.addressNum;
            self.shengLab.text = currentAddNewAddressModel.provincesStr;
            wishId = currentAddNewAddressModel.wishId;
            comId = currentAddNewAddressModel.comId;
        }else{
            WishAndComModel * wishAndComModel = (WishAndComModel*)self.baseViewModel;
            wishId = wishAndComModel.wishId;
            comId = wishAndComModel.comId;
            addressId = wishAndComModel.addressId;
        }
        
    }
    
    
    titlesArr = [[NSArray alloc] initWithObjects:@"收件人",@"手机号",@"省／市",@"城市",@"县／区",@"街道地址",@"邮政编码", nil];
    infoArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    
    
    //从文件读取地址字典
    NSString *mainBundleDirectory=[[NSBundle mainBundle] bundlePath];
    
    NSString *path=[mainBundleDirectory stringByAppendingPathComponent:@"Address.json"];
    
    NSURL *url=[NSURL fileURLWithPath:path];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    //    NSString* aStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //
    //
    //    NSData *da= [responseString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSArray * allProvinces = jsonObject;
    
    
    
    addNewAddressModel = [[AddNewAddressModel alloc] init];
//    addNewAddressModel.provincess = [Province mj_objectArrayWithKeyValuesArray:jsonObject];
    for (NSDictionary* dic in allProvinces) {
        Province * province = [[Province alloc] init];
        province.name = [dic objectForKey:@"name"];//省
        province.regionId = [dic objectForKey:@"regionId"];
        province.regionCode = [dic objectForKey:@"regionCode"];
        
        
        NSArray * cityArr = [dic objectForKey:@"children"];
        for (NSDictionary * cityDic in cityArr) {
            City * city = [[City alloc] init];
            city.name = [cityDic objectForKey:@"name"];
            city.regionId = [cityDic objectForKey:@"regionId"];
            city.regionCode = [cityDic objectForKey:@"regionCode"];
            
            NSArray * areaArr = [cityDic objectForKey:@"children"];
            for (NSDictionary * areaDic in areaArr) {
                Area * area = [[Area alloc] init];
                area.name = [areaDic objectForKey:@"name"];
                area.regionId = [areaDic objectForKey:@"regionId"];
                area.regionCode = [areaDic objectForKey:@"regionCode"];
                [city.children addObject:area];//区
            }
            
            [province.children addObject:city];
        }
        
        
        [addNewAddressModel.provincess addObject:province];// 省
    }
    
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleTap];
    
    currentSelectProvince = [[Province alloc] init];
    currentSelectProvince = [addNewAddressModel.provincess objectAtIndex:0];//默认值
    currentSelectCity = [[City alloc] init];
    currentSelectCity = [currentSelectProvince.children objectAtIndex:0];//默认值
    currentSelectArea = [[Area alloc] init];
    currentSelectArea = [currentSelectCity.children objectAtIndex:0];//默认值
    
    self.pickerViewBg.hidden = YES;
    
    addressInfoViewPoint = CGPointMake(self.addressInfoView.frame.origin.x, self.addressInfoView.frame.origin.y);
}

- (IBAction)viewCloseClick:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)okBtnClick:(id)sender {
    
    if ([self.personTxt.text isEqualToString:@""]) {
        [TipManager showTipsWithInforStr:@"收件人不能为空" withAfter:1.0];
        return;
    }
    
    if ([self.phoneTxt.text isEqualToString:@""]) {
        [TipManager showTipsWithInforStr:@"收件人电话不能为空" withAfter:1.0];
        return;
    }
    
    if ([self.shengLab.text isEqualToString:@""]) {
        [TipManager showTipsWithInforStr:@"省市区不能为空" withAfter:1.0];
        return;
    }
    
   
    
    if ([self.jieTxt.text isEqualToString:@""]) {
        [TipManager showTipsWithInforStr:@"详细地址不能为空" withAfter:1.0];
        return;
    }
    
    if ([self.youTxt.text isEqualToString:@""]) {
        [TipManager showTipsWithInforStr:@"邮编不能为空" withAfter:1.0];
        return;
    }
    
    
    CacheAddressModel * cacheModel = [[CacheAddressModel alloc] init];
    cacheModel.phone = self.phoneTxt.text;
    cacheModel.name = self.personTxt.text;
    cacheModel.provincesStr = self.shengLab.text;
    cacheModel.addressInfo = self.jieTxt.text;
    cacheModel.addressNum = self.youTxt.text;
    cacheModel.regionCode = currentSelectArea.regionCode;
    cacheModel.wishId = wishId;
    cacheModel.comId = comId;
    cacheModel.addressId =addressId;
    cacheModel.address = self.jieTxt.text;
    
    [self baseViewClickToController:@"wishAddressViewOkBtnClick" withObject:cacheModel];
    [self removeFromSuperview];
    
    
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender

{
    
    [self resetKeyboard];
    
    
    self.pickerViewBg.hidden = YES;
}

-(void)resetKeyboard{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    
    
    [self resignTextFildResponder];
    
//    [UIView beginAnimations:@"ResizeForpickerScroller" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    CGRect rect1 = CGRectMake(addressInfoViewPoint.x, addressInfoViewPoint.y, self.frame.size.width, self.frame.size.height);
//    self.addressInfoView.frame = rect1;
//    [UIView commitAnimations];
    
    
}

-(void)resignTextFildResponder{
    [self.phoneTxt resignFirstResponder];
    
    [self.personTxt resignFirstResponder];
    
    [self.jieTxt resignFirstResponder];
    
    [self.youTxt resignFirstResponder];
}


//滚动选项的滑动
-(void)pickerScroller:(UIView*)targeView{
    
    
    int textFieldY = targeView.superview.superview.frame.origin.y+targeView.superview.frame.origin.y+targeView.frame.origin.y;
    int offset = textFieldY-(MAIN_SCREEN_HIGHT-300-targeView.frame.size.height-50);//键盘高度216 (216+)
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForpickerScroller" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.frame = rect;
        
        
        self.pickerViewBg.frame = CGRectMake(0, MAIN_SCREEN_HIGHT-300, MAIN_SCREEN_HIGHT, 300);
        
//        [self.pickerViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.superview.mas_bottom).with.offset(0);
//        }];
        
        self.pickerViewBgBot.constant = 0;
    }
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    
    [self resetKeyboard];
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    int textFieldY = textField.superview.superview.frame.origin.y+textField.superview.frame.origin.y+textField.frame.origin.y;
    int offset = textFieldY-(MAIN_SCREEN_HIGHT-216-textField.frame.size.height-50);//键盘高度216 (216+)
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.frame = rect;
    }
    [UIView commitAnimations];
    
    self.pickerViewBg.hidden = YES;
}


- (IBAction)closePickClick:(id)sender {
    self.pickerViewBg.hidden = YES;
    [self resetKeyboard];
}

- (IBAction)finishBtnClick:(id)sender {
    self.shengLab.text = @"";
    
    
    self.shengLab.text = [NSString stringWithFormat:@"%@%@%@",currentSelectProvince.name,currentSelectCity.name,currentSelectArea.name];
    self.pickerViewBg.hidden = YES;
    [self resetKeyboard];
}

- (IBAction)shenBtnClick:(UIButton *)sender {
    
    self.pickerViewBg.hidden = NO;
    [self.pickerView reloadAllComponents];
    [self resetKeyboard];
//    [self pickerScroller:sender.superview];
}


//重设置数据
-(void)reSetAddressLabInfo{
    
    self.shengLab.text = currentSelectProvince.name;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component ==0) {
        return addNewAddressModel.provincess.count;
    }else if (component ==1) {
        return currentSelectProvince.children.count;
    }else {
        return currentSelectCity.children.count;
    }
}


// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component ==0) {
        currentSelectProvince = [addNewAddressModel.provincess objectAtIndex:row];
        
        currentSelectCity = [currentSelectProvince.children objectAtIndex:0];
        
        currentSelectArea = [currentSelectCity.children objectAtIndex:0];
        
        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:1];
        [pickerView selectedRowInComponent:2];
    }else if (component ==1) {
        currentSelectCity = [currentSelectProvince.children objectAtIndex:row];
        currentSelectArea = [currentSelectCity.children objectAtIndex:0];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSString * componentStr = @"";
    
    
    if (component ==0) {
        Province * prov = [addNewAddressModel.provincess objectAtIndex:row];
        componentStr = prov.name;
    }else if (component ==1) {
        City * cy = [currentSelectProvince.children objectAtIndex:row];
        componentStr = cy.name;
    }else {
        Area * ar = [currentSelectCity.children objectAtIndex:row];
        componentStr = ar.name;
    }
    
    return componentStr;
}


@end
