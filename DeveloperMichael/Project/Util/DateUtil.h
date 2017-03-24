//
//  DateUtil.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/24.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

/**
 *  @brief 获取单例的NSDateFormatter实例，降低程序的开销
 *
 *  @return NSDateFormatter实例
 */
+ (NSDateFormatter *)sharedDateFormatter;

/**
 *  @brief 将String类型的date，按照指定的format，转换成Date类型
 *
 *  @param dateString   String类型的date
 *  @param formatString 指定的format
 *
 *  @return NSDate实例
 */
+ (NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)formatString;

/**
 *  @brief 将Date按照指定的format，转换成响应的String
 *
 *  @param date         需要转换的Date实例
 *  @param formatString 指定的format
 *
 *  @return 转换得到的String
 */
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)formatString;

/**
 *
 *  @brief 将时间戳（timeInterval）按照指定的format，转换成相应的String
 *
 *  @param timeInterval 时间戳
 *  @param formatString 时间显示样式 （eg: yyyy-MM-dd HH:mm:ss）
 *
 *  @return 时间字符串
 */
+ (NSString *)stringFromTimestamp:(NSTimeInterval)timeInterval withDateFormat:(NSString *)formatString;

/**
 *  @brief 将Date类型转换为DateComponents类型，以获取年、月、日、时、分、秒的数据
 *
 *  @param date 需要转化的Date实体
 *
 *  @return 转化后的DateComponents实体
 */
+ (NSDateComponents *)componentFromDate:(NSDate *)date;

/**
 *  @brief 将DateComponents转化为Date类型
 *
 *  @param comps DateComponents类型的实体
 *
 *  @return 转化后得到的Date类型实体
 */
+ (NSDate *)dateFromComponents:(NSDateComponents *)comps;


@end
