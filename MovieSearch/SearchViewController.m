//
//  SearchViewController.m
//  MovieSearch
//
//  Created by Vivek Lakhera on 29/11/14.
//  Copyright (c) 2014 CRiMS0N. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultViewController.h"
#import "MovieManager.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([[segue identifier] isEqualToString:@"searchSegue"])
    {
        MovieManager *sharedManager = [MovieManager sharedManager];
        [[sharedManager movieHistory] insertObject:self.searchText.text atIndex:0];
       
        ResultViewController *nextViewController = segue.destinationViewController;
        nextViewController.urlString = self.searchText.text;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
