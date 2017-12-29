//
//  SetupSignatureCell.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "BaseCell.h"
@class SetupSignatureCell;

@protocol SetupSignatureCellDelegate <NSObject>

// 代码
- (void)setupSignatureCell:(SetupSignatureCell*)cell didChangedValue:(NSString*)value;

@end

@interface SetupSignatureCell : BaseCell

@property (nonatomic, weak) id<SetupSignatureCellDelegate> delegate;
@property (nonatomic, copy) NSString* signatureTEXT;

@end
