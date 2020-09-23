//
//  ViewController.swift
//  Walkies
//
//  Created by Mayuko Inoue on 9/23/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    // This time, we'll declare avPlayer as an instance variable,
      // which means it exists as long as our view controller exists.
      var avPlayer: AVAudioPlayer!
    
    lazy var walkiesButton: WalkButton = {
        let walkiesButton = WalkButton()
        walkiesButton.backgroundColor = UIColor(named:"blue")
        walkiesButton.setImage(UIImage(named:"paw"), for: .normal)
        return walkiesButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAudio()
        
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
    
    private func setupAudio() {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playback)
            try session.setActive(true)
        } catch let error as NSError {
            print("Unable to activate audio session:  \(error.localizedDescription)")
        }
    }
    
    @objc private func didTapWalkies() {
        let audioFileURL = URL(fileURLWithPath: Bundle.main.path(forResource: randomAudioFile(), ofType: "mp3")!)
        
        do {
            avPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
            avPlayer.delegate = self
            avPlayer.prepareToPlay()
            avPlayer.play()
        }
        catch {
            print("error playing")
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

