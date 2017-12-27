//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by 张涛 on 2017/12/21.
//  Copyright © 2017年 张涛. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //2.发送信号
        [subscriber sendNext:@1];
        
        //3.发送信号完毕,内部会自动调用[RACDisposable disposable]
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            //block调用时：当信号发送完成或者发送错误，就会自动执行这个block，取消订阅信号
            //执行完block后，当前信号就不在被订阅了、
            NSLog(@"信号被摧毁");
        }];
    }];
    
    //4.订阅信号，才会激活信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到信号数据：%@",x);
    }];
    
    
    NSDictionary *dict =@{@"小王":@"18岁",@"小明":@"22岁",@"小刘":@"29岁"};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *key,NSString *value) = x;
        NSLog(@"%@ %@",key,value);
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
