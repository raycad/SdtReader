//
//  RssCategoryViewCell.m
//  SdtReader
//
//  Created by raycad on 11/6/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssCategoryViewCell.h"
#import "RateButton.h"

@implementation RssCategoryViewCell

@synthesize titleLabel          = m_titleLabel;
@synthesize indexLabel          = m_indexLabel;
@synthesize totalRssFeedsLabel  = m_totalRssFeedsLabel;
@synthesize thumbnailImageView  = m_thumbnailImageView;
@synthesize rssCategory         = m_rssCategory;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])) {
        // Initialization code
        m_titleLabel = [[UILabel alloc] init];
        m_titleLabel.textAlignment = UITextAlignmentLeft;
        //m_titleLabel.font = [UIFont fontNamesForFamilyName:@"font-family: Arial; font-size: 18px; font-weight: bold;"];
        m_titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
        
        /*m_indexLabel = [[UILabel alloc]init];
        m_indexLabel.textAlignment = UITextAlignmentRight;
        //m_indexLabel.font = [UIFont systemFontOfSize:10];
        m_indexLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 15px; font-weight: bold; font-style : italic;"];
        m_indexLabel.textColor = [UIColor blueColor];*/
        
        m_totalRssFeedsLabel = [[UILabel alloc] init];
        m_totalRssFeedsLabel.textAlignment = UITextAlignmentLeft;
        //m_totalRssFeedsLabel.font = [UIFont fontNamesForFamilyName:@"font-family: Arial; font-size: 13px; font-weight: bold; font-style : italic;"];
        m_totalRssFeedsLabel.font = [UIFont fontWithName:@"Arial" size:13];
        m_totalRssFeedsLabel.textColor = [UIColor blueColor];
        
        //m_thumbnailImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:m_titleLabel];
        //[self.contentView addSubview:m_indexLabel];
        [self.contentView addSubview:m_totalRssFeedsLabel];
        //[self.contentView addSubview:m_thumbnailImageView];  
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat leftBoundsX = contentRect.origin.x;
    CGFloat rightBoundsX = contentRect.size.width;
    CGRect frame;
    /*frame = CGRectMake(leftBoundsX+7, 5, 38, 38);
    m_thumbnailImageView.frame = frame;*/
    
    frame = CGRectMake(leftBoundsX+10, 8, contentRect.size.width - 80, 25);
    m_titleLabel.frame = frame;
    
    /*frame = CGRectMake(rightBoundsX-50, 18, 40, 20);
    m_indexLabel.frame = frame;*/
    
    frame = CGRectMake(leftBoundsX+10, 32, contentRect.size.width - 80, 20);
    m_totalRssFeedsLabel.frame = frame;
}

- (void)updateData
{
    if (!m_rssCategory)
        return;
    
    // Update data
    self.titleLabel.text = m_rssCategory.title;
    self.totalRssFeedsLabel.text = [NSString stringWithFormat:@"%d feed(s)", m_rssCategory.totalRssFeeds];
    //self.thumbnailImageView.image = [UIImage imageNamed:@"category32.png"];
}

@end