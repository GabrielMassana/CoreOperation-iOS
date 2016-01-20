//
//  COMExampleOperation.m
//  CoreOperation
//
//  Created by Gabriel Massana on 20/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "COMExampleOperation.h"

@interface COMExampleOperation ()

@property (nonatomic, assign) NSInteger value;

@end

@implementation COMExampleOperation

@synthesize identifier = _identifier;

#pragma mark - Init

- (instancetype)initWithValue:(NSInteger)value
{
    self = [super init];
    
    if (self)
    {
        self.value = value;
    }
    
    return self;
}

#pragma mark - Identifier

- (NSString *)identifier
{
    if (!_identifier)
    {
        _identifier = [NSString stringWithFormat:@"COMExampleOperation-%@", @(self.value)];
    }
    
    return _identifier;
}

#pragma mark - Start

- (void)start
{
    [super start];
    
    srand((unsigned)time(0));
    NSInteger mod = self.value;
    NSInteger random = rand();
    NSInteger result = random % mod;
    
    [self didSucceedWithResult:@(result)];
}

#pragma mark - Cancel

- (void)cancel
{
    [super cancel];
    
    [self didSucceedWithResult:nil];
}

@end
