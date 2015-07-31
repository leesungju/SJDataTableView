//
//  SJDataTableView.m
//  SJDataTableView
//
//  Created by LeeSungJu on 2015. 7. 31..
//  Copyright (c) 2015년 LeeSungJu. All rights reserved.
//

#import "SJDataTableView.h"

@interface SJDataTableView ()
{
    float headerTotalWidth;
}

@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) SJDataFixItemTableView * itemView;

@property (nonatomic, strong) NSArray * headerArray;
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, assign) CGFloat headerWidth;
@property (nonatomic, assign) CGFloat headerHeight;

@end

@implementation SJDataTableView


- (instancetype)initWithFrame:(CGRect)frame headerSize:(CGSize)size
{
    self = [super initWithFrame:frame];
    if(self){
        _headerWidth = size.width;
        _headerHeight = size.height;
    }
    return self;
}

- (void)setHeaderArray:(NSArray*)headerArray dataArray:(NSArray*)dataArray
{
    _headerArray = headerArray;
    _dataArray = dataArray;
    headerTotalWidth = _headerWidth * ([headerArray count]-1);
    [self setupViews];
}

- (void)reloadDataTable
{
    if(_contentView != nil){
        [_contentView removeFromSuperview];
        _contentView = nil;
        [self setupViews];
    }else{
        [self setupViews];
    }
}

- (void)setupViews
{
    if(_contentView == nil){
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 20)];
        [self addSubview:_contentView];
        
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, headerTotalWidth, _contentView.frame.size.height - 20) style:UITableViewStylePlain];
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView.bounces=NO;
        self.myTableView=tableView;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIScrollView *myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(_headerWidth - 20, 10, _contentView.frame.size.width - (_headerWidth - 20), _contentView.frame.size.height - 20)];
        [myScrollView addSubview:tableView];
        myScrollView.bounces=NO;
        [myScrollView setShowsHorizontalScrollIndicator:NO];
        myScrollView.contentSize=CGSizeMake(headerTotalWidth, 0);
        //        [myScrollView showBorder];
        [_contentView addSubview:myScrollView];
        
        NSString * headStr = [_headerArray objectAtIndex:0];
        self.itemView=[[SJDataFixItemTableView alloc]initWithFrame:CGRectMake(0, 10, _headerWidth - 20, _contentView.frame.size.height - 20) items:_dataArray headstr:headStr itemSize:CGSizeMake(_headerWidth, _headerHeight)];
        [self.itemView setScrollTableView:tableView];
        [self.itemView setDelegate:self];
        [_contentView addSubview:self.itemView];
    }
}

#pragma mark

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier=@"cell";
    if(indexPath.row == [_dataArray count]-1){
        cellIdentifier = @"lastCell";
    }
    SJDataTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[SJDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier
                                              itemSize:CGSizeMake(_headerWidth, _headerHeight)
                                           headerArray:_headerArray];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.dataDict=[_dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tableViewHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [_headerArray count]*_headerWidth, _headerHeight)];
    [tableViewHeadView setBackgroundColor:[UIColor whiteColor]];
    for(int i = 1 ; i < [_headerArray count] ; i++){
        UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake((i-1)*_headerWidth, 0, _headerWidth, _headerHeight)];
        [headLabel setText:[_headerArray objectAtIndex:i]];
        [headLabel setTextAlignment:NSTextAlignmentCenter];
        [tableViewHeadView addSubview:headLabel];
    }
    
    return tableViewHeadView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _headerHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _headerHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY= self.myTableView.contentOffset.y;
    CGPoint itemOffsetY=self.itemView.itemTableView.contentOffset;
    itemOffsetY.y=offsetY;
    self.itemView.itemTableView.contentOffset=itemOffsetY;
    if(offsetY==0){
        self.itemView.itemTableView.contentOffset=CGPointZero;
    }
}

#pragma mark - MSInventoryItemViewDelegate Methods

- (void)setSelectItemView:(UITableView *)tableViewCell indexPath:(NSIndexPath *)indexPath
{
    
}



@end
