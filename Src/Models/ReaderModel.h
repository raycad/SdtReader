//
//  ReaderModel.h
//  SdtReader
//
//  Created by raycad on 11/5/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssFeedModel.h"
#import "RssCategoryModel.h"

@interface ReaderModel : NSObject {
    RssFeedModel        *m_rssFeedModel; 
    RssCategoryModel    *m_rssCategoryModel;
}

// Declare the singleton
+ (ReaderModel *)instance;

@property (nonatomic, retain) RssFeedModel      *rssFeedModel;
@property (nonatomic, retain) RssCategoryModel  *rssCategoryModel;

- (BOOL)initialize;

- (BOOL)addRssFeed:(RssFeed *)rssFeed;
- (BOOL)removeRssFeedByPK:(RssFeedPK *)rssFeedPK;
- (BOOL)removeRssFeedByIndex:(int)index;
- (BOOL)removeRssFeed:(RssFeed *)rssFeed;

- (BOOL)addRssCategory:(RssCategory *)rssCategory;
- (BOOL)removeRssCategoryByPK:(RssCategoryPK *)rssCategoryPK;
- (BOOL)removeRssCategoryByIndex:(int)index;
- (BOOL)removeRssCategory:(RssCategory *)rssCategory;
@end
