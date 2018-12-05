//
//  BMHTTPSessionManager.m
//  BaiSi
//
//  Created by developershang on 2017/6/13.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMHTTPSessionManager.h"

#pragma mark - 正式线
NSString * const BMBaseURL =  @"http://api.budejie.com/api/api_open.php";

#pragma mark - 测试线
//NSString * const BMBaseURL =  @"https://api.budejie.com/api/api_open.php";


static BMHTTPSessionManager *_shareInstance = nil;


@implementation BMHTTPSessionManager


// 子类化mangager
- (instancetype)initWithBaseURL:(NSURL *)url{
    
    if (self = [super initWithBaseURL:url]) {
    self.requestSerializer.timeoutInterval = 5.0f;
        // NSLog(@"超时时间设置为5s");
//     NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"no5" ofType:@"cer"];
//     NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//     AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//     securityPolicy.pinnedCertificates=@[certData];
//     securityPolicy.allowInvalidCertificates=YES;
//     securityPolicy.validatesDomainName=YES;
//     self.securityPolicy=securityPolicy;
//     self.responseSerializer = [AFHTTPResponseSerializer serializer];
//     self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"Content-type",@"application/json", @"text/json", @"text/javascript",@"application/soap+xml", @"text/html", @"text/xml",@"text/plain", nil];
       
        //NSLog(@"子类化 manager");
        
    }
    return self;
}



+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
     _shareInstance = [BMHTTPSessionManager manager];
      _shareInstance.requestSerializer.timeoutInterval=5.0f;
     /*
     _shareInstance = [[BMHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BMBaseURL]];
      [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                    switch (status) {
                        case AFNetworkReachabilityStatusReachableViaWWAN:
                            NSLog(@"自带网络");
                            break;
        
                        case AFNetworkReachabilityStatusReachableViaWiFi:
                            NSLog(@"wifi");
                            break;
                        case AFNetworkReachabilityStatusNotReachable:
                            NSLog(@"没有网路");
                            break;
                        default:
                            break;
                    }
                }];
                [_sharedClient.reachabilityManager startMonitoring];
         */

    });

    return _shareInstance;
    
}



- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *, id))success
                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    
    return  [super GET:URLString parameters:parameters success:success failure:failure];

}



- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
     NSLog(@"POST方法重载");
    
    return [super POST:URLString parameters:parameters success:success failure:failure];
    
}



- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
     NSLog(@"POST上传方法重载");
    
    return [super POST:URLString parameters:parameters constructingBodyWithBlock:block success:success failure:failure];
}


- (NSURLSessionDataTask *)BMGET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *, id))success
                        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    /**
     各种数据的参数数据的处理逻辑
     */
    
    
  NSURLSessionDataTask * task=  [super GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        success(task,responseObject);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
        failure(task, error);
        
    }];
        
    return task;
    
}





@end
