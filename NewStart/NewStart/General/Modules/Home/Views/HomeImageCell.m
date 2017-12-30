//
//  HomeImageCell.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/30.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "HomeImageCell.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"

@interface HomeImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *hgImageView;

@end

@implementation HomeImageCell

- (void)setPhotoSTR:(NSString *)photoSTR {
    _photoSTR = photoSTR.copy;
    
    [self.hgImageView sd_setImageWithURL:_photoSTR.mj_url placeholderImage:[UIImage imageNamed:@"placeholderPNG"]];
}

@end
