//
//  iOSCodeVCDataSource.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/20.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "iOSCodeVCDataSource.h"

@interface iOSCodeVCDataSource()

@end


@implementation iOSCodeVCDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    return cell;
}

@end
