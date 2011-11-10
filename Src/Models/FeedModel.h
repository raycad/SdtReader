//
//  FeedModel.h
//  SdtReader
//
//  Created by raycad on 10/27/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"

@interface FeedModel : NSObject {
    NSMutableArray  *m_feedList;    
}

- (BOOL)addFeed:(Feed *)feed;
- (Feed *)getFeedByPK:(FeedPK *)feedPK;

- (BOOL)removeFeedByPK:(FeedPK *)feedPK;
- (BOOL)removeFeedByIndex:(int)index;
- (BOOL)removeFeed:(Feed *)feed;

- (Feed *)feedAtIndex:(int)index;

- (BOOL)copyDataFrom:(FeedModel *)other;

- (FeedModel *)searchByTitle:(NSString *)searchText;

- (void)clear;

- (int)count;
@end
