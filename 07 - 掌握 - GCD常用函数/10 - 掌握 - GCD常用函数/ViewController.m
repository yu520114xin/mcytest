//
//  ViewController.m
//  10 - 掌握 - GCD常用函数
//
//  Created by 马朝宇 on 16/8/21.
//  Copyright © 2016年 马朝宇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self delay];

}

/**
   一次性代码 :1) 整个程序运行过程中代码只会运行一次 2) block里面的代码是线程安全的
    应用场景: 单例模式
 */

-(void)once
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@" 1 -------%@",[NSThread currentThread]);
    });

}
/**
  GCD中的延迟执行
   参数说明:
   队列:决定blcok里面的任务在哪个线程中执行 dispatch_get_main_queue() 表示在主线程中执行
   延迟执行的原理:
   A : 先延迟 2s 时间, 2s后再把任务添加到队列中执行  正确
   B : 先把任务添加到队列, 2s后才执行
 
 */
-(void)delay
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"delay------%@",[NSThread currentThread]);
    });

}
@end
