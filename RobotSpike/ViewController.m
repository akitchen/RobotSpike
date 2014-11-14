//
//  ViewController.m
//  RobotSpike
//
//  Created by pivotal on 11/13/14.
//  Copyright (c) 2014 Pivotal. All rights reserved.
//

#import "ViewController.h"
#import "AnotherViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)presentAnotherViewController:(UIButton *)sender {
    AnotherViewController *anotherViewController = [[AnotherViewController alloc] init];
    [self.navigationController presentViewController:anotherViewController animated:YES completion:nil];
}

- (IBAction)pushAnotherViewController:(UIButton *)sender {
    AnotherViewController *anotherViewController = [[AnotherViewController alloc] init];
    [self.navigationController pushViewController:anotherViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
