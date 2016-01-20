//
//  ViewController.m
//  CoreOperation
//
//  Created by Gabriel Massana on 20/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "COMViewController.h"

#import "COMExampleOperation.h"
#import "CoreOperation.h"
#import "COMAppDelegate.h"

@interface COMViewController ()

@end

@implementation COMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self operationExample];
}

- (void)operationExample
{
    COMExampleOperation *operation = [[COMExampleOperation alloc] initWithValue:15];
    
    operation.operationQueueIdentifier = kCOMLocalOperationQueueTypeIdentifier;
    
    operation.onSuccess = ^(id result)
    {
        NSLog(@"%@", result);
    };
    
    [[COMOperationQueueManager sharedInstance] addOperation:operation];
}

@end
