//
//  RssCategoryViewCell.h
//  SdtReader
//
//  Created by raycad on 11/6/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssCategory.h"

@interface RssCategoryViewCell : UITableViewCell {    
    UILabel         *m_titleLabel;
    UILabel         *m_indexLabel;
    UILabel         *m_totalRssFeedsLabel;
    UIImageView     *m_thumbnailImageView;
    RssCategory     *m_rssCategory;
}

@property (nonatomic, retain) UILabel     *titleLabel;
@property (nonatomic, retain) UILabel     *indexLabel;
@property (nonatomic, retain) UILabel     *totalRssFeedsLabel;
@property (nonatomic, retain) UIImageView *thumbnailImageView;
@property (nonatomic, retain) RssCategory *rssCategory;

- (void)updateData;
@end