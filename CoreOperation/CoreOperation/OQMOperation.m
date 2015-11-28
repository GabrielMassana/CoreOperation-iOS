//
//  OQMOperation.m
//  Hot
//
//  Created by GabrielMassana on 18/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import "OQMOperation.h"

@interface OQMOperation ()

@property (nonatomic, strong, readwrite) NSProgress *progress;

@property (atomic, assign, getter=isReady) BOOL ready;
@property (atomic, assign, getter=isExecuting) BOOL executing;
@property (atomic, assign, getter=isFinished) BOOL finished;

@property (nonatomic, strong, readwrite) id result;
@property (nonatomic, strong, readwrite) NSError *error;

/**
 Internal callback queue to make sure callbacks execute on same queue operation is created on.
 */
@property (nonatomic, strong) NSOperationQueue *callbackQueue;

@end

@implementation OQMOperation

@synthesize ready = _ready;
@synthesize executing = _executing;
@synthesize finished = _finished;

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.ready = YES;
        self.progress = [NSProgress progressWithTotalUnitCount:-1];
        self.callbackQueue = [NSOperationQueue currentQueue];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    
    if (self)
    {
        self.identifier = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(identifier))];
        self.operationQueueIdentifier = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(operationQueueIdentifier))];
    }
    
    return self;
}

#pragma mark - Name

//We will return the identifier as the name so that it is easier to debug.
- (NSString *)name
{
    return self.identifier;
}

#pragma mark - State

/***************************************************************************************************
 We need to implement the getters and setters manually as the compiler hates the readonly attribute.
 ***************************************************************************************************/

- (void)setReady:(BOOL)ready
{
    if (_ready != ready)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isReady))];
        _ready = ready;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isReady))];
    }
}

- (BOOL)isReady
{
    return _ready;
}

- (void)setExecuting:(BOOL)executing
{
    if (_executing != executing)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
        _executing = executing;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
    }
}

- (BOOL)isExecuting
{
    return _executing;
}

- (void)setFinished:(BOOL)finished
{
    if (_finished != finished)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
        _finished = finished;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
    }
}

- (BOOL)isFinished
{
    return _finished;
}

- (BOOL)isAsynchronous
{
    return YES;
}

#pragma mark - Control

- (void)start
{
    if (!self.isExecuting)
    {
        self.ready = NO;
        self.executing = YES;
        self.finished = NO;
        
        NSLog(@"\"%@\" Operation Started.", self.name);
    }
}

- (void)finish
{
    if (self.executing)
    {
        NSLog(@"\"%@\" Operation Finished.", self.name);
        
        self.executing = NO;
        self.finished = YES;
    }
}

#pragma mark - Callbacks

- (void)didSucceedWithResult:(id)result
{
    self.result = result;
    
    [self finish];
    
    if (self.onSuccess)
    {
        [self.callbackQueue addOperationWithBlock:^
         {
             self.onSuccess(result);
         }];
    }
}

- (void)didCompleteWithResult:(id)result
{
    self.result = result;
    
    [self finish];
    
    if (self.onCompletion)
    {
        [self.callbackQueue addOperationWithBlock:^
         {
             self.onCompletion(result);
         }];
    }
}

- (void)didFailWithError:(NSError *)error
{
    self.error = error;
    
    [self finish];
    
    if (self.onFailure)
    {
        [self.callbackQueue addOperationWithBlock:^
         {
             self.onFailure(error);
         }];
    }
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.identifier
                  forKey:NSStringFromSelector(@selector(identifier))];
    
    [aCoder encodeObject:self.operationQueueIdentifier
                  forKey:NSStringFromSelector(@selector(operationQueueIdentifier))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    OQMOperation *newOperation = [[self.class allocWithZone:zone] init];
    
    newOperation.callbackQueue = _callbackQueue;
    
    newOperation.identifier = [_identifier copy];
    newOperation.operationQueueIdentifier = [_operationQueueIdentifier copy];
    
    newOperation.onSuccess = [_onSuccess copy];
    newOperation.onFailure = [_onFailure copy];
    
    return newOperation;
}

@end
