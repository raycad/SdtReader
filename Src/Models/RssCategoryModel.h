//
//  RssCategoryModel.h
//  SdtReader
//
//  Created by raycad on 10/27/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssCategory.h"

@interface RssCategoryModel : NSObject {
    NSMutableArray  *m_rssCategoryList;    
}

- (BOOL)addRssCategory:(RssCategory *)rssCategory;
- (RssCategory *)getRssCategoryByPK:(RssCategoryPK *)rssCategorydPK;

- (BOOL)removeRssCategoryByPK:(RssCategoryPK *)rssCategoryPK;
- (BOOL)removeRssCategoryByIndex:(int)index;
- (BOOL)removeRssCategory:(RssCategory *)rssCategory;

- (void)setValue:(RssCategory *)rssCategory atIndex:(int)index;
- (void)swapValueBetweenIndex:(int)firstIndex andIndex:(int)secondIndex;

- (RssCategory *)rssCategoryAtIndex:(int)index;

- (BOOL)copyDataFrom:(RssCategoryModel *)other;

- (RssCategoryModel *)searchByTitle:(NSString *)searchText;

- (RssCategory *)getCategoryById:(int)id;

- (void)clear;

- (int)count;
@end
