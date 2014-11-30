//
//  HistoryViewController.m
//  MovieSearch
//
//  Created by Vivek Lakhera on 30/11/14.
//  Copyright (c) 2014 CRiMS0N. All rights reserved.
//

#import "HistoryViewController.h"
#import "MovieManager.h"
#import "ResultViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self.tableView reloadData];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MovieManager *sharedManager = [MovieManager sharedManager];
    
    self.movies = [sharedManager movieHistory];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.movies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moviehistory" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.movies objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"historySegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ResultViewController *nextViewController = (ResultViewController *)segue.destinationViewController;
        nextViewController.urlString = [self.movies objectAtIndex:indexPath.row];
    }
}


@end
