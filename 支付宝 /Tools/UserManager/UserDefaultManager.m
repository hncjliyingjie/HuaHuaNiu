//
//  UserDefaultManager.m
//  VLv
//
//  Created by lanouhn on 16/7/12.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "UserDefaultManager.h"

@implementation UserDefaultManager


+ (UserDefaultManager *)shareUserDefaultManager {
    static UserDefaultManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserDefaultManager alloc] init];
    });
    return manager;
}

- (void)saveUserName:(NSString *)userName password:(NSString *)password {
    [[NSUserDefaults standardUserDefaults] setValue:userName forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password"];
    //及时保存
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//取账号
- (NSString *)getUserNameStr {
    NSString *userNmae = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    return userNmae;
    
}
//取密码
- (NSString *)getPasswordStr {
    NSString *userNmae = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    return userNmae;
}

//存储 UID
- (void)saveUidStr:(NSString *)uid {
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"Useid"];
    //及时保存
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//取出 UID
- (NSString *)getUid {
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Useid"];
    if ([uid isEqualToString:@""]) {
        //如果没有取到Useid,就弹出警示框
        [self showAlertView];
    }
    return uid;
}

//是否第一次启动
- (BOOL)getFirstRun {
    BOOL isFitst = [[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"];
    if (isFitst) {
        return NO;
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
}

//展示提醒框
- (void)showAlertView {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录状态" message:@"您未登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"朕去登陆", nil];
    [alertView show];
}


@end
