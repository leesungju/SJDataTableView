//
//  SJDataTableViewCell.m
//  SJDataTableView
//
//  Created by LeeSungJu on 2015. 7. 31..
//  Copyright (c) 2015년 LeeSungJu. All rights reserved.
//

#import "SJDataTableViewCell.h"

@implementation SJDataTableViewCell
{
    UILabel *headLabel;
    UIView * bgView;
    NSMutableArray * labelArray;
    NSMutableArray * bgArray;
    CGSize itemSize;
    NSArray * keyArray;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        itemSize = size;
        keyArray = headerArray;
        labelArray = [NSMutableArray new];
        bgArray = [NSMutableArray new];
        [self setupLabel];
    }
    return self;
}

- (void)setupLabel
{
    for (int i = 0; i < [keyArray count]-1; i++)
    {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(i*itemSize.width, 0, itemSize.width, itemSize.height)];
        [self addSubview:bgView];
        
        headLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, bgView.frame.size.width - 40, bgView.frame.size.height - 20)];
        [headLabel setAdjustsFontSizeToFitWidth:YES];
        [bgView addSubview:headLabel];
        [labelArray addObject:headLabel];
        [bgArray addObject:bgView];
        
    }
}

-(void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    
    for (int i = 0; i < [labelArray count]; i++)
    {
        UILabel * tempLabel = [labelArray objectAtIndex:i];
        switch (i) {
            case 0:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i+1]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 1:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i+1]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 2:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i+1]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 3:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i+1]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 4:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i+1]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            default:
                break;
        }
    }
    
}

@end
