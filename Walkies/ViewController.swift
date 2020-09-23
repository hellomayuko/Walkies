//
//  ViewController.swift
//  Walkies
//
//  Created by Mayuko Inoue on 9/23/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    lazy var walkiesButton: WalkButton = {
        let walkiesButton = WalkButton()
        walkiesButton.backgroundColor = UIColor(named:"blue")
        walkiesButton.setImage(UIImage(named:"paw"), for: .normal)
        return walkiesButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.walkiesButton.addTarget(self, action: #selector(didTapWalkies), for: .touchUpInside)
        
        self.view.backgroundColor = UIColor(named: "yellow")
        self.view.addSubview(walkiesButton)
        
        walkiesButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            walkiesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            walkiesButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            walkiesButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8),
            walkiesButton.widthAnchor.constraint(equalTo: walkiesButton.heightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func didTapWalkies() {
        let audioFileURL = URL(fileURLWithPath: Bundle.main.path(forResource: randomAudioFile(), ofType: "mp3")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            let player = try AVAudioPlayer(contentsOf: audioFileURL, fileTypeHint: AVFileType.m4a.rawValue)
            player.play()
            print("PLAYING::::: \(audioFileURL)")
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func randomAudioFile() -> String {
        let audioFiles = [
            "i_really_need_to_go_outside",
            "i_wanna_walkies",
            "walkies_now",
            "walkies_please",
            "wheres_my_walkies"
        ]
        
        let random = Int.random(in: 0..<5)
        
        return audioFiles[random]
    }
}

