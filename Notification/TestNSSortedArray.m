//
//  TestNSSortedArray.m
//  Notification
//
//  Created by Siddhesh Naik on 4/21/19.
//  Copyright © 2019 Siddhesh Naik. All rights reserved.
//

#import "TestNSSortedArray.h"
#import "NSSortedArray.h"
#include <stdlib.h>

@implementation TestNSSortedArray
+(void)test {
    NSSortedArray<NSNumber *> *array = [NSSortedArray new];
    array.compareFunction = ^NSComparisonResult(NSNumber  *a, NSNumber  *b) {
        return [a compare:b];
    };
    int temp = 0;
    for (int i = 0; i < 100; i++) {
        int r = arc4random_uniform(100);
        if (i == 50) {
            temp = r;
        }
        [array insert:@(r)];
    }
    
    BOOL found = [array find:@(temp)];
    
    NSLog(@"%@", found ? @"YES" : @"NO");
    
    NSLog(@"%@", array);
}
@end
