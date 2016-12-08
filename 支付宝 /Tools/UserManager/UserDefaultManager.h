//
//  UserDefaultManager.h
//  VLv
//
//  Created by lanouhn on 16/7/12.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultManager : NSObject

+ (UserDefaultManager *)shareUserDefaultManager;

- (void)saveUserName:(NSString *)userName password:(NSString *)password;
//取账号
- (NSString *)getUserNameStr;
//取密码
- (NSString *)getPasswordStr;

//存储 UID
- (void)saveUidStr:(NSString *)uid;
//取出 UID
- (NSString *)getUid;
//是否第一次启动
- (BOOL)getFirstRun;

@end
