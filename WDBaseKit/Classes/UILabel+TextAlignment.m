//
//  UILabel+TextAlignment.m
//
//
//  Created by summer on 2017/9/14.
//  Copyright © 2017年 summer. All rights reserved.
//

#import "UILabel+TextAlignment.h"

@implementation UILabel(TextAlignment)

//有一行右对齐，有两行左对齐
-(void)AutoTextAlignmentWith:(CGSize)size CallBack:(void (^)(CGFloat textHeight))callback
{
	
	CGSize  labelsize =[self sizeThatFits:size];
	CGFloat height= labelsize.height;
	CGRect frame =self.frame;
	if (height<=22) {
		frame.size.height =22;
		self.frame =frame;
		[self setTextAlignment:NSTextAlignmentRight];
		height =22;
	}else{
		frame.size.height =height;
		self.frame =frame;
		[self setTextAlignment:NSTextAlignmentLeft];
	}
	if ([self.text isEqualToString:@""]) {
		self.text =@"无";
		[self setTextColor:[UIColor grayColor]];
	} else {
		[self setTextColor:[UIColor blackColor]];
	}
	callback(height);
}

@end
