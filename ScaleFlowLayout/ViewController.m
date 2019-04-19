//
//  ViewController.m
//  ScaleFlowLayout
//
//  Created by slash on 2019/4/19.
//  Copyright © 2019 slash. All rights reserved.
//

#import "ViewController.h"
#import "ScaleFlowLayout.h"
#import "CollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
// <#type属性#>
@property (nonatomic, strong) NSMutableArray *dataSource;
// <#type属性#>
@property (nonatomic, strong) ScaleFlowLayout *layout;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ScaleFlowLayout *layout = [[ScaleFlowLayout alloc] init];
    self.layout = layout;
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.dataSource = [NSMutableArray array];
    NSArray *items = @[@1,@2,@3,@4];
    for (int i = 0; i < 50; i++) {
        [self.dataSource addObjectsFromArray:items];
    }
    [self scrollViewItemAtRow:4 section:0 animati0ned:NO];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.label.text = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row]];
    return cell;
}
- (void)scrollViewItemAtRow:(NSInteger)row section:(NSInteger)section animati0ned:(BOOL)animationed {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    
    [self.collectionView scrollToItemAtIndexPath:attrs.indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animationed];
    self.layout.previousOffsetX = row * 310;
}
@end
