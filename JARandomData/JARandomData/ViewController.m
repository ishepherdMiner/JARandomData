//
//  ViewController.m
//  JARandomData
//
//  Created by Jason on 03/02/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+JARandom.h"

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
    [JAModel randomData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
