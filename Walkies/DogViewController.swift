//
//  ViewController.swift
//  Walkies
//
//  Created by Mayuko Inoue on 9/23/20.
//

import UIKit
import AVFoundation
import Firebase

class DogViewController: UIViewController, AVAudioPlayerDelegate {
    
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
        let konaWalks = KonasWalkies()
        
        let walkType = konaWalks.randomWalkiesType()
        
        playAudio(withURLString: walkType.audioFile)
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let data : [String: Any] = [
            "id": walkType.id,
            "timestamp": Date().timeIntervalSince1970,
            "mumble": walkType.mumble
        ]
        ref.child("walkies").childByAutoId().setValue(data)
    }
    
    private func playAudio(withURLString audioURLString: String) {
        let audioFileURL = URL(fileURLWithPath: Bundle.main.path(forResource: audioURLString, ofType: "mp3")!)
        
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
}

