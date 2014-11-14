//
//  AnotherViewController.m
//  RobotSpike
//
//  Created by pivotal on 11/13/14.
//  Copyright (c) 2014 Pivotal. All rights reserved.
//

#import "AnotherViewController.h"

@interface AnotherViewController ()

@property (strong, nonatomic) NSArray *items;

@end

@implementation AnotherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = @[@"First", @"Second", @"Third", @"Fourth"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    [self.view setBackgroundColor:[UIColor magentaColor]];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *item = self.items[indexPath.row];
    cell.textLabel.text = item;
    return cell;
}

@end
