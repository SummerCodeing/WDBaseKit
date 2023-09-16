//
//  PlayMusic.m
//  
//
//  Created by summer on 2018/1/10.
//  Copyright © 2018年 summer. All rights reserved.
//

#import "PlayMusic.h"
#import <AVKit/AVKit.h>
static PlayMusic *musicPlay;
@interface PlayMusic()
@property(nonatomic,strong)NSMutableDictionary *playerDict;///<播放器存储
@end
@implementation PlayMusic
///<生成一个实例
+(instancetype)shareInstance
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		musicPlay =[[self alloc] init];
	});
	return musicPlay;
}
//播放一个音乐
-(void)playMusicWithName:(NSString *)musicName repeat:(NSInteger)count
{
	
	if (musicName) {
		if (!_playerDict) {
			_playerDict =[NSMutableDictionary dictionary];
		}
		//1.0 创建播放器
		AVAudioPlayer *player =nil;
		//2.0从字典中取出player
		if ([_playerDict.allKeys containsObject:musicName]) {
			player =[_playerDict objectForKey:musicName];
		}
		if (player==nil) {
			//2.1 获取对应音乐资源
			NSURL *url = [[NSBundle mainBundle] URLForResource:musicName withExtension:nil];
			if (url==nil) {
				return;
			}
			//2.2创建播放器
			player =[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
			if (player) {
				player.numberOfLoops=count;///<重复次数
				//2.3 存储播放器
				[_playerDict setObject:player forKey:musicName];
				//2.4 准备播放
				[player prepareToPlay];
			}
		}
		
	    //3.0 播放
		[player play];
	}
}
///暂停
-(void)pauseMusicWithName:(NSString *)musicName
{
	if (musicName) {
		//1.0 取出音乐对应的播放器
		if ([_playerDict.allKeys containsObject:musicName]) {
			AVAudioPlayer *player =[_playerDict objectForKey:musicName];
			//2.0 播放
			if (player) {
				[player pause];
			}
		}
		
	}
}
///停止
-(void)stopMusicWithName:(NSString *)musicName
{
	if (musicName) {
		//1.0 取出音乐对应的播放器
		if ([_playerDict.allKeys containsObject:musicName]) {
			AVAudioPlayer *player =[_playerDict objectForKey:musicName];
			//2.0 停止
			if (player) {
				[player stop];
				[_playerDict removeObjectForKey:musicName];
				player =nil;
			}
		}
		
	}
}
///<清除数据
+(void)destroyPlayers
{
	for (AVAudioPlayer *player in musicPlay.playerDict.allValues) {
		[player stop];
	}
	[musicPlay.playerDict removeAllObjects];
	musicPlay.playerDict =nil;
}
@end
