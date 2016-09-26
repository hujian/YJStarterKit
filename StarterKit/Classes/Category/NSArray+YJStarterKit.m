#import "NSArray+YJStarterKit.h"

@implementation NSArray (YJStarterKit)

- (id)random {
    if (self.count > 0) {
        NSInteger index = arc4random() % self.count;
        return self[index];
    }
    return nil;
}

- (NSArray*)head:(NSUInteger)count {
    if ([self count] <= count) {
        return self;
    }
    
    NSRange range = NSMakeRange(0, count);
    return [self subarrayWithRange:range];
}

- (NSArray *)tail:(NSUInteger)count {
    if ([self count] <= count) {
        return self;
    }
    
    NSRange range = NSMakeRange(self.count - count, count);
    return [self subarrayWithRange:range];
}

@end

@implementation NSMutableArray (YJStarterKit)

- (void)shuffle {
    NSUInteger count = [self count];
    
    if (count < 1) return;
    
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end
