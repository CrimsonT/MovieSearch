//
//  SearchViewController.h
//  MovieSearch
//
//  Created by Vivek Lakhera on 29/11/14.
//  Copyright (c) 2014 CRiMS0N. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *searchText;
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end
