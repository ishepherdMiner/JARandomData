//
//  ViewController.m
//  JARandomData
//
//  Created by Jason on 03/02/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "ViewController.h"

#if DEBUG
    #import "JARandom.h"
#endif

@interface JAModel : NSObject

@property (nonatomic,copy) NSString *modelString;
@property (nonatomic,assign) int modelInt;
@property (nonatomic,strong) NSDate *modelData;

@end

@implementation JAModel

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JARandom *random = [JARandom generateWithName:@"ja_user" class:[JAModel class] nums:5];
    NSLog(@"%@",random.createSqlCmd);
    NSLog(@"%@",random.insertSqlCmd);
    NSLog(@"%@",random.stub);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
