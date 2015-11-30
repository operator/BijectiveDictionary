//
//  OPCBijectiveDictionary.m
//  OperatoriOS
//
//  Created by Peter Meyers on 5/26/15.
//  Copyright (c) 2015 Operator. All rights reserved.
//

#import "OPCBijectiveDictionary.h"

NS_ASSUME_NONNULL_BEGIN

@interface OPCBijectiveDictionary ()

@property (nonatomic, strong) NSOrderedSet *orderedKeys;
@property (nonatomic, strong) NSOrderedSet *orderedObjects;

@end

@implementation OPCBijectiveDictionary

- (instancetype)init
{
    return [self initWithObjects:[NSOrderedSet orderedSet] keys:[NSOrderedSet orderedSet]];
}

- (instancetype)initWithObjects:(nullable NSOrderedSet *)objects
                           keys:(nullable NSOrderedSet *)keys
{
    if (self = [super init]) {
        _orderedKeys = [keys copy];
        _orderedObjects = [objects copy];
        NSParameterAssert(_orderedKeys.count == _orderedObjects.count);
    }
    return self;
}

- (NSSet *)keys
{
    return self.orderedKeys.set;
}

- (NSSet *)objects
{
    return self.orderedObjects.set;
}

- (NSMapTable *)mapTable
{
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
    for (id key in self.orderedKeys) {
        NSUInteger index = [self.orderedKeys indexOfObject:key];
        [mapTable setObject:self.orderedObjects[index] forKey:key];
    }
    return mapTable;
}

- (id)objectForKeyedSubscript:(id)key
{
    NSUInteger index = [self.orderedKeys indexOfObject:key];
    if (index != NSNotFound) {
        return [self.orderedObjects objectAtIndex:index];
    }
    return nil;
}

- (instancetype)inverse
{
    return [[[self class] alloc] initWithObjects:self.orderedKeys keys:self.orderedObjects];
}

- (NSUInteger)count
{
    NSParameterAssert(self.orderedKeys.count == self.orderedObjects.count);
    return self.orderedKeys.count;
}

- (NSString *)description
{
    NSMutableString *description = [[NSMutableString alloc] init];
    [self.orderedKeys enumerateObjectsUsingBlock:^(id key, NSUInteger idx, BOOL *stop) {
        id object = [self.orderedObjects objectAtIndex:idx];
        [description appendFormat:@"%@ -> %@\n", key, object];
    }];
    return description;
}

- (BOOL)isEqual:(OPCBijectiveDictionary *)otherDictionary
{
    return [otherDictionary isKindOfClass:[OPCBijectiveDictionary class]] && [self.orderedKeys isEqualToOrderedSet:otherDictionary.orderedKeys] && [self.orderedObjects isEqualToOrderedSet:otherDictionary.orderedObjects];
}

- (NSUInteger)hash
{
    return self.orderedKeys.hash ^ self.orderedObjects.hash;
}

#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(__unsafe_unretained id[])buffer
                                    count:(NSUInteger)len
{
    return [self.orderedKeys countByEnumeratingWithState:state objects:buffer count:len];
}

#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    NSOrderedSet *keys = [self.orderedKeys copyWithZone:zone];
    NSOrderedSet *objects = [self.orderedObjects copyWithZone:zone];
    return [[OPCBijectiveDictionary allocWithZone:zone] initWithObjects:objects keys:keys];
}

#pragma mark NSMutableCopying

- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    NSMutableOrderedSet *mutableKeys = [self.orderedKeys mutableCopyWithZone:zone];
    NSMutableOrderedSet *mutableObjects = [self.orderedObjects mutableCopyWithZone:zone];
    return [[OPCMutableBijectiveDictionary allocWithZone:zone] initWithObjects:mutableObjects keys:mutableKeys];
}

#pragma mark OPCMutableOrderedCopying

- (id)mutableOrderedCopy
{
    NSMutableOrderedSet *mutableKeys = [self.orderedKeys mutableCopy];
    NSMutableOrderedSet *mutableObjects = [self.orderedObjects mutableCopy];
    return [[OPCMutableOrderedBijectiveDictionary alloc] initWithObjects:mutableObjects keys:mutableKeys];
}

#pragma mark OPCThreadSafeMutableCopying

- (id)threadSafeMutableCopy
{
    return [[OPCThreadSafeMutableBijectiveDictionary alloc] initWithObjects:self.orderedObjects keys:self.orderedKeys];
}

#pragma mark OPCThreadSafeMutableOrderedCopying

- (id)threadSafeMutableOrderedCopy
{
    return [[OPCThreadSafeMutableOrderedBijectiveDictionary alloc] initWithObjects:self.orderedObjects keys:self.orderedKeys];
}

