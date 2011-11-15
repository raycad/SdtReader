//
//  RssFeedViewCell.h
//  SdtReader
//
//  Created by raycad on 11/6/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssFeed.h"

@protocol RssFeedViewCellDelegate;
@interface RssFeedViewCell : UITableViewCell {    
    UILabel         *m_titleLabel;
    UILabel         *m_indexLabel;
    UILabel         *m_categoryLabel;
    UIImageView     *m_thumbnailImageView;
    RssFeed         *m_rssFeed;
    
    NSMutableArray  *m_rateButtons;
    
    int             m_rateValue;
    
    id<RssFeedViewCellDelegate>   m_delegate;
}

@property (nonatomic, retain) UILabel     *titleLabel;
@property (nonatomic, retain) UILabel     *indexLabel;
@property (nonatomic, retain) UILabel     *categoryLabel;
@property (nonatomic, retain) UIImageView *thumbnailImageView;
@property (nonatomic, retain) RssFeed     *rssFeed;

@property (nonatomic, retain)id<RssFeedViewCellDelegate> delegate;

- (void)setRateValue:(int)rateValue;
- (void)createRateButtons;
- (void)releaseRateButtons;
@end

@protocol RssFeedViewCellDelegate <NSObject>
@required
- (void)didRateButtonClicked:(NSObject *)object;
@end
