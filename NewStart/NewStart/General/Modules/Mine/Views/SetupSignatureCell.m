//
//  SetupSignatureCell.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "SetupSignatureCell.h"
#import "UITextView+HG.h"

@interface SetupSignatureCell () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (nonatomic, assign) NSInteger maxCount;

@end

@implementation SetupSignatureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView.textContainerInset = UIEdgeInsetsMake(10.0, 6.5, 0, 0);
    self.maxCount = 30;
    
}


- (void)setSignatureTEXT:(NSString *)signatureTEXT {
    _signatureTEXT = signatureTEXT.copy;
    
    self.placeholderLabel.hidden = (signatureTEXT.length > 0);
    self.countLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.signatureTEXT.length, self.maxCount];
    
    self.textView.text = self.signatureTEXT;
}

- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    
    self.countLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.signatureTEXT.length, self.maxCount];
}

#pragma mark -
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) {
        return YES;
    }
    
    { // 高亮处理
        UITextRange *selectedRange = [textView markedTextRange];
        // positionFromPosition 获取以from为基准偏移offset的光标位置。
        // 在给定的偏移量返回另一个文本位置的文本位置。
        UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
        // 如果在变化中是高亮部分在变，就不要计算字符了
        if (selectedRange && pos) {
            return YES;
        }
        
    }
    
    NSString* resultSTR = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    DLog(@"即将要输入的 %@", resultSTR);
    
    if (resultSTR.length > self.maxCount) {
        return NO;
    }
    
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView {
    // 必须要在这里弄.
    self.placeholderLabel.hidden = (textView.text.length > 0);;
    
    { // 高亮处理
        // 如果在变化中是高亮部分在变，就不要计算字符了
        if (textView.hg_isHighLighted) {
            return ;
        }
        
    }
    
    if (textView.text.length > self.maxCount) {
        [textView hg_invalidTextFieldCurContent:self.signatureTEXT];
        return;
    }
    
    // 代理
    if (self.delegate && [self.delegate respondsToSelector:@selector(setupSignatureCell:didChangedValue:)]) {
        [self.delegate setupSignatureCell:self didChangedValue:textView.text];
    }
    
    // 保留
    _signatureTEXT = textView.text;
    
    self.countLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.signatureTEXT.length, self.maxCount];
}

@end
