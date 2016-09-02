//
//  ViewController.m
//  01-掌握-NSURLSession的基本使用
//
//  Created by 马朝宇 on 16/8/26.
//  Copyright © 2016年 马朝宇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDelegate>
@property(nonatomic,strong) NSMutableData * mutableData;
@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self other];

}
-(void)get1
{
  //01 确定url
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"];
  //02 创建请求对象(默认是get请求)
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
  //03 获得会话对象
    NSURLSession * session = [NSURLSession sharedSession];
  //04 根据会话对象创建Tast
    /**
     第一个参数:请求对象
     第二个参数:completionHandler 完成之后的回调
        data:响应体
     response:响应头
     error:错误信息
     注意点:completionHandler默认是在子线程中调用
     */
    NSURLSessionTask * dataTast = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //06 处理服务器返回的数据
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@",[NSThread currentThread]);

    }];
  //05 执行Tast
    [dataTast resume];

}

-(void)get2
{
    //01 确定url
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"];
    //02 获得会话对象
    NSURLSession * session = [NSURLSession sharedSession];
    //03 根据会话对象创建Tast
    /**
     第一个参数:请求路径
     dataTaskWithURL该方法内部会自动的将url包装成一个请求对象(GET请求)
     如果发送的是POST请求,那么不能使用该方法
     */
    NSURLSessionTask * dataTast = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //05 处理服务器返回的数据
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@",[NSThread currentThread]);
    }];
    
   //04 执行Tast
    [dataTast resume];
    
}
-(void)get3
{
   [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
       NSLog(@"%@",[NSThread currentThread]);

   }] resume];

}
-(void)post
{
    //01 确定url
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
    //02 创建可变的请求对象
    NSMutableURLRequest * murequest = [NSMutableURLRequest requestWithURL:url];
    //03 修改请求方式为POST
    murequest.HTTPMethod = @"POST";
    //04 设置参数 - (请求体)
    murequest.HTTPBody = [@"username=520it&pwd=520it&type=JSON " dataUsingEncoding:NSUTF8StringEncoding];
    //05 获得会话对象
   // NSURLSession * session = [NSURLSession sharedSession];
     NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //06 根据会话对象创建tast
    NSURLSessionTask * dataTast = [session dataTaskWithRequest:murequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //08 处理服务器返回的数据
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@",[NSThread currentThread]);
    }];
    //07 执行tast
    [dataTast resume];
    
}
//中文转码
-(void)other
{
    //01 确定url1
    //01-1
    NSString *urlStr = @"http://120.25.226.186:32812/login2?username=小码哥&pwd=520it&type=JSON";
    //01-2中文转码处理
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:urlStr];
    //02 创建请求对象(默认是get请求)
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    //03 获得会话对象
    NSURLSession * session = [NSURLSession sharedSession];
    //04 根据会话对象创建Tast
    /**
     第一个参数:请求对象
     第二个参数:completionHandler 完成之后的回调
     data:响应体
     response:响应头
     error:错误信息
     注意点:completionHandler默认是在子线程中调用
     */
    NSURLSessionTask * dataTast = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //06 处理服务器返回的数据
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@",[NSThread currentThread]);
        
    }];
    //05 执行Tast
    [dataTast resume];
    
}

-(void)delegate
{
    //01 确定url
    NSURL* url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"];
    //02 创建请求对象(默认是get请求)
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    //03 获得会话对象
    /**
     第一个参数:配置信息 defaultSessionConfiguration默认的配置信息
     第二个参数:谁成为它代理
     第三个参数:队列 - 线程 (决定代理方法在哪个线程中执行)
     注意点:如果传递nil 默认是子线程!!!
     */
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    //04 根据会话创建请求任务
    NSURLSessionTask * dataTast = [session dataTaskWithRequest:request];
    //执行datatast
    [dataTast resume];

}

#pragma mark ------------------------
#pragma mark NSURLSessionDataDelegate
//01 接收到服务器响应的时候调用  只会调用一次
// 通过调用completionHandler来告诉系统应该如何处理服务器返回的数据

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler

{           NSLog(@"didReceiveResponse--%@",[NSThread currentThread]);

     // 初始化
    self.mutableData = [NSMutableData data];
    completionHandler(NSURLSessionResponseAllow);
   
}
//02 接收到服务器返回数据的时候调用 该方法可能会调用多次

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{        NSLog(@"didReceiveData--%@",[NSThread currentThread]);

    [self.mutableData appendData:data];
}
//03 网络请求完成或者是失败的时候调用 如果失败那么error有值

-(void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error
{
    NSLog(@"didBecomeInvalidWithError--%@",[NSThread currentThread]);

    NSLog(@"%@",[[NSString alloc] initWithData:self.mutableData encoding:NSUTF8StringEncoding]);

}
@end
