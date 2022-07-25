//
//  MusciPlayController.swift
//  MusicApp_Swift
//
//  Created by AndyLin on 2022/7/24.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func playAction(_ sender: Any) {
        print("Play")
    }
    
    @IBAction func backAction(_ sender: Any) {
        
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
    }
    
    @IBAction func repeatAction(_ sender: Any) {
        
    }
    
    @IBAction func shuffleAction(_ sender: Any) {
        
    }
    
    @IBAction func playTimeChange(_ sender: Any) {
        
    }
    
    @IBAction func volumeChange(_ sender: Any) {
        
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