#pragma mark NSSecureCoding

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (nullable id)initWithCoder:(NSCoder *)aDecoder
{
    NSOrderedSet *keys = [aDecoder decodeObjectOfClass:[NSOrderedSet class] forKey:NSStringFromSelector(@selector(keys))];
    NSOrderedSet *objects = [aDecoder decodeObjectOfClass:[NSOrderedSet class] forKey:NSStringFromSelector(@selector(objects))];
    return [self initWithObjects:objects keys:keys];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.orderedKeys forKey:NSStringFromSelector(@selector(keys))];
    [aCoder encodeObject:self.orderedObjects forKey:NSStringFromSelector(@selector(objects))];
}

@end

#pragma mark -

@implementation OPCOrderedBijectiveDictionary

- (NSOrderedSet *)orderedKeys
{
    return super.orderedKeys;
}

- (NSOrderedSet *)orderedObjects
{
    return super.orderedObjects;
}

#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    NSOrderedSet *keys = [self.orderedKeys copyWithZone:zone];
    NSOrderedSet *objects = [self.orderedObjects copyWithZone:zone];
    return [[OPCOrderedBijectiveDictionary allocWithZone:zone] initWithObjects:objects keys:keys];
}

@end

#pragma mark -

@interface OPCMutableBijectiveDictionary ()

@property (nonatomic, strong) NSMutableOrderedSet *mutableOrderedKeys;
@property (nonatomic, strong) NSMutableOrderedSet *mutableOrderedObjects;

@end

@implementation OPCMutableBijectiveDictionary

- (instancetype)init
{
    return [self initWithCapacity:0];
}

