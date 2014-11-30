//
//  MovieManager.h
//  MovieSearch
//
//  Created by Vivek Lakhera on 29/11/14.
//  Copyright (c) 2014 CRiMS0N. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieManager : NSObject {
    NSMutableArray *movieHistory;
}

@property (nonatomic, retain) NSMutableArray *movieHistory;

+ (id)sharedManager;

@end
