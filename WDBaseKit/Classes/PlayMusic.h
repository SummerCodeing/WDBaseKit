//
//  PlayMusic.h
//  XJKHealth
//
//  Created by summer on 2018/1/10.
//  Copyright © 2018年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayMusic : NSObject
///<生成一个实例
+(instancetype)shareInstance;
///<播放一个音乐  设置重复次数
-(void)playMusicWithName:(NSString *)musicName repeat:(NSInteger)count;
///<暂停
-(void)pauseMusicWithName:(NSString *)musicName;
///<停止
-(void)stopMusicWithName:(NSString *)musicName;
///<清除所以播放器
+(void)destroyPlayers;
@end