- (instancetype)initWithObjects:(nullable NSOrderedSet *)objects
                           keys:(nullable NSOrderedSet *)keys
{
    if (self = [super initWithObjects:nil keys:nil]) {
        _mutableOrderedKeys = [keys mutableCopy];
        _mutableOrderedObjects = [objects mutableCopy];
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)count
{
    if (self = [super initWithObjects:nil keys:nil]) {
        _mutableOrderedKeys = [NSMutableOrderedSet orderedSetWithCapacity:count];
        _mutableOrderedObjects = [NSMutableOrderedSet orderedSetWithCapacity:count];
    }
    return self;
}

- (NSOrderedSet *)orderedKeys
{
    return self.mutableOrderedKeys;
}

- (void)setOrderedKeys:(NSOrderedSet *)orderedKeys
{
    self.mutableOrderedKeys = [orderedKeys mutableCopy];
}

- (NSOrderedSet *)orderedObjects
{
    return self.mutableOrderedObjects;
}

- (void)setOrderedObjects:(NSOrderedSet *)orderedObjects
{
    self.mutableOrderedObjects = [orderedObjects mutableCopy];
}

- (void)setObject:(id)object
forKeyedSubscript:(id)key
{
    [self removeObjectForKey:key];
    [self.mutableOrderedKeys addObject:key];
    [self.mutableOrderedObjects addObject:object];

    NSParameterAssert(self.mutableOrderedKeys.count == self.mutableOrderedObjects.count);
}

- (void)removeObjectForKey:(id)key
{
    NSUInteger keyIndex = [self.mutableOrderedKeys indexOfObject:key];
    if (keyIndex != NSNotFound) {
        [self.mutableOrderedKeys removeObjectAtIndex:keyIndex];
        [self.mutableOrderedObjects removeObjectAtIndex:keyIndex];
    }
    NSParameterAssert(self.mutableOrderedKeys.count == self.mutableOrderedObjects.count);
}

@end

#pragma mark -

@implementation OPCMutableOrderedBijectiveDictionary

- (void)setObject:(id)object
           forKey:(id)key
          atIndex:(NSUInteger)index
{
    self[key] = object;
    if (object) {
        [self.mutableOrderedKeys insertObject:key atIndex:index];
        [self.mutableOrderedObjects insertObject:object atIndex:index];
    }
}

@end

#pragma mark -

@implementation OPCThreadSafeMutableBijectiveDictionary {
    OPCThreadSafeMutableOrderedBijectiveDictionary *_backingDictionary;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return _backingDictionary;
}

- (instancetype)init
{
    return [self initWithObjects:nil keys:nil];
}

- (instancetype)initWithObjects:(nullable NSOrderedSet *)objects
                           keys:(nullable NSOrderedSet *)keys
{
    if (self = [super initWithObjects:nil keys:nil]) {
        _backingDictionary = [[OPCThreadSafeMutableOrderedBijectiveDictionary alloc] initWithObjects:objects keys:keys];
    }
    return self;
}

- (id)threadSafeMutableCopy
{
    return [_backingDictionary threadSafeMutableCopy];
}

- (id)threadSafeMutableOrderedCopy
{
    return [_backingDictionary threadSafeMutableOrderedCopy];
}

@end

#pragma mark -

@implementation OPCThreadSafeMutableOrderedBijectiveDictionary {
    dispatch_queue_t _queue;
}

- (instancetype)init
{
    return [self initWithObjects:nil keys:nil];
}

- (instancetype)initWithObjects:(nullable NSOrderedSet *)objects
                           keys:(nullable NSOrderedSet *)keys
{
    if (self = [super initWithObjects:objects keys:keys]) {
        _queue = dispatch_queue_create("com.operator.OPCThreadSafeMutableBijectiveDictionary", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (NSSet *)keys
{
    __block NSSet *keys;
    dispatch_sync(_queue, ^{
        keys = super.keys;
    });
    return keys;
}

- (NSSet *)objects
{
    __block NSSet *objects;
    dispatch_sync(_queue, ^{
        objects = super.objects;
    });
    return objects;
}

- (NSMapTable *)mapTable
{
    __block NSMapTable *mapTable;
    dispatch_sync(_queue, ^{
        mapTable = super.mapTable;
    });
    return mapTable;
}

- (id)objectForKeyedSubscript:(id)key
{
    __block id object;
    dispatch_sync(_queue, ^{
        object = [super objectForKeyedSubscript:key];
    });
    return object;
}

- (instancetype)inverse
{
    __block OPCThreadSafeMutableOrderedBijectiveDictionary *inverse;
    dispatch_sync(_queue, ^{
        inverse = [super inverse];
    });
    return inverse;
}

- (NSUInteger)count
{
    __block NSUInteger count;
    dispatch_sync(_queue, ^{
        count = super.count;
    });
    return count;
}

- (NSString *)description
{
    __block NSString *description;
    dispatch_sync(_queue, ^{
        description = super.description;
    });
    return description;
}

- (BOOL)isEqual:(id)object
{
    __block BOOL isEqual;
    dispatch_sync(_queue, ^{
        isEqual = [super isEqual:object];
    });
    return isEqual;
}

- (NSUInteger)hash
{
    __block NSUInteger hash;
    dispatch_sync(_queue, ^{
        hash = super.hash;
    });
    return hash;
}

- (void)setObject:(id)object
forKeyedSubscript:(id)key
{
    dispatch_barrier_async(_queue, ^{
        [super setObject:object forKeyedSubscript:key];
    });
}

- (void)setObject:(id)object
           forKey:(id)key
          atIndex:(NSUInteger)index
{
    dispatch_barrier_async(_queue, ^{
        [super setObject:object forKey:key atIndex:index];
    });
}

- (NSOrderedSet *)orderedKeys
{
    __block NSOrderedSet *keys;
    dispatch_sync(_queue, ^{
        keys = super.orderedKeys;
    });
    return keys;
}

- (NSOrderedSet *)orderedObjects
{
    __block NSOrderedSet *objects;
    dispatch_sync(_queue, ^{
        objects = super.orderedObjects;
    });
    return objects;
}

#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(__unsafe_unretained id[])buffer
                                    count:(NSUInteger)len
{
    __block NSUInteger count;
    dispatch_sync(_queue, ^{
        count = [super countByEnumeratingWithState:state objects:buffer count:len];
    });
    return count;
}

#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    __block id copy;
    dispatch_sync(_queue, ^{
        copy = [super copyWithZone:zone];
    });
    return copy;
}

#pragma mark NSMutableCopying

- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    __block id copy;
    dispatch_sync(_queue, ^{
        copy = [super mutableCopyWithZone:zone];
    });
    return copy;
}

#pragma mark OPCMutableOrderedCopying

- (id)mutableOrderedCopyWithZone:(NSZone *)zone
{
    __block id copy;
    dispatch_sync(_queue, ^{
        copy = [super mutableOrderedCopy];
    });
    return copy;
}

#pragma mark OPCThreadSafeMutableCopying

- (id)threadSafeMutableCopy
{
    __block id copy;
    dispatch_sync(_queue, ^{
        copy = [[OPCThreadSafeMutableBijectiveDictionary alloc] initWithObjects:super.orderedObjects keys:super.orderedKeys];
    });
    return copy;
}

#pragma mark OPCThreadSafeMutableOrderedCopying

- (id)threadSafeMutableOrderedCopy
{
    __block id copy;
    dispatch_sync(_queue, ^{
        copy = [[OPCThreadSafeMutableOrderedBijectiveDictionary alloc] initWithObjects:super.orderedObjects keys:super.orderedKeys];
    });
    return copy;
}

#pragma mark NSSecureCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    dispatch_async(_queue, ^{
        [super encodeWithCoder:aCoder];
    });
}

@end

NS_ASSUME_NONNULL_END
