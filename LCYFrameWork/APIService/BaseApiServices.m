//
//  BaseApiServices.m
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/5.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import "BaseApiServices.h"
#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"
#import <CommonCrypto/CommonCrypto.h>
#import "AFNetworkReachabilityManager.h"
@implementation BaseApiServices

#pragma mark Get request
+ (void)fetHTTPGetWithUrl:(NSString *)url params:(NSDictionary *)params requestTpye:(LCYHTTPTYPE)requestType successful:(void (^)(id))successful failure:(void (^)(NSError *))failure
{
    // 获取完整存储路径名称(网址作为这个文件名)
    NSString *path = [BaseApiServices getPathWithUrl:url];
    // 判断有没有网络
    BOOL statusNet = [self getNetworkStatus];
    AFNetworkReachabilityManager *networkManager = [AFNetworkReachabilityManager manager];
    NSString *url_string = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    // 支持接口类型
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", nil];
    // 判断网络数据形式
    switch (requestType) {
        case LCYHttp:
            session.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case LCYXml:
            session.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case LCYJson:
            session.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        default:
            break;
    }
    if (statusNet) {
        [session GET:url_string parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [networkManager stopMonitoring];
            if (requestType == LCYHttp) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                successful(result);
            }else{
                successful(responseObject);
            }
            // 写入本地
            [NSKeyedArchiver archiveRootObject:responseObject toFile:path];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            
        }];
    }
    
}

#pragma mark Post request
+ (void)fetHTTPPostWithUrl:(NSString *)url params:(NSDictionary *)params successful:(void (^)(id))successful failure:(void (^)(NSError *))failure
{
    BOOL statusNet = [self getNetworkStatus];
    AFNetworkReachabilityManager *networkManager = [AFNetworkReachabilityManager manager];
    NSString *url_string = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    // 支持接口类型
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", nil];
    if (statusNet) {
        [sessionManager POST:url_string parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successful(responseObject);
            [networkManager stopMonitoring];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

+ (NSString *)getPathWithUrl:(NSString *)url
{
    // 1 获取cache文件夹路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    cachePath = [cachePath stringByAppendingPathComponent:@"LCYNetHandleFolder"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 如果没有这个文件 就创建
    if (![fileManager fileExistsAtPath:cachePath]) {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    // MD5加密转换网址成一字符串
    NSString *urlFile = [NSString stringWithFormat:@"%@",[BaseApiServices cachedFileNameForkey:url]];
    cachePath = [cachePath stringByAppendingPathComponent:urlFile];
    return cachePath;
}

#pragma mark MD5
+ (NSString *)cachedFileNameForkey:(NSString *)key{
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *fileName = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return fileName;
}

+ (BOOL)getNetworkStatus
{
    Reachability *reMan = [Reachability reachabilityForInternetConnection];
    return reMan.currentReachabilityStatus;
}

@end
