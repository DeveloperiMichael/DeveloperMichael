//
//  StringUtil.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/4.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 字符串 “类型”   会满足对应的条件
 */
typedef NS_ENUM(NSInteger, CommonStringType) {
    /**
     *  手机号
     */
    StringPhoneType,
    /**
     *  邮箱
     */
    StringEmailType,
    /**
     *全数字
     */
    StringNumberType,
    /**
     *全小写字母
     */
    StringMinusculeType,
    /**
     *  全大写字母
     */
    StringMajusculeType,
    /**
     *  身份证
     */
    StringIDCardType,
    /**
     *  含有中文字符
     */
    HasChineseStringType,
    /**
     *  全中文字符
     */
    ChineseStringType,
    /**
     *  只能是汉字和字母
     */
    ChineseAndLetterType,
    /**
     *  只能是数字和字母
     */
    LetterAndNumberType,
    /**
     *  只能是数字和汉字
     */
    ChineseAndNumberType,
    /**
     *  只能是数字、汉字和字母
     */
    ChineseAndNumberAndLetterType
};




@interface StringUtil : NSObject

/** 判断字符串是否为空 */
+ (BOOL)isBlankString:(NSString*)string;

/** 返回安全的字符串，不会返回nil，至少返回空字符串 */
+ (NSString*)safeString:(NSString*)string;

/** 返回字符串的MD5加密结果 */
+ (NSString*)MD5:(NSString*)string;

/** 判断字符串是否含有特殊字符 */
+ (BOOL)hasSpecailCharacter:(NSString*)string;

/** 过滤指定字符串   里面的指定字符根据自己的需要添加 过滤特殊字符 */
+ (NSString *)removeSpecialCharacter:(NSString *)string;

/** 将汉字首字母转成拼音个 */
+ (NSString *)transformChineseToPinyin:(NSString *)string;

/** 检查字符串 */
+ (BOOL)isStringType:(CommonStringType)stringType checkString:(NSString *)string;

/** 字符串显示需要的高度 */
+ (CGFloat)heightForText:(NSString*)text textWidth:(CGFloat)textWidth font:(CGFloat)font;

/** 字符串显示需要的宽度 */
+ (CGFloat)widthForText:(NSString*)text textHeight:(CGFloat)textHeight font:(CGFloat)font;

/** 根据屏幕适配字体大小 */
+(CGFloat)GetFontSizeByScreenWidth:(CGFloat)FontSize;


@end
