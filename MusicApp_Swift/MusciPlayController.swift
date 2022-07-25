//
//  MusciPlayController.swift
//  MusicApp_Swift
//
//  Created by AndyLin on 2022/7/24.
//

import UIKit
import AVFoundation

class MusciPlayController: UIViewController {

    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var playTimeSlider: UISlider!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    let player = AVPlayer()
    var playerItem:AVPlayerItem!
    
    var musicIndex = 0 // 目前音樂曲目
    var shuffleIndex = false // 隨機撥放是否被開啟
    
    @IBAction func playAction(_ sender: Any) {
        print("Play")
        playMusic()
    }
    
    @IBAction func backAction(_ sender: Any) {
        
    }
    
    @IBAction func nextAction(_ sender: Any) {
        playNextSound()
    }
    
    @IBAction func repeatAction(_ sender: Any) {
        
    }
    
    @IBAction func shuffleAction(_ sender: Any) {
        
    }
    
    @IBAction func playTimeChange(_ sender: UISlider) {
        let changeTime = Int64(sender.value)
        let time:CMTime = CMTimeMake(value: changeTime, timescale: 1)
        player.seek(to: time)
        print("sender.value\(sender.value)")
        print("sender.maximumValue\(sender.maximumValue)")
    }
    
    
    @IBAction func volumeChange(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        playMusic()
        updateUI()
        nowPlayTime()
        updateMusicTime()
        // Do any additional setup after loading the view.
    }
    
    //播放音樂
    func playMusic() {
        let fileUrl = Bundle.main.url(forResource: musicList[musicIndex].musicFile, withExtension: "mp3")!
                let playerItem = AVPlayerItem(url: fileUrl)
                player.replaceCurrentItem(with: playerItem)
                player.play()
    }
    
    //更新歌曲、歌手、畫面圖片
    func updateUI() {
        musicNameLabel.text = musicList[musicIndex].musicName
        singerNameLabel.text = musicList[musicIndex].musicSinger
        musicImageView.image = UIImage(named: musicList[musicIndex].musicImage)
    }
    
    //播放下一首歌 musicIndex是musiclist裡的
    func playNextSound() {
        if shuffleIndex {
            musicIndex = Int.random(in: 0...musicList.count - 1)
            updateUI()
            playMusic()
            //updateMusicUI()
        }else{
            musicIndex += 1
            if musicIndex < musicList.count {
                updateUI()
                playMusic()
                //updateMusicUI()
            }else{
                musicIndex = 0
                updateUI()
                playMusic()
                //updateMusicUI()
            }
            
        }
    }
    
    //歌曲播放時間
    //更新歌曲時確認歌的時間讓Slider也更新
    func updateMusicTime() {
        guard let timeduration = playerItem?.asset.duration else{
            return
        }
        print("time\(timeduration)")
    let seconds = CMTimeGetSeconds(timeduration)
        endTimeLabel.text = timeShow(time:seconds)
        playTimeSlider.minimumValue = 0
        playTimeSlider.maximumValue = Float(seconds)
        playTimeSlider.isContinuous = true
        print("second:\(seconds)")
 
    }
    
    //顯示播放幾秒func
    func timeShow(time:Double) -> String {
        //同時得到商和餘數
        let time = Int(time).quotientAndRemainder(dividingBy: 60)
        let timeString = ("\(String(time.quotient)) : \(String(format: "%02d", time.remainder))")
        return timeString
    }
    
    //    播放幾秒的Func 不懂
    func nowPlayTime(){
    //        播放的計數器從1開始每一秒都在播放
    player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: { (CMTime) in
    //          如果音樂要播放
    if self.player.currentItem?.status == .readyToPlay{
    //                就會得到player播放的時間
    let currenTime = CMTimeGetSeconds(self.player.currentTime())
    //                Slider移動就會等於currenTime的時間
    self.playTimeSlider.value = Float(currenTime)
    //                顯示播放了幾秒
    self.startTimeLabel.text = self.timeShow(time: currenTime)
    }
    })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
