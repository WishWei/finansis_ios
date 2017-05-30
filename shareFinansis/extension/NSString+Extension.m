//
//  NSString+Extension.m
//  finanssis
//
//  Created by 魏希 on 16/7/31.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (NSString*)trim{
    NSString *str=[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return str;
}
@end
