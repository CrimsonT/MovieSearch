//
//  ResultViewController.h
//  MovieSearch
//
//  Created by Vivek Lakhera on 30/11/14.
//  Copyright (c) 2014 CRiMS0N. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) NSString *urlString;
@end
