# CoreOperation-iOS

[![Version](https://img.shields.io/cocoapods/v/CoreOperation.svg?style=flat-square)](http://cocoapods.org/pods/CoreOperation)
[![License](https://img.shields.io/cocoapods/l/CoreOperation.svg?style=flat-square)](http://cocoapods.org/pods/CoreOperation)
[![Platform](https://img.shields.io/cocoapods/p/CoreOperation.svg?style=flat-square)](http://cocoapods.org/pods/CoreOperation)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/CoreOperation.svg?style=flat-square)](http://cocoapods.org/pods/CoreOperation)
[![Build Status](https://img.shields.io/travis/GabrielMassana/CoreOperation-iOS/master.svg?style=flat-square)](https://travis-ci.org/GabrielMassana/CoreOperation-iOS)

Wrapper project to simplify NSOperation and NSOperationQueue.

## Installation

#### Podfile

```ruby
platform :ios, '8.0'
pod 'CoreOperation', '~> 1.0'
```

Then, run the following command:

```bash
$ pod install
```

#### Old school

Drag into your project the folder `/CoreOperation-iOS`. That's all.

## Example

#### Register Operation Queues

```objc

//  AppDelegate.m

NSString *const kCOMLocalOperationQueueTypeIdentifier = @"kCOMLocalOperationQueueTypeIdentifier";


#pragma mark - OperationQueues

- (void)registerOperationQueues
{
    //Local Background
    NSOperationQueue *localOperationQueue = [[NSOperationQueue alloc] init];
    localOperationQueue.qualityOfService = NSQualityOfServiceBackground;
    localOperationQueue.maxConcurrentOperationCount = 1;
    
    [[COMOperationQueueManager sharedInstance] registerOperationQueue:localOperationQueue
                                             operationQueueIdentifier:kCOMLocalOperationQueueTypeIdentifier];
}


```

#### Create an COMOperation subclass

```objc
//  COMExampleOperation.h

@interface COMExampleOperation : COMOperation

- (instancetype)initWithValue:(NSInteger)value;

@end

//  COMExampleOperation.m

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

```

#### Use the operaation

```objc

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

```

## License

ButtonBackgroundColor-iOS is released under the MIT license. Please see the file called LICENSE.

## Versions

```bash
$ git tag -a 1.0.0 -m 'Version 1.0.0'

$ git push --tags
```

## Author

Gabriel Massana

##Found an issue?

Please open a [new Issue here](https://github.com/GabrielMassana/CoreOperation-iOS/issues/new) if you run into a problem specific to CoreOperation-iOS, have a feature request, or want to share a comment.
