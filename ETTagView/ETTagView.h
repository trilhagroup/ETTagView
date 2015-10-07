//
//  ETTagView.h
//  InEvent
//
//  Created by Pedro Góes on 7/16/15.
//  Copyright (c) 2015 Pedro G√≥es. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETTagView;

@protocol ETTagViewDelegate <NSObject>

@optional
- (void)tagView:(ETTagView *)tagView touchedButtonAtIndex:(NSInteger)buttonIndex matching:(BOOL)matching;

@end

@interface ETTagView : UIView

@property (strong, nonatomic) id<ETTagViewDelegate> delegate;

- (void)cleanPreviousTags;
- (CGRect)layoutTags:(NSArray *)tags colored:(BOOL)colored;
- (CGRect)layoutTags:(NSArray *)tags matchingTags:(NSArray *)matchingTags colored:(BOOL)colored;
- (CGRect)layoutTags:(NSArray *)tags colored:(BOOL)colored forMaximumSize:(NSInteger)maxSize canOverflow:(BOOL)overflow;
- (CGRect)layoutTags:(NSArray *)tags matchingTags:(NSArray *)matchingTags colored:(BOOL)colored forMaximumSize:(NSInteger)maxSize canOverflow:(BOOL)overflow;

@end
