//
//  MovieManager.m
//  MovieSearch
//
//  Created by Vivek Lakhera on 29/11/14.
//  Copyright (c) 2014 CRiMS0N. All rights reserved.
//

#import "MovieManager.h"

@implementation MovieManager

@synthesize movieHistory;

+ (id)sharedManager {
    static MovieManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        movieHistory = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
