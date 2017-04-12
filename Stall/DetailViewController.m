//
//  DetailViewController.m
//  Stall
//
//  Created by Inti Guo on 10/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "DetailViewController.h"
#import "UITableViewCell+Form.h"

@interface DetailViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *cells;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForm];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupForm {
    UITableViewCell *titleCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NULL];
    titleCell.textLabel.text = self.viewModel.book.title;
    titleCell.textLabel.font = [UIFont systemFontOfSize:30];

    UITableViewCell *authorCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NULL];
    authorCell.textLabel.text = self.viewModel.book.authors;
    authorCell.textLabel.font = [UIFont systemFontOfSize:20];
    authorCell.textLabel.textColor = [UIColor grayColor];
    
    UITableViewCell *coverCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NULL];

    UITableViewCell *ratingCell = [UITableViewCell formCellWithTitle:@"Rating"
                                                               value:self.viewModel.getRatingString];
    
    UITableViewCell *publisherCell = [UITableViewCell formCellWithTitle:@"Publisher"
                                                                  value:self.viewModel.book.publisher];
    UITableViewCell *pubdateCell = [UITableViewCell formCellWithTitle:@"Publish Date"
                                                                  value:self.viewModel.getPubdateString];
    UITableViewCell *pageCountCell = [UITableViewCell formCellWithTitle:@"Page Count"
                                                                  value:self.viewModel.getPageCountString];
    UITableViewCell *priceCell = [UITableViewCell formCellWithTitle:@"Price"
                                                              value:self.viewModel.book.price];
    UITableViewCell *bindingCell = [UITableViewCell formCellWithTitle:@"Binding"
                                                                value:self.viewModel.book.binding];
    
    self.cells =
    @[
      titleCell, authorCell, coverCell,
      ratingCell, publisherCell, pubdateCell,
      pageCountCell, priceCell, bindingCell
    ];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.viewModel = [DetailViewModel new];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cells[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: // title
            return 50;
        case 1: // author
            return 22;
        case 2: // cover
            return 240;
        default: // others
            return 44;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}

@end
