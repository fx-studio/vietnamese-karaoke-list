//
//  ViewController.swift
//  DemoSQLiteKara
//
//  Created by Tien Le P. on 2/25/19.
//  Copyright © 2019 Tien Le P. All rights reserved.
//

import UIKit
import FMDB

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var limit = 10
    var index = 0
    var isLoadMore = true
    var songs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getListData()
    }
    
    func configUI() {
        title = "Karaoke"
    }
    
    func getListData() {
        SQLite.Song.query(index: index, limit: limit) { (result) in
            switch (result) {
            case .success(let songResult):
                if (songResult.songs.count > 0) {
                    self.songs.append(contentsOf: songResult.songs)
                    self.index += songResult.songs.count
                    self.isLoadMore = true
                    self.tableView.reloadData()
                } else {
                    self.isLoadMore = false
                }
                
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    @IBAction func addSongs(_ sender: Any) {
        if isLoadMore {
            getListData()
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let song = songs[indexPath.row]
        cell.textLabel?.text = "\(song.code) : \(song.title)"
        cell.detailTextLabel?.text = song.lyric
        return cell
    }
    
    
}

