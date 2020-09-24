//
//  WalkiesFetcher.swift
//  Walkies
//
//  Created by Mayuko Inoue on 9/24/20.
//

import Foundation
import Firebase

struct WalkRequest: Identifiable {
    var id: String
    var walkType: WalkType?
    var timestamp: Date?
}

class WalkiesFetcher: NSObject, ObservableObject {
    @Published var walkRequests = [WalkRequest]()
    
    override init() {
        super.init()
        
        var ref: DatabaseReference!
        ref = Database.database().reference()

        ref.observe(.childAdded) { (snapshot) in
            for request in snapshot.children {
                print(request)
                if let request = request as? DataSnapshot, let value = request.value, let data = value as? [String: Any] {
                    
                    guard let walkID = data["id"] as? String,
                          let timeStamp = data["timestamp"] as? TimeInterval else {
                        return
                    }
                                        
                    let filter = KonasWalkies.typesOfwalkies.filter({
                        return $0.id == walkID
                    })
                    
                    guard let walkType = filter.first else {
                        return
                    }
                    
                    let request = WalkRequest(id: request.key, walkType: walkType, timestamp: Date(timeIntervalSince1970: timeStamp))
                    
                    self.walkRequests.append(request)
                }
            }
            
            self.walkRequests.sort { (r1, r2) -> Bool in
                guard let r1date = r1.timestamp else {
                    return false
                }
                
                guard let r2date = r2.timestamp else {
                    return true
                }
                
                return r1date > r2date
            }
            
            print(self.walkRequests)
        }
    }
}
