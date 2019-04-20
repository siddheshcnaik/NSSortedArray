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
    NSUInteger heapIndex = rootIndex+1;
    return heapIndex*2-1;
}

-(NSUInteger)rightLeafIndex:(NSUInteger)rootIndex {
    NSUInteger heapIndex = rootIndex+1;
    return heapIndex*2+1-1;
}

-(NSUInteger)heapLastIndex {
    return self.array.count - 1;
}

-(void)heapify:(NSUInteger) indexRoot {
    if([self leftLeafIndex:indexRoot] > [self heapLastIndex]){
        return;
    }
    NSUInteger leftIndex = [self leftLeafIndex:indexRoot];
    NSUInteger rightIndex = [self rightLeafIndex:indexRoot];
    NSUInteger lastIndex = [self heapLastIndex];
    
    id root = self.array[indexRoot];
    NSUInteger smallestIndex = indexRoot;
    id smallest = root;
    
    id left = self.array[leftIndex];
    
    if(self.compareFunction(left, root) == NSOrderedDescending) {
        smallestIndex = leftIndex;
        smallest = left;
    }
    if(rightIndex <= lastIndex){
        id right = self.array[rightIndex];
        if(self.compareFunction(right, smallest) == NSOrderedDescending) {
            smallest = right;
            smallestIndex = rightIndex;
        }
    }
    
    if(smallestIndex != indexRoot){
        [self.array exchangeObjectAtIndex:indexRoot withObjectAtIndex:smallestIndex];
        [self heapify:smallestIndex];
    }
}

-(void)buildHeap {
    if(self.array.count<2) return;
    int lastParentIndex = (int)self.array.count/2;
    for (int parentIndex = lastParentIndex; parentIndex >= 0; parentIndex--) {
        [self heapify:parentIndex];
    }
}

-(void)insert:(id)object {
    [self.array insertObject:object atIndex:0];
    [self buildHeap];
}

-(id)removenext {
    id top = self.array.firstObject;
    [self.array exchangeObjectAtIndex:0 withObjectAtIndex:[self heapLastIndex]];
    [self heapify:0];
    [self.array removeLastObject];
    return top;
}

-(id)getnext {
    return self.array.firstObject;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len {
    return [self.array countByEnumeratingWithState:state
                                           objects:buffer
                                             count:len];
}

-(BOOL)find:(id) object {
    
    int x = 0;
    int y = (int)self.array.count - 1;
    while(x <= y) {
        int center = (x + y)/2;
        NSComparisonResult result = self.compareFunction(self.array[center], object);
        if (result == NSOrderedSame) {
            //Found it
            return true;
        }
        if (result == NSOrderedDescending) {
            x = center + 1;
        }
        else {
            y = center - 1;
        }
    }
    return NO;
}

-(NSString *)description {
    NSMutableString *log = [NSMutableString new];
    for (id c in self.array) {
        [log appendFormat:@"%@ \n", c];
    }
    return log;
}
@end
