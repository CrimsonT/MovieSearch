//
//  ResultViewController.m
//  MovieSearch
//
//  Created by Vivek Lakhera on 30/11/14.
//  Copyright (c) 2014 CRiMS0N. All rights reserved.
//
#define kAPIKEY @"XXXX" //Rotten Tomato API Key
#import "ResultViewController.h"

@interface ResultViewController ()
@property (nonatomic, strong) NSMutableData   *buffer;
@property (nonatomic, strong) NSURLConnection *connectionOne;
@property (nonatomic, strong) NSMutableArray *searchResult;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.spinner startAnimating];
    
    self.searchResult =  [NSMutableArray array];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=%@&q=%@&page_limit=10&page=1", kAPIKEY, [self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];

    self.connectionOne = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(self.connectionOne) {
        self.buffer = [NSMutableData data];
        [self.connectionOne start];
    }
    else {
        UIAlertView *viewError = nil;
        viewError = [[UIAlertView alloc] initWithTitle: @"ERROR" message:@"Connection Failed" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [viewError show];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//CONNECTION
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(connection == self.connectionOne) {
        self.connectionOne = nil;
        self.buffer     = nil;
        UIAlertView *viewError = nil;
        viewError = [[UIAlertView alloc] initWithTitle: @"ERROR" message:[error localizedDescription] delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [viewError show];
        NSLog(@"Connection failed! Error - %@ %@",
              [error localizedDescription],
              [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(connection == self.connectionOne) {
        [self.buffer setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection == self.connectionOne) {
        [self.buffer appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(connection == self.connectionOne) {
        NSError *error = nil;
        NSDictionary *jsonString = [NSJSONSerialization JSONObjectWithData:_buffer options:0 error:&error];
        
        NSArray *movies = [jsonString objectForKey:@"movies"];
        
        for(NSDictionary *movie in movies) {
            [self.searchResult addObject:movie];
            NSLog(@"%@:%@", [movie objectForKey:@"title"], [movie objectForKey:@"year"]);
        }
        
        [self.spinner stopAnimating];
        [self.tableView reloadData];
        
        self.connectionOne = nil;
        self.buffer     = nil;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.searchResult count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.searchResult objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    NSNumber *year = [[self.searchResult objectAtIndex:indexPath.row] objectForKey:@"year"];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", year];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *viewMovie = nil;
    
    NSString *movie = [[NSString alloc] initWithFormat:@"%@\n%@", [[self.searchResult objectAtIndex:indexPath.row] objectForKey:@"year"], [[self.searchResult objectAtIndex:indexPath.row] objectForKey:@"synopsis"]];
    
    viewMovie = [[UIAlertView alloc] initWithTitle:[[self.searchResult objectAtIndex:indexPath.row] objectForKey:@"title"] message:movie delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [viewMovie show];
}

@end
