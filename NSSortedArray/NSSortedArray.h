//
//  NSSortedArray.h
//  Notification
//
//  Created by Siddhesh Naik on 4/17/19.
//  Copyright © 2019 Siddhesh Naik. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSortedArray<ObjectType> : NSObject<NSFastEnumeration>
typedef NSComparisonResult(^Compare)(ObjectType a, ObjectType b);
@property (copy)Compare compareFunction;

-(void)insert:(ObjectType)object;
-(ObjectType)getRoot;
-(ObjectType)removeRoot;
-(BOOL)find:(ObjectType) object;
@end

NS_ASSUME_NONNULL_END
