//
//  BaseApiServices.h
//  LCYFrameWork
//
//  Created by 李赐岩 on 16/3/5.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, LCYHTTPTYPE) {
    LCYHttp, // 返回data数据
    LCYXml, // 返回xml数据
    LCYJson // 返回JSON数据
};
@interface BaseApiServices : NSObject

/**
 * @biref GET数据请求
 * @params Url 参数类型 成功失败block
 */
+ (void)fetHTTPGetWithUrl:(NSString *)url
                   params:(NSDictionary *)params
                   requestTpye:(LCYHTTPTYPE)requestType
                  successful:(void(^)(id response))successful
                  failure:(void(^)(NSError *error))failure;
/**
 * @biref Post数据请求
 * @params Url 参数类型 成功失败block
 */
+ (void)fetHTTPPostWithUrl:(NSString *)url
                    params:(NSDictionary *)params
                successful:(void(^)(id response))successful
                   failure:(void(^)(NSError *error))failure;



@end
