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
@synthesize categoryLabel       = m_categoryLabel;
@synthesize thumbnailImageView  = m_thumbnailImageView;
@synthesize rssFeed             = m_rssFeed;
@synthesize delegate            = m_delegate;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])) {
        // Initialization code
        m_titleLabel = [[UILabel alloc]init];
        m_titleLabel.textAlignment = UITextAlignmentLeft;
        m_titleLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 17px; font-weight: bold;"];
        
        /*m_indexLabel = [[UILabel alloc]init];
        m_indexLabel.textAlignment = UITextAlignmentRight;
        //m_indexLabel.font = [UIFont systemFontOfSize:10];
        m_indexLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 15px; font-weight: bold; font-style : italic;"];
        m_indexLabel.textColor = [UIColor blueColor];*/
        
        m_categoryLabel = [[UILabel alloc]init];
        m_categoryLabel.textAlignment = UITextAlignmentLeft;
        //m_indexLabel.font = [UIFont systemFontOfSize:10];
        m_categoryLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 13px; font-weight: bold; font-style : italic;"];
        m_categoryLabel.textColor = [UIColor brownColor];
        
        m_thumbnailImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:m_titleLabel];
        //[self.contentView addSubview:m_indexLabel];
        [self.contentView addSubview:m_categoryLabel];
        [self.contentView addSubview:m_thumbnailImageView];  
        
        [self createRateButtons];
        
        m_rateValue = -1;
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
    frame = CGRectMake(leftBoundsX+7, 13, 38, 38);
    m_thumbnailImageView.frame = frame;
    
    frame = CGRectMake(leftBoundsX+52, 1, 250, 25);
    m_titleLabel.frame = frame;
    
    /*frame = CGRectMake(rightBoundsX-50, 18, 40, 20);
    m_indexLabel.frame = frame;*/
    
    frame = CGRectMake(leftBoundsX+52, 23, 250, 20);
    m_categoryLabel.frame = frame;
}

- (void)createRateButtons
{
    [self releaseRateButtons];
    
    m_rateButtons = [[NSMutableArray alloc] init];
    
    double x = 52;
    double y = 42;
    int buttonSize = 20;
    int buttonSpace = 7;
    
    // Create new dynamic buttons
    for (int i = 0; i < 5; i++) {
        CGRect frame = CGRectMake(x, y, buttonSize, buttonSize);
        RateButton *rateButton = [[RateButton buttonWithType:UIButtonTypeCustom] retain];
        rateButton.frame = frame;
        //[rateButton setTitle:(NSString *)@"Rate" forState:(UIControlState)UIControlStateNormal];
        [rateButton addTarget:self action:@selector(rateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [rateButton setRateSize:Size24];
        [rateButton setState:UnRating];
        
        // Not allow user to click
        //[rateButton setUserInteractionEnabled:NO];
        
        rateButton.data = i;
        
        [self.contentView addSubview:rateButton];
        [m_rateButtons addObject:rateButton];
        
        x += buttonSize + buttonSpace;
    }
}

- (void)rateButtonClicked:(id)sender
{
    if (!sender || ![sender isKindOfClass:[RateButton class]])
        return;
    
    int rateValue = ((RateButton *)sender).data;
    [self setRateValue:rateValue];
    
    if (m_rssFeed) {
        m_rssFeed.rate = rateValue;
    }
    
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(didRateButtonClicked:)]) {
        [self.delegate didRateButtonClicked:self];
    }
    
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
    int rateButtonCount = [m_rateButtons count];
    
    if (rateValue < 0 || rateValue >= rateButtonCount) {
        RateButton *rateButton = nil;
        for (int i = 0; i < rateButtonCount; i++) {
            rateButton = (RateButton *)[m_rateButtons objectAtIndex:i];
            if (!rateButton)
                continue;
            [rateButton setState:UnRating];
        }
        
        return;
    }
    
    if (m_rateValue == rateValue && m_rateValue == 0) {
        RateButton *rateButton = (RateButton *)[m_rateButtons objectAtIndex:0];
        if (!rateButton)
            return;
        RateState rateState = [rateButton rateState];
        if (rateState == Rating) {
            // Rating = 0
            m_rateValue = -1;
            
            for (int i = 0; i < rateButtonCount; i++) {
                rateButton = (RateButton *)[m_rateButtons objectAtIndex:i];
                if (!rateButton)
                    continue;
                [rateButton setState:UnRating];
            }
            
            return;
        }        
    }
    
    if (m_rateValue == rateValue && m_rateValue == rateButtonCount-1) {
        RateButton *rateButton = (RateButton *)[m_rateButtons objectAtIndex:(rateButtonCount-1)];
        if (!rateButton)
            return;
        RateState rateState = [rateButton rateState];
        if (rateState == Rating) {
            // Rating = 0
            m_rateValue = -1;
            
            for (int i = 0; i < rateButtonCount; i++) {
                rateButton = (RateButton *)[m_rateButtons objectAtIndex:i];
                if (!rateButton)
                    continue;
                [rateButton setState:UnRating];
            }
            
            return;
        }        
    }
    
    if (m_rateValue == rateValue)
        return;
    
    int i = 0;
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
    
    m_rateValue = rateValue;
}

/*- (void)setRateValue:(int)rateValue
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
}*/

- (void)dealloc
{
    [self releaseRateButtons];
    
    [m_rssFeed release];
    [m_titleLabel release];
    [m_indexLabel release];
    [m_categoryLabel release];
    [m_thumbnailImageView release];
    [m_delegate release];
}
@end