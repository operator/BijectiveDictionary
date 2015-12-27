//
//  OPCBijectiveDictionary+Convenience.m
//  Pods
//
//  Created by Peter Meyers on 8/27/15.
//
//

#import "OPCBijectiveDictionary+Convenience.h"

NS_ASSUME_NONNULL_BEGIN

@implementation OPCBijectiveDictionary (Convenience)

+ (instancetype)dictionary
{
    return [[self alloc] init];
}

+ (instancetype)dictionaryWithDictionary:(nullable NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

+ (instancetype)dictionaryWithKeys:(nullable NSSet *)keys objectMapping:(id (^__nullable)(id))mapping
{
    return [[self alloc] initWithKeys:keys objectMapping:mapping];
}

+ (instancetype)dictionaryWithObjects:(nullable NSOrderedSet *)objects
                                 keys:(nullable NSOrderedSet *)keys
{
    return [[self alloc] initWithObjects:objects keys:keys];
}

+ (instancetype)dictionaryWithMapTable:(nullable NSMapTable *)mapTable
{
    return [[self alloc] initWithMapTable:mapTable];
}

- (instancetype)initWithMapTable:(nullable NSMapTable *)mapTable
{
    NSArray *objects = mapTable.objectEnumerator.allObjects;
    NSArray *keys = mapTable.keyEnumerator.allObjects;
    return [self initWithObjects:objects ? [NSOrderedSet orderedSetWithArray:objects] : nil keys: keys ? [NSOrderedSet orderedSetWithArray:keys] : nil];
}

- (instancetype)initWithDictionary:(nullable NSDictionary *)dictionary
{
    NSArray *objects = dictionary.allValues;
    NSArray *keys = dictionary.allKeys;
    return [self initWithObjects:objects ? [NSOrderedSet orderedSetWithArray:objects] : nil keys: keys ? [NSOrderedSet orderedSetWithArray:keys] : nil];
}

- (instancetype)initWithKeys:(nullable NSSet *)keys objectMapping:(id (^ __nullable )(id key))mapping
{
    NSOrderedSet *orderedKeys;
    NSMutableOrderedSet *objects;
    if (keys && mapping) {
        orderedKeys = [NSOrderedSet orderedSetWithSet:keys];
        objects = [NSMutableOrderedSet orderedSetWithCapacity:keys.count];
        for (id key in orderedKeys) {
            [objects addObject:mapping(key)];
        }
    }
    return [self initWithObjects:objects keys:orderedKeys];
}

- (instancetype)bijectiveDictionaryByAddingEntriesFromDictionary:(OPCBijectiveDictionary *)dictionary
{
    OPCMutableBijectiveDictionary *mutableCopy = [self mutableCopy];
    [mutableCopy addEntriesFromDictionary:dictionary];
    return [mutableCopy copy];
}

- (BOOL)isEqualToBijectiveDictionary:(OPCBijectiveDictionary *)dictionary
{
    return [self isEqual:dictionary];
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id _Nonnull key, id _Nonnull object))block
{
    for (id key in self) {
        id object = self[key];
        block(key, object);
    }
}

@end

@implementation OPCMutableBijectiveDictionary (Convenience)

+ (instancetype)dictionaryWithCapacity:(NSUInteger)count
{
    return [[self alloc] initWithCapacity:count];
}

- (void)removeEntriesFromDictionary:(OPCBijectiveDictionary *)dictionary
{
    for (id key in dictionary) {
        [self removeObjectForKey:key];
    }
}

- (void)addEntriesFromDictionary:(OPCBijectiveDictionary *)dictionary
{
    for (id key in dictionary) {
        self[key] = dictionary[key];
    }
}

- (void)removeAllObjects
{
    for (id key in [self.keys copy]) {
        [self removeObjectForKey:key];
    }
}

@end

@implementation OPCOrderedBijectiveDictionary (Convenience)

- (id)keyAtIndex:(NSUInteger)index
{
    return [self.orderedKeys objectAtIndex:index];
}

- (NSUInteger)indexOfKey:(id)key
{
    return [self.orderedKeys indexOfObject:key];
}

@end

@implementation OPCMutableOrderedBijectiveDictionary (Convenience)

- (id)keyAtIndex:(NSUInteger)index
{
    return [self.orderedKeys objectAtIndex:index];
}

- (NSUInteger)indexOfKey:(id)key
{
    return [self.orderedKeys indexOfObject:key];
}

@end

NS_ASSUME_NONNULL_END
