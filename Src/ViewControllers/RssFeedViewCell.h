//
//  RssFeedViewCell.h
//  SdtReader
//
//  Created by raycad on 11/6/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssFeed.h"

@interface RssFeedViewCell : UITableViewCell {
    UILabel         *m_titleLabel;
    UILabel         *m_indexLabel;
    UIImageView     *m_thumbnailImageView;
    RssFeed         *m_rssFeed;
    
    NSMutableArray  *m_rateButtons;
}

@property (nonatomic, retain) UILabel     *titleLabel;
@property (nonatomic, retain) UILabel     *indexLabel;
@property (nonatomic, retain) UIImageView *thumbnailImageView;
@property (nonatomic, retain) RssFeed     *rssFeed;

- (void)setRateValue:(int)rateValue;
- (void)createRateButtons;
- (void)releaseRateButtons;
@end
