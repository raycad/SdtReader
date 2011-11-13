//
//  StudentViewCell.m
//  SdtReader
//
//  Created by raycad on 11/6/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssFeedViewCell.h"
#import "RateButton.h"

@implementation RssFeedViewCell

@synthesize titleLabel          = m_titleLabel;
@synthesize indexLabel          = m_indexLabel;
@synthesize thumbnailImageView  = m_thumbnailImageView;
@synthesize rssFeed             = m_rssFeed;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])) {
        // Initialization code
        m_titleLabel = [[UILabel alloc]init];
        m_titleLabel.textAlignment = UITextAlignmentLeft;
        m_titleLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 18px; font-weight: bold;"];
        
        m_indexLabel = [[UILabel alloc]init];
        m_indexLabel.textAlignment = UITextAlignmentRight;
        //m_indexLabel.font = [UIFont systemFontOfSize:10];
        m_indexLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 15px; font-weight: bold; font-style : italic;"];
        m_indexLabel.textColor = [UIColor grayColor];
        
        m_thumbnailImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:m_titleLabel];
        [self.contentView addSubview:m_indexLabel];
        [self.contentView addSubview:m_thumbnailImageView];  
        
        [self createRateButtons];
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
    frame = CGRectMake(leftBoundsX+7, 5, 38, 38);
    m_thumbnailImageView.frame = frame;
    
    frame = CGRectMake(leftBoundsX+52, 3, 170, 25);
    m_titleLabel.frame = frame;
    
    frame = CGRectMake(rightBoundsX-50, 18, 40, 20);
    m_indexLabel.frame = frame;    
}

- (void)createRateButtons
{
    [self releaseRateButtons];
    
    m_rateButtons = [[NSMutableArray alloc] init];
    
    double x = 52;
    double y = 30;
    
    // Create a new dynamic buttons
    for (int i = 0; i < 5; i++) {
        CGRect frame = CGRectMake(x, y, 16, 16);
        RateButton *rateButton = [[RateButton buttonWithType:UIButtonTypeCustom] retain];
        rateButton.frame = frame;
        //[rateButton setTitle:(NSString *)@"Rate" forState:(UIControlState)UIControlStateNormal];
        [rateButton addTarget:self action:@selector(rateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [rateButton setRateSize:Size16];
        [rateButton setState:UnRating];
        
        // Not allow user to click
        [rateButton setUserInteractionEnabled:NO];
        
        rateButton.data = i;
        
        [self.contentView addSubview:rateButton];
        [m_rateButtons addObject:rateButton];
        
        x += 22;
    }
}

- (void)rateButtonClicked:(id)sender
{
    if (!sender || ![sender isKindOfClass:[RateButton class]])
        return;
    
    int rateValue = ((RateButton *)sender).data;
    [self setRateValue:rateValue];
    
    NSLog(@"new button clicked!!! %d", rateValue);
}

- (void)releaseRateButtons
{
    if (m_rateButtons) {
        for (int i = 0; i < [m_rateButtons count]; i++) {
            id rateButton = [m_rateButtons objectAtIndex:i];
            if (rateButton) {
                [rateButton release];
                rateButton = nil;
            }
        }        
    }
    
    [m_rateButtons removeAllObjects];
    [m_rateButtons release];
}

- (void)setRateValue:(int)rateValue
{
    int i = 0;
    int rateButtonCount = [m_rateButtons count]; 
    
    if (rateValue < 0 || rateValue >= rateButtonCount) {
        RateButton *rateButton = nil;
        for (i = 0; i < rateButtonCount; i++) {
            rateButton = (RateButton *)[m_rateButtons objectAtIndex:i];
            if (!rateButton)
                continue;
            [rateButton setState:UnRating];
        }
        
        return;
    }    
    
    RateButton *rateButton = nil;
    for (i = 0; i <= rateValue; i++) {
        rateButton = (RateButton *)[m_rateButtons objectAtIndex:i];
        if (!rateButton)
            continue;
        [rateButton setState:Rating];
    }
    
    for (i = rateValue+1; i < rateButtonCount; i++) {
        rateButton = (RateButton *)[m_rateButtons objectAtIndex:i];
        if (!rateButton)
            continue;
        [rateButton setState:UnRating];
    }
}

- (void)dealloc
{
    [self releaseRateButtons];
    
    [m_rssFeed release];
    [m_titleLabel release];
    [m_indexLabel release];
    [m_thumbnailImageView release];
}
@end