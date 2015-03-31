#import "NSMutableArray+SSToolkitAdditions.h"

@implementation NSMutableArray (SSToolkitAdditions)

- (void)shuffle
{
    if (self.count == 0) return;
    for (NSUInteger i = [self count] - 1; i > 0; i--) {
        [self exchangeObjectAtIndex:arc4random_uniform((u_int32_t)i + 1)
                  withObjectAtIndex:i];
    }
}

@end
