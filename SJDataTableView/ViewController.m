//
//  ViewController.m
//  SJDataTableView
//
//  Created by LeeSungJu on 2015. 7. 31..
//  Copyright (c) 2015년 LeeSungJu. All rights reserved.
//

#import "ViewController.h"
#import "SJDataTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * headerAarray = [[NSArray alloc] initWithObjects:@"Name", @"value1", @"value2", @"value3", @"value4", nil];
    NSMutableArray *dataArray = [NSMutableArray new];
    for (int i = 0 ; i< 20; i++) {
        NSMutableDictionary *dataDict = [NSMutableDictionary new];
        [dataDict setObject:[NSString stringWithFormat:@"name_%d",i] forKey:[headerAarray objectAtIndex:0]];
        [dataDict setObject:[NSString stringWithFormat:@"value1_%d",i] forKey:[headerAarray objectAtIndex:1]];
        [dataDict setObject:[NSString stringWithFormat:@"value2_%d",i] forKey:[headerAarray objectAtIndex:2]];
        [dataDict setObject:[NSString stringWithFormat:@"value3_%d",i] forKey:[headerAarray objectAtIndex:3]];
        [dataDict setObject:[NSString stringWithFormat:@"value4_%d",i] forKey:[headerAarray objectAtIndex:4]];
        [dataArray addObject:dataDict];
    }

    SJDataTableView * table =[[SJDataTableView alloc] initWithFrame:self.view.bounds headerSize:CGSizeMake(100, 70)];
    [table setHeaderArray:headerAarray dataArray:dataArray];
    [self.view addSubview:table];

}

@end
