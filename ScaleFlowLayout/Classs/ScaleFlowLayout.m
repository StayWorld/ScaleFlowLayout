//
//  ScaleFlowLayout.m
//  ScaleFlowLayout
//
//  Created by slash on 2019/4/19.
//  Copyright © 2019 slash. All rights reserved.
//

#import "ScaleFlowLayout.h"

static NSInteger kLinePadding = 10;
static NSInteger kPageCardWidth = 300;
static NSInteger kPageCardHeight = 200;

@interface ScaleFlowLayout ()

@end

@implementation ScaleFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = kLinePadding;
    CGFloat width = (self.collectionView.frame.size.width - kPageCardWidth - kLinePadding * 2)/2;
    self.sectionInset = UIEdgeInsetsMake(0, kLinePadding + width, 0, kLinePadding + width);
    
    self.itemSize = CGSizeMake(kPageCardWidth, kPageCardHeight);
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    NSArray *attributes = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
    
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    
    CGFloat offset = CGRectGetMidX(visibleRect);
    
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attr, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat distance = offset - attr.center.x;
        
        CGFloat scaleForDistance = distance / self.itemSize.width;
        CGFloat scaleForCell = 1 + 0.2 * (1 - fabs(scaleForDistance));
        
        attr.transform3D = CATransform3DMakeScale(1, scaleForCell, 1);
        attr.zIndex = 1;
        
        CGFloat scaleForAlpha = 1 - fabsf(scaleForDistance) * 0.6;
        attr.alpha = scaleForAlpha;
    }];
    
    return attributes;
}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    NSLog(@"proposedContentOffset = @%f, velocity = @%f", proposedContentOffset.x, velocity.x);
    
    if (proposedContentOffset.x > self.itemSize.width / 3 + self.previousOffsetX) {
        self.previousOffsetX += kPageCardWidth + kLinePadding;
    } else if (proposedContentOffset.x < self.previousOffsetX - self.itemSize.width / 3) {
        self.previousOffsetX -= kPageCardWidth + kLinePadding;
    }
    
    proposedContentOffset.x = self.previousOffsetX;
    
    return proposedContentOffset;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
@end
