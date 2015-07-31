//
//  SJDataFixItemTableView.m
//  SJDataTableView
//
//  Created by LeeSungJu on 2015. 7. 31..
//  Copyright (c) 2015년 LeeSungJu. All rights reserved.
//

#import "SJDataFixItemTableView.h"

@interface SJDataFixItemTableView()<UITableViewDataSource,UITableViewDelegate>
{
    CGSize itemSize;
}
@property (nonatomic, strong) NSArray * items;
@property (nonatomic, strong) UILabel * label;
@end

@implementation SJDataFixItemTableView

- (id)initWithFrame:(CGRect)frame items:(NSArray*)items headstr:(NSString*)headstr itemSize:(CGSize)size
{
    self = [super initWithFrame:frame];
    if (self) {
        itemSize = size;
        _items = items;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, size.height)];
        [self.label setTextAlignment:NSTextAlignmentCenter];
        [self.label setText:headstr];
        [self addSubview:self.label];
        
        self.itemTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.label.frame.origin.y
                                                                         + self.label.frame.size.height, self.frame.size.width, self.frame.size.height - itemSize.height) style:UITableViewStylePlain];
        [self.itemTableView setContentSize:CGSizeMake(self.frame.size.width, size.height * [items count])];
        self.itemTableView.delegate=self;
        self.itemTableView.dataSource=self;
        [self.itemTableView setShowsVerticalScrollIndicator:NO];
        [self.itemTableView setBounces:NO];
        [self addSubview: self.itemTableView];
        [self.itemTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return itemSize.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell.textLabel setText:[[self.items objectAtIndex:indexPath.row] objectForKey:_label.text]];
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_delegate respondsToSelector:@selector(setSelectItemView:indexPath:)]){
        [_delegate setSelectItemView:tableView indexPath:indexPath];
    }
}

#pragma mark - UIScrollViewDelegate Methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY= self.itemTableView.contentOffset.y;
    CGPoint itemOffsetY=self.scrollTableView.contentOffset;
    itemOffsetY.y=offsetY;
    self.scrollTableView.contentOffset=itemOffsetY;
    if(offsetY==0){
        self.scrollTableView.contentOffset=CGPointZero;
    }
}


@end
