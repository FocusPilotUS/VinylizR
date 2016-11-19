//
//  LoginViewController.swift
//  VinylizR
//
//  Created by Nathan Turner on 11/16/16.
//  Copyright © 2016 Nathan Turner. All rights reserved.
//

import Foundation
import AVFoundation

class LoginViewController: ViewController {
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadVideo()
    }
    
    private func loadVideo() {
        //this line is important to prevent background music stop
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch { }
        
        let path = Bundle.main.path(forResource: "recordspinning",
                                                         ofType:"mp4")
        
        player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.opacity = 0.5
        
        self.view.layer.addSublayer(playerLayer)
        
        player?.seek(to: kCMTimeZero)
        player?.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setVideoToStart), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
    
    func setVideoToStart() {
        player?.seek(to: kCMTimeZero)
    }
}
