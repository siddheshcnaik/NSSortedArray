//
//  NotificationService.h
//  Notification
//
//  Created by Siddhesh Naik on 4/10/19.
//  Copyright © 2019 Siddhesh Naik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSortedArray.h"
NS_ASSUME_NONNULL_BEGIN

@interface Notification : NSObject
@property (nonatomic, readonly)NSString *bundleId;
@property (nonatomic, readonly)NSString *msg;
@property (nonatomic, readonly)NSString *guid;
@property (nonatomic, readwrite)NSDate *timestamp;

@end

@interface NotificationService : NSObject
{
    NSSortedArray<Notification *> *store;
}
+(void)test;
@end

NS_ASSUME_NONNULL_END
