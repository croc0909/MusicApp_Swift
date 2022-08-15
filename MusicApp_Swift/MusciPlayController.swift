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
    
    let musicPlayList: music
    
    let player = AVPlayer()
    var playerItem:AVPlayerItem!
    var asset:AVAsset?

    var musicIndex = 0 // 目前音樂曲目
    var playMusicBool = false //目前是播放或暫停
    var shuffleBool = false // 隨機撥放是否開啟
    var repeatBool = false // 重複播放是否開啟
    
    
    init?(coder: NSCoder, musicList: music) {
        self.musicPlayList = musicList
        //print("musicPlayList \(musicPlayList)")
        // 將傳過來的歌曲編號帶入
        let indexInt = Int(self.musicPlayList.musicNumber) ?? 0
        musicIndex = indexInt
        super.init(coder: coder)
    }
         required init?(coder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    func initialization(){
        playMusic()
        updateUI()
        updateMusicTime()
        nowPlayTime()
        musicEnd()
        repeatButton.setImage(setbuttonImage(systemName: "repeat.circle", pointSize: 20), for: .normal)
        shuffleButton.setImage(setbuttonImage(systemName: "shuffle.circle", pointSize: 20), for: .normal)
        playButton.setImage(setbuttonImage(systemName: "pause.fill", pointSize: 30), for: .normal)
        nextButton.setImage(setbuttonImage(systemName: "forward.end.fill", pointSize: 30), for: .normal)
        backButton.setImage(setbuttonImage(systemName:"backward.end.fill" , pointSize: 30), for: .normal)
    }
    
    @IBAction func playAction(_ sender: Any) {
        playOrPauseMusic()
    }
    
    @IBAction func backAction(_ sender: Any) {
        playPreviousSound()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        playNextSound()
    }
    
    @IBAction func repeatAction(_ sender: Any) {
        chackRepeat()
    }
    
    @IBAction func shuffleAction(_ sender: Any) {
        checkShuffle()
    }
    
    @IBAction func playTimeChange(_ sender: UISlider) {
        let changeTime = Int64(sender.value)
        let time:CMTime = CMTimeMake(value: changeTime, timescale: 1)
        player.seek(to: time)
        print("sender.value\(sender.value)")
        print("sender.maximumValue\(sender.maximumValue)")
    }
    
    @IBAction func volumeChange(_ sender: UISlider) {
        player.volume = volumeSlider.value
    }
    
    
    //播放音樂
    func playMusic() {
        print("player.pause")
        let fileUrl = Bundle.main.url(forResource: MusicList[musicIndex].musicFile, withExtension: "mp3")!
        playerItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    // 停止播放音樂
    func stopMusic(){
        // 停止 player 音樂
        player.replaceCurrentItem(with: nil)
        print("STOP Music")
    }
    
    //更新歌曲、歌手、畫面圖片
    func updateUI() {
        musicNameLabel.text = MusicList[musicIndex].musicName
        singerNameLabel.text = MusicList[musicIndex].musicSinger
        musicImageView.image = UIImage(named: MusicList[musicIndex].musicImage)
    }
    
    //播放下一首歌 musicIndex是musiclist裡的
    func playNextSound() {
        if shuffleBool {
            musicIndex = Int.random(in: 0...MusicList.count - 1)
            updateUI()
            playMusic()
            updateMusicTime()
        }else{
            musicIndex += 1
            if musicIndex < MusicList.count {
                updateUI()
                playMusic()
                updateMusicTime()
            }else{
                musicIndex = 0
                updateUI()
                playMusic()
                updateMusicTime()
            }
        }
    }
    
    //播放上一首歌 musicIndex是musiclist裡的
    func playPreviousSound() {
        if shuffleBool {
            musicIndex = Int.random(in: 0...MusicList.count - 1)
            updateUI()
            playMusic()
            updateMusicTime()
        }else{
            if musicIndex != 0{
                musicIndex -= 1
                if musicIndex < MusicList.count {
                    updateUI()
                    playMusic()
                    updateMusicTime()
                }else{
                    musicIndex = 0
                    updateUI()
                    playMusic()
                    updateMusicTime()
                }
            }else
            {
                musicIndex = MusicList.count - 1
                updateUI()
                playMusic()
                updateMusicTime()
            }
        }
    }
    
    //歌曲播放時間 更新歌曲時確認歌的時間讓Slider也更新
    func updateMusicTime() {
        print("updateMusicTime")
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
    
    // 播放幾秒的Func
    func nowPlayTime(){
    // 播放的計數器從1開始每一秒都在播放
    player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: { (CMTime) in
    // 如果音樂要播放
    if self.player.currentItem?.status == .readyToPlay{
    // 取得player播放每秒的時間
    let currenTime = CMTimeGetSeconds(self.player.currentTime())
    // Slider移動就會等於currenTime的時間
    self.playTimeSlider.value = Float(currenTime)
    // 顯示播放了幾秒
    self.startTimeLabel.text = self.timeShow(time: currenTime)
    }
    })
    }
    
    //設定Button圖示大小跟圖案
    func setbuttonImage(systemName:String,pointSize:Int) -> UIImage? {
        let sfsymbol = UIImage.SymbolConfiguration(pointSize: CGFloat(pointSize), weight: .bold , scale: .large )
        let sfsymbolImage = UIImage(systemName: systemName, withConfiguration: sfsymbol)
        return sfsymbolImage
        
    }
    
    //確認音樂結束
    func musicEnd(){
    // 使用  NotificationCenter.default.addObserver來確認音樂是否結束
    NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { (_) in
    //  樂播放結束有開起 repeatBool 就會從頭播放
    if self.repeatBool{
    let musicEndTime: CMTime = CMTimeMake(value: 0, timescale: 1)
    self.player.seek(to: musicEndTime)
    self.player.play()
    }else{
    // 如果結束沒有打開repeatBool就會撥下一首歌
    self.playNextSound()
    }
    }
    }
    
    //暫停音樂或播放音樂
    func playOrPauseMusic()
    {
        if !playMusicBool {
            playMusicBool = true
            player.pause()
            playButton.setImage(setbuttonImage(systemName: "play.fill", pointSize: 30), for: .normal)
        }else{
            playMusicBool = false
            player.play()
            playButton.setImage(setbuttonImage(systemName: "pause.fill", pointSize: 30), for: .normal)
        }
    }
    
    //檢查是否隨機播放
    func checkShuffle()
    {
        if !shuffleBool{
            shuffleBool = true
            shuffleButton.setImage(setbuttonImage(systemName: "shuffle.circle.fill", pointSize: 20), for: .normal)
        }else{
            shuffleBool = false
            shuffleButton.setImage(setbuttonImage(systemName: "shuffle.circle", pointSize: 20), for: .normal)
        }
    }
    
    //檢查是否重複播放
    func chackRepeat()
    {
        if !repeatBool{
            repeatBool = true
            repeatButton.setImage(setbuttonImage(systemName: "repeat.circle.fill", pointSize: 20), for: .normal)
        }else
        {
            repeatBool = false
            repeatButton.setImage(setbuttonImage(systemName: "repeat.circle", pointSize: 20), for: .normal)
        }
    }
    
    // 換頁時
    override func viewWillDisappear(_ animated: Bool) {
        self.stopMusic()
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
