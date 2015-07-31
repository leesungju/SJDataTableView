//
//  SJDataFixItemTableView.h
//  SJDataTableView
//
//  Created by LeeSungJu on 2015. 7. 31..
//  Copyright (c) 2015년 LeeSungJu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SJDataFixItemTableViewDelegate <NSObject>

- (void)setSelectItemView:(UITableView*)tableViewCell indexPath:(NSIndexPath*)indexPath;

@end

@interface SJDataFixItemTableView : UIView

@property (nonatomic, strong) UITableView * itemTableView;
@property (nonatomic, strong) UITableView * scrollTableView;
@property (nonatomic,assign) id<SJDataFixItemTableViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame items:(NSArray*)items headstr:(NSString*)headstr itemSize:(CGSize)size;

@end
