//
//  NSSortedArray.m
//  Notification
//
//  Created by Siddhesh Naik on 4/17/19.
//  Copyright © 2019 Siddhesh Naik. All rights reserved.
//

#import "NSSortedArray.h"

@interface NSSortedArray()

@property (nonatomic) NSMutableArray<id> *array;

@end

@implementation NSSortedArray

-(instancetype)init {
    self = [super init];
    _array = [NSMutableArray new];
    return self;
}

-(NSUInteger)leftLeafIndex:(NSUInteger)rootIndex {
    return (rootIndex*2) + 1;
}

-(NSUInteger)rightLeafIndex:(NSUInteger)rootIndex {
    return (rootIndex*2)+2;
}

-(NSUInteger)heapLastIndex {
    return self.array.count - 1;
}

-(void)heapify:(NSUInteger)indexRoot {
    NSUInteger lastIndex = [self heapLastIndex];
    NSUInteger leftIndex = [self leftLeafIndex:indexRoot];
    NSUInteger rightIndex = [self rightLeafIndex:indexRoot];
    NSUInteger largestIndex = indexRoot;
    
    if((leftIndex < lastIndex) && self.compareFunction(self.array[indexRoot], self.array[leftIndex]) == NSOrderedAscending) {
        largestIndex = leftIndex;
    }
    if ((rightIndex < lastIndex) && self.compareFunction(self.array[largestIndex], self.array[rightIndex]) == NSOrderedAscending) {
        largestIndex = rightIndex;
    }
    
    if (largestIndex != indexRoot) {
        [self.array exchangeObjectAtIndex:largestIndex withObjectAtIndex:indexRoot];
        [self heapify:largestIndex];
    }
}

-(void)buildHeap {
    if(self.array.count<2) return;
    int lastParentIndex = (int)self.array.count/2;
    for (int parentIndex = lastParentIndex; parentIndex >= 0; parentIndex--) {
        [self heapify:parentIndex];
    }
}

-(void)sort{
    if(self.array.count<2) return;
    NSMutableArray* sortedA = [NSMutableArray new];
    for (int i = (int)self.array.count -1 ; i > 0; i--) {
        [sortedA insertObject:self.array[0] atIndex:0];
        [self.array exchangeObjectAtIndex:0 withObjectAtIndex:self.array.count-1];
        [self.array removeLastObject];
        [self heapify:0];
    }
    [sortedA insertObject:self.array[0] atIndex:0];
    self.array = sortedA.mutableCopy;
}

-(void)insert:(id)object {
    [self.array insertObject:object atIndex:0];
    [self buildHeap];
}

-(id)removeRoot {
    id top = self.array.firstObject;
    [self.array exchangeObjectAtIndex:0 withObjectAtIndex:[self heapLastIndex]];
    [self heapify:0];
    [self.array removeLastObject];
    return top;
}

-(id)getRoot {
    return self.array.firstObject;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len {
    [self sort];
    return [self.array countByEnumeratingWithState:state
                                           objects:buffer
                                             count:len];
}

-(BOOL)find:(id)object root:(NSUInteger)root {
    NSUInteger lastIndex = [self heapLastIndex];
    if (root > lastIndex) {
        return NO;
    }
    NSUInteger leftIndex = [self leftLeafIndex:root];
    NSUInteger rightIndex = [self rightLeafIndex:root];
    
    NSComparisonResult result = self.compareFunction(self.array[root], object);
    if (result == NSOrderedSame) {
        return YES;
    }
    else {
        return [self find:object root:rightIndex] || [self find:object root:leftIndex];
    }
}

-(BOOL)find:(id)object {
    return [self find:object root:0];
}

-(NSString *)description {
    NSMutableString *log = [NSMutableString new];
    for (id c in self.array) {
        [log appendFormat:@"\n%@", c];
    }
    return log;
}
@end
