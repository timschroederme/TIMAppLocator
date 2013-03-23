//
//  TIMAppLocator.m
//
//  Created by Tim Schröder on 23.03.13.
//  Copyright (c) 2013 Tim Schröder. All rights reserved.
//

#import "TIMAppLocator.h"
#import "TIMAppLocatorProtocol.h"

@implementation TIMAppLocator

- (void)queryFinished:(NSNotification *)notification
{
    NSMetadataQuery *aQuery = [notification object];
    NSLog (@"%@", aQuery);
    
    // Check query for results and extract paths
    NSMutableArray *paths;
    if (aQuery) {
        NSInteger count = [aQuery resultCount];
        if (count>0) {
            paths = [NSMutableArray arrayWithCapacity:count];
            int i;
            for (i=0;i<count;i++) { // Fast enumeration not suitable here, see NSMetadataItem Documentation
                NSMetadataItem *item = [aQuery resultAtIndex:i];
                if (item) {
                    NSString *path = [item valueForAttribute:NSMetadataItemPathKey]; // vor 10.7: kMDItemPath
                    if (path) [paths addObject:path];
                }
            }
        }
        [aQuery stopQuery];
    }
    
    // Inform delegate
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(TIMAppLocatorProtocol)] && [self.delegate respondsToSelector:@selector(appLocations:)]) [self.delegate appLocations:paths];
}


-(BOOL)locateAppWithBundleIdentifier:(NSString*)bundleIdentifier
{
    if (!bundleIdentifier) return NO;
    if ([self.query isGathering]) return NO;
    
    // Prepare query
    self.query = [[NSMetadataQuery alloc] init]; // Allocate new instance every time, NSMetadataQuery is tricky 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(queryFinished:)
                                                 name:NSMetadataQueryDidFinishGatheringNotification
                                               object:self.query];
    [self.query setSearchScopes: [NSArray arrayWithObjects: NSMetadataQueryLocalComputerScope, nil]]; // Search everywhere
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"kMDItemCFBundleIdentifier = %@", bundleIdentifier];
    [self.query setPredicate:predicate];
    
    // Start Query
    [self.query startQuery];
    return YES;
}


@end
