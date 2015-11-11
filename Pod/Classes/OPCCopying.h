//
//  OPCopying.h
//  Pods
//
//  Created by Peter Meyers on 8/18/15.
//
//
@import Foundation;

@protocol OPCMutableOrderedCopying
- (id)mutableOrderedCopy;
@end

@protocol OPCThreadSafeMutableCopying
- (id)threadSafeMutableCopy;
@end

@protocol OPCThreadSafeMutableOrderedCopying
- (id)threadSafeMutableOrderedCopy;
@end
