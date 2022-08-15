//
//  musicList.swift
//  MusicApp_Swift
//
//  Created by AndyLin on 2022/7/25.
//

import Foundation

struct music{
    // 歌曲編號
    var musicNumber = ""
    // 音樂名稱
    var musicName = ""
    // 音樂圖片
    var musicImage = ""
    // 歌手
    var musicSinger = ""
    // 歌曲檔案名稱
    var musicFile = ""
}

var MusicList = [
    music(musicNumber: "0", musicName: "LoveIsACompass",musicImage: "LoveIsACompass",musicSinger: "Griff",musicFile: "LoveIsACompass"),music(musicNumber: "1",musicName: "暫時的記號",musicImage: "暫時的記號",musicSinger: "林俊傑",musicFile: "暫時的記號"),music(musicNumber: "2",musicName: "孤獨",musicImage: "孤獨",musicSinger: "鄧紫棋",musicFile: "孤獨"),music(musicNumber: "3",musicName: "慢冷",musicImage: "慢冷",musicSinger: "梁靜茹",musicFile: "慢冷"),music(musicNumber: "4",musicName: "逆光",musicImage: "逆光",musicSinger: "孫燕姿",musicFile: "逆光")
    ,music(musicNumber: "5",musicName: "i'm with you",musicImage: "i'm with you",musicSinger: "Avril Lavigne",musicFile: "i'm with you")
    ,music(musicNumber: "6",musicName: "Teenage Dream",musicImage: "Teenage Dream",musicSinger: "Katy Perry",musicFile: "Teenage Dream")
]


