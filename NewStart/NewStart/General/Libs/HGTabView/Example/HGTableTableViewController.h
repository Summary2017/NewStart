//
//  HGTableTableViewController.h
//  HGTabView
//
//  Created by  ZhuHong on 16/3/26.
//  Copyright © 2016年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGTableTableViewController;

@protocol HGTableTableViewControllerDelegate <NSObject>

- (void)didSelectItem:(NSString*)text;

@end


@interface HGTableTableViewController : UITableViewController

@property (nonatomic, weak) id<HGTableTableViewControllerDelegate> delegate;

@end
