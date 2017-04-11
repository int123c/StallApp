//
//  DetailViewController.m
//  Stall
//
//  Created by Inti Guo on 10/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *cells;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [DetailViewModel new];
    
    [self setupForm];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupForm {
    self.cells =
    @[
      [UITableViewCell new],
    ];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cells[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

@end
