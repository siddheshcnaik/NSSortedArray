//
//  NotificationService.m
//  Notification
//
//  Created by Siddhesh Naik on 4/10/19.
//  Copyright © 2019 Siddhesh Naik. All rights reserved.
//

#import "NotificationService.h"

@implementation Notification
-(instancetype)initWith:(NSString *)bundleId msg:(NSString *)msg {
    self = [super init];
    _bundleId = bundleId;
    _msg = msg;
    _guid = [[NSProcessInfo processInfo] globallyUniqueString];
    return self;
}

-(void)updateTimestamp {
    _timestamp = [NSDate date];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@, %@", _bundleId, _msg];
}
@end

@implementation NotificationService

-(instancetype)init {
    self = [super init];
    store = [NSSortedArray new];
    store.compareFunction = ^NSComparisonResult(Notification *a, Notification *b) {
        return [a.timestamp compare:b.timestamp];
    };
    return self;
}

-(void)addNotification:(Notification *)notification {
    [store insert:notification];
}

+(void)test {
    NSSortedArray *store = [NSSortedArray new];
    store.compareFunction = ^NSComparisonResult(Notification *a, Notification *b) {
        return [a.timestamp compare:b.timestamp];
    };
    {
        Notification *n = [[Notification alloc] initWith:@"com.apple.phone10" msg:@"msg"];
        [n updateTimestamp];
        [store insert:n];
    }
    {
        Notification *n = [[Notification alloc] initWith:@"com.apple.phone11" msg:@"msg"];
        [n updateTimestamp];
        [store insert:n];
    }
    {
        Notification *n = [[Notification alloc] initWith:@"com.apple.phone12" msg:@"msg"];
        [n updateTimestamp];
        [store insert:n];
    }
    {
        Notification *n = [[Notification alloc] initWith:@"com.apple.phone1" msg:@"msg"];
        [n updateTimestamp];
        [store insert:n];
    }
    NSLog(@"%@", store);
}

@end
