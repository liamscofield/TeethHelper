//
//  AccountManager.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject

+(BOOL)isLogin;
+(void)setLogin:(BOOL)login;

@end