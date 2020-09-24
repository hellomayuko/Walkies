//
//  WalkiesTypes.swift
//  Walkies
//
//  Created by Mayuko Inoue on 9/24/20.
//

import Foundation

public struct WalkType {
    var id: String = ""
    var mumble: String = ""
    var timestamp: Date?
    var audioFile: String = ""
    var imageName: String = ""
}

struct KonasWalkies {
    static let typesOfwalkies = [
        WalkType(id: "kona_0",
             mumble: "Where's my walkies?",
             audioFile: "wheres_my_walkies",
             imageName: "kona_0"),
        WalkType(id: "kona_1",
             mumble: "Walkies please!!",
             audioFile: "walkies_please",
             imageName: "kona_3"),
        WalkType(id: "kona_2",
             mumble: "I wanna walkies",
             audioFile: "i_wanna_walkies",
             imageName: "kona_0"),
        WalkType(id: "kona_3",
             mumble: "Can we go walkies soon?",
             audioFile: "can_we_go_walkies_soon",
             imageName: "kona_1"),
        WalkType(id: "kona_4",
             mumble: "Walkies... NOW",
             audioFile: "walkies_now",
             imageName: "kona_3"),
        WalkType(id: "kona_5",
             mumble: "I really need to go outside",
             audioFile: "i_really_need_to_go_outside",
             imageName: "kona_2"),
        WalkType(id: "kona_5",
             mumble: "HEY!!",
             audioFile: "hey",
             imageName: "kona_3"),
    ]
    
    func randomWalkiesType() -> WalkType {
        let random = Int.random(in: 0..<KonasWalkies.typesOfwalkies.count)
        return KonasWalkies.typesOfwalkies[random]
    }
    
    func doSomething() {
        let walkID = "kona_0"
        
        let filter = KonasWalkies.typesOfwalkies.filter({
            return $0.id == walkID
        })
        
        if let walkType = filter.first {
            print(walkType)
        }
    }
}

