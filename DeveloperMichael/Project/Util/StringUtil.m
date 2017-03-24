//
//  StringUtil.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/4.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "StringUtil.h"
#import "pinyin.h"
#import <CommonCrypto/CommonDigest.h>



@implementation StringUtil

+ (BOOL)isBlankString:(NSString*)string {
    if (string.length>0) {
        return NO;
    }
    return YES;
}

+ (NSString*)safeString:(NSString*)string {
    if (string==nil||[string isEqualToString:@"(NULL)"]||[string isEqualToString:@"(null)"]||[string isEqualToString:@"null"]||[string isEqualToString:@"NULL"]) {
        return @"";
    }
    return string;
}

+ (BOOL)hasSpecailCharacter:(NSString*)string {
    NSRange urgentRange = [string rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€ "]];
    if (urgentRange.location != NSNotFound) {
        return YES;
    }
    return NO;
}

+ (NSString *)removeSpecialCharacter:(NSString *)string{
    NSRange urgentRange = [string rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€ "]];
    if (urgentRange.location != NSNotFound) {
        return [string stringByReplacingCharactersInRange:urgentRange withString:@""];
    }
    return string;
}

+ (NSString *)transformChineseToPinyin:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return string;
    }
    
    NSString *pinYinResult=[NSString string];
    for(int j=0;j<string.length;j++){
        NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([string characterAtIndex:j])]uppercaseString];
        
        pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
    }
    
    return pinYinResult;
}

+ (BOOL)isStringType:(CommonStringType)stringType checkString:(NSString *)string {
    NSString *validString = [self stringForId:string];
    switch (stringType) {
        case StringPhoneType:{
            NSString *phoneRegex = @"(\\+\\d+)?1[34578]\\d{9}$";
            NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
            return [phoneTest evaluateWithObject:validString];
        }
            break;
        case StringEmailType:{
            NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            return [emailTest evaluateWithObject:validString];
        }
            break;
        case StringNumberType:{
            NSString *emailRegex = @"^[0-9]*$";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            return [emailTest evaluateWithObject:validString];
        }
            break;
        case StringMinusculeType:{
            NSString *emailRegex = @"^[a-z]+$";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            return [emailTest evaluateWithObject:validString];
        }
            break;
        case StringMajusculeType:{
            NSString *emailRegex = @"^[A-Z]+$";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            return [emailTest evaluateWithObject:validString];
        }
            break;
        case StringIDCardType:{
            BOOL flag;
            if (string.length <= 0) {
                flag = NO;
                return flag;
            }
            NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
            NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
            return [identityCardPredicate evaluateWithObject:validString];
        }
            break;
        case HasChineseStringType:{
            for(int i = 0; i < [validString length]; i++){
                int a = [string characterAtIndex:i];
                if( a > 0x4e00 && a < 0x9fff)
                    return YES;
            }
            return NO;
        }
            break;
        case ChineseStringType:{
            for(int i = 0; i < [validString length]; i++){
                int a = [string characterAtIndex:i];
                if (a < 0x4e00 || a > 0x9fff) {
                    return NO;
                }
            }
            return YES;
        }
            break;
        case ChineseAndLetterType:{
            NSString *regex = @"^[a-zA-Z\u4e00-\u9fa5]+$";
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
            return [predicate evaluateWithObject:validString];
        }
            break;
        case LetterAndNumberType:{
            NSString *regex = @"^[0-9a-zA-Z]+$";
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
            return [predicate evaluateWithObject:validString];
        }
            break;
        case ChineseAndNumberType:{
            
            NSString *regex = @"[0-9\u4e00-\u9fa5]*";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
            return [pred evaluateWithObject:validString];
        }
            break;
        case ChineseAndNumberAndLetterType:{
            
            NSString *regex = @"[a-zA-Z0-9\u4e00-\u9fa5]*";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
            return [pred evaluateWithObject:validString];
        }
            break;
        default:
            return NO;
            break;
    }

}

+ (NSString *)stringForId:(id)object{
    NSString *str = (NSString *)object;
    
    if (str == nil) return @"";
    if (str == NULL) return @"";
    if ([str isKindOfClass:[NSNull class]]) return @"";
    
    str = [NSString stringWithFormat:@"%@",str];
    return str;
}

+ (NSString *)MD5:(NSString *)string {
    if(self == nil || [string length] == 0)
        return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}

+ (CGFloat)heightForText:(NSString*)text textWidth:(CGFloat)textWidth font:(CGFloat)font {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.height;
}

+ (CGFloat)widthForText:(NSString*)text textHeight:(CGFloat)textHeight font:(CGFloat)font {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, textHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}

+(CGFloat)GetFontSizeByScreenWidth:(CGFloat)FontSize{
    CGFloat tmpFontSize=FontSize;
    CGFloat DisSize=1;//每一阶梯次增加多少
    CGFloat ScreenWidth=[[UIScreen mainScreen]bounds].size.width;
    if(ScreenWidth==320){//5系列
        tmpFontSize=tmpFontSize-DisSize;
    }
    if(ScreenWidth==375){//6系列
        tmpFontSize=tmpFontSize;
    }
    
    if(ScreenWidth==414){//Plus系列
        tmpFontSize=tmpFontSize+DisSize*2;
    }
    return tmpFontSize;
    
}




@end
