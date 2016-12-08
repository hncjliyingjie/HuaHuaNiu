//
//  NSString+Category.h
//  iOSCodeProject
//
//  Created by zym on 14-7-18.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//


/**
 *  字符格式操作帮助类，例：验证手机号，判断输入框内容是否合理等。
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TTIFormatValidate : NSObject


/**
*  验证手机号码
*
*  @param mobilePhone 手机号
*
*  @return 布尔值
*/
+ (BOOL)isValidateMobilePhone:(NSString *)mobilePhone;

/**
 *  判断输入的内容是否合理
 *
 *  @param textFiled 输入框对象
 *
 *  @return 布尔值
 */
+ (BOOL)isValidateMobilePhoneTextFiled:(UITextField *)textFiled;

/**
 *  验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return 布尔值
 */
+ (BOOL)isValidateEmail:(NSString *)email;

//  外加

+(BOOL)isValidateUserName:(NSString *)userName;

+(BOOL)isValidatePassword:(NSString *)password;
//


/**
 *  验证邮件输入框是否合理
 *
 *  @param textFiled 邮件输入框对象
 *
 *  @return 布尔值
 */
+ (BOOL)isValidateEmailTextFiled:(UITextField *)textFiled;

/**
 *  验证是否为纯数字
 *
 *  @param number 字符串
 *
 *  @return 布尔值
 */
+ (BOOL)isValidateNumber:(NSString *)number;

/**
 *  验证手机号码是否符合格式
 *
 *  @param number 手机号字符串
 *
 *  @return 校验结果
 */
+ (BOOL)isValidateStrictNumber:(NSString *)number;

/**
 *  验证是否为电话号码，规则为123456789- 的字符串
 *
 *  @param telephone 电话号码
 *
 *  @return 布尔值
 */
+ (BOOL)isValidateTelephone:(NSString *)telephone;

/**
 *	判断输入框中数据是否合理，默认调整为去除前后换行符，长度不超过16
 *
 *	@param	textFiled	待判断的输入框
 *
 *	@return	布尔值
 */
+ (BOOL)isTextFiledValidate:(UITextField *)textFiled;

/**
 *	在某个区域内是否合理，默认为0-16
 *
 *	@param	textFiled	待验证的输入框
 *	@param	min	最小长度
 *	@param	max	最大长度
 *
 *	@return	布尔值
 */
+ (BOOL)isTextFiledValidate:(UITextField *)textFiled minLenght:(int)min maxLenght:(int)max;


/**
 *  验证身份证号码
 *
 *  @param value 待验证的身份证号码
 *
 *  @return 布尔值
 */
+ (BOOL)validateIDCardNumber:(NSString *)value;

/**
 *  检验昵称
 *
 *  @param nickname 昵称
 *
 *  @return 布尔值
 */
+ (BOOL) validateNickname:(NSString *)nickname;


/**
 *  检验密码
 *
 *  @param passWord 密码
 *
 *  @return 合法性
 */
+ (BOOL) validatePassword:(NSString *)passWord;


/**
 *  检验是否只包含数字（0-9）和"."符号
 *
 *  @param floatString 待校验的字符串
 *
 *  @return 校验结果
 */
+ (BOOL) validatefloatString:(NSString *)floatString;

+ (BOOL) validatefloatString2:(NSString *)floatString;

@end
