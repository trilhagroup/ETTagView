//
//  ETTagView.m
//  InEvent
//
//  Created by Pedro Góes on 7/16/15.
//  Copyright (c) 2015 Pedro G√≥es. All rights reserved.
//

#import "ETTagView.h"
#import "NSString+Bounds.h"
#import "ETFlowView.h"
#import "UIColor+Hex.h"

@interface ETTagView ()

@property (nonatomic, retain) NSArray *tags;
@property (nonatomic, assign) BOOL colored;

@end

@implementation ETTagView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self configureView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (self) {
        // Initialization code
        [self configureView];
    }
}

#pragma mark - Configuration Methods

- (void)configureView {
    
}

#pragma mark - Initialization Methods

- (void)cleanPreviousTags {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (CGRect)layoutTags:(NSArray *)tags colored:(BOOL)colored {
    return [self layoutTags:tags colored:colored forMaximumSize:[tags count] canOverflow:YES];
}

- (CGRect)layoutTags:(NSArray *)tags matchingTags:(NSArray *)matchingTags colored:(BOOL)colored {
    return [self layoutTags:tags matchingTags:matchingTags colored:colored forMaximumSize:[tags count] canOverflow:YES];
}

- (CGRect)layoutTags:(NSArray *)tags colored:(BOOL)colored forMaximumSize:(NSInteger)maxSize canOverflow:(BOOL)overflow {
    return [self layoutTags:tags matchingTags:nil colored:colored forMaximumSize:maxSize canOverflow:overflow];
}

- (CGRect)layoutTags:(NSArray *)tags matchingTags:(NSArray *)matchingTags colored:(BOOL)colored forMaximumSize:(NSInteger)maxSize canOverflow:(BOOL)overflow {
    
    // Save for later
    _tags = tags;
    _colored = colored;
    
    // Clean up tags
    [self cleanPreviousTags];

    CGFloat currentX = 0.0f, currentY = 0.0f, padding = 12.0f, buttonHeight = 10.0f + padding;
    unsigned long numInteractions = MIN([tags count], maxSize);
    BOOL touchable = (matchingTags) ? YES : NO;
    
    // Assign tags to be compared
    if (!matchingTags) matchingTags = tags;
    
    for (int i = 0; i < numInteractions; i++) {
        
        // Define provided information
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button setTitle:[[[tags objectAtIndex:i] objectForKey:@"name"] uppercaseString] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        if (touchable) [button addTarget:self action:@selector(touchedButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i];
        
        // Background color
        [button.layer setBackgroundColor:[UIColor grayColor].CGColor];
            
        for (int j = 0; j < [matchingTags count]; j++) {
            if ([[[tags objectAtIndex:i] objectForKey:@"tagID"] isEqualToString:[[matchingTags objectAtIndex:j]objectForKey:@"tagID"]]) {
                if (colored) {
                    [button.layer setBackgroundColor:[self colorAtIndex:i].CGColor];
                }
                break;
            }
        }
        
        // Calculate the button width
        CGFloat calculatedWidth = [[button titleForState:UIControlStateNormal] getProbableWidthWithFont:button.titleLabel.font forHorizontalConstrain:self.frame.size.width] + padding;
        if (currentX + calculatedWidth >= self.frame.size.width) {
            currentX = 0.0f;
            currentY += buttonHeight + 10.0f;
        }
        
        // Break elements which overflow
        if (overflow == NO) {
            if (currentY + buttonHeight > self.frame.size.height) {
                break;
            }
        }
        
        // Append button to wrapper
        [button setFrame:CGRectMake(currentX, currentY, calculatedWidth, buttonHeight)];
        [button.layer setCornerRadius:button.frame.size.height * 0.2f];
        [button.layer setMasksToBounds:YES];
        [self addSubview:button];
        
        // Advance to the next element
        currentX += button.frame.size.width + 10.0f;
    }
    
    return CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, currentY + (numInteractions == 0 ? 0.0f : buttonHeight));
}

- (IBAction)touchedButton:(UIButton *)button {
    
    CGColorRef dictionaryColor = [self colorAtIndex:button.tag].CGColor;
    CGColorRef buttonColor = button.layer.backgroundColor;
    
    BOOL isMatching = CGColorEqualToColor(buttonColor, dictionaryColor);
    
    if (_colored) {
        if (!isMatching) {
            [button.layer setBackgroundColor:[self colorAtIndex:button.tag].CGColor];
        } else {
            [button.layer setBackgroundColor:[UIColor grayColor].CGColor];
        }
    }
    
    if ([_delegate respondsToSelector:@selector(tagView:touchedButtonAtIndex:matching:)]) {
        [_delegate tagView:self touchedButtonAtIndex:button.tag matching:!isMatching];
    }
}

- (UIColor *)colorAtIndex:(NSInteger)colorIndex {
    return [UIColor colorFromHexadecimalValue:[[_tags objectAtIndex:colorIndex] objectForKey:@"color"]];
}

@end
