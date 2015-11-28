//
//  OQMOperationQueueManager.m
//  Hot
//
//  Created by GabrielMassana on 18/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import "OQMOperationQueueManager.h"

#import "OQMOperation.h"

@interface OQMOperationQueueManager ()

@property (nonatomic, strong) NSMutableDictionary *operationQueuesDictionary;

@end

@implementation OQMOperationQueueManager

#pragma mark - SharedInstance

+ (instancetype)sharedInstance
{
    static OQMOperationQueueManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedInstance = [[OQMOperationQueueManager alloc] init];
                  });
    
    return sharedInstance;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.operationQueuesDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark - Register

- (void)registerOperationQueue:(NSOperationQueue *)operationQueue
      operationQueueIdentifier:(NSString *)operationQueueIdentifier
{
    [self.operationQueuesDictionary setObject:operationQueue
                                       forKey:operationQueueIdentifier];
}

#pragma mark - AddOperation

- (void)addOperation:(OQMOperation *)operation
{
    NSOperationQueue *operationQueue = self.operationQueuesDictionary[operation.operationQueueIdentifier];
    
    [operationQueue addOperation:operation];
}

@end
