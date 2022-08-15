//
//  songListViewController.swift
//  MusicApp_Swift
//
//  Created by AndyLin on 2022/7/26.
//

import UIKit

class songListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var songListTableView: UITableView!
    
    //讀取音樂資料
    var myMusic = MusicList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定 TableView delegate
        songListTableView.delegate = self
        songListTableView.dataSource = self
        
        // 設定 TableView Header
        self.setTableViewHeader()
        
        let nib = UINib(nibName: "songListTableViewCell", bundle: nil)
        songListTableView.register(nib, forCellReuseIdentifier: "songListTableViewCell")
        songListTableView.frame.size.height = songListTableView.rowHeight * CGFloat(myMusic.count)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(musicTableViewCell.self)",for: indexPath) as! musicTableViewCell
        cell.musicImageView.image = UIImage(named: myMusic[indexPath.row].musicImage)
        cell.musicNameLabel.text = myMusic[indexPath.row].musicName
        cell.singerLabel.text = myMusic[indexPath.row].musicSinger
        return cell
    }
    
    // 設定 TableView Header
    func setTableViewHeader(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.songListTableView.frame.width - 100, height: self.songListTableView.frame.width - 100))
        let imageView = UIImageView(frame: CGRect(x: 50, y: 0, width: self.songListTableView.frame.width - 100, height: self.songListTableView.frame.width - 100))
        imageView.image = UIImage(named: "music1")
        
        headerView.backgroundColor = UIColor.black
        headerView.addSubview(imageView)
        self.songListTableView.tableHeaderView = headerView
    }
    
    @IBSegueAction func PlayViewSegueAction(_ coder: NSCoder) -> MusciPlayController? {
        
        guard let row = songListTableView.indexPathForSelectedRow?.row else { return nil}
        return MusciPlayController(coder: coder,musicList: myMusic[row])
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
