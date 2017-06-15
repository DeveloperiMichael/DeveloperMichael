//
//  DateUtil.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/24.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+ (NSDateFormatter *)sharedDateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    return dateFormatter;
}

+ (NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [DateUtil sharedDateFormatter];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter dateFromString:dateString];
}

+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [DateUtil sharedDateFormatter];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)stringFromTimestamp:(NSTimeInterval)timeInterval withDateFormat:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [DateUtil sharedDateFormatter];
    [dateFormatter setDateFormat:formatString];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [dateFormatter stringFromDate:date];
}

+ (NSDateComponents *)componentFromDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setLocale:[NSLocale currentLocale]];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    return component;
}

+ (NSDate *)dateFromComponents:(NSDateComponents *)comps {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setLocale:[NSLocale currentLocale]];
    NSDate *date = [calendar dateFromComponents:comps];
    return date;
}

+ (NSInteger)numberOfDaysInMonthWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitYear inUnit:NSCalendarUnitEra forDate:date];
    NSUInteger numberOfDaysInMonth = range.length;
    return (NSInteger)numberOfDaysInMonth;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六",nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}



@end
