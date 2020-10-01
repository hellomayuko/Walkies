//
//  HoomanView.swift
//  Walkies
//
//  Created by Mayuko Inoue on 9/23/20.
//

import SwiftUI
import Firebase


struct HoomanView: View {
    
    @ObservedObject var walkiesFetcher = WalkiesFetcher()
    
    var body: some View {
        VStack {
            HStack {
                Image("kona_large")
                Text("kona\n wants\n to walk.").fontWeight(.bold).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
            }.frame(height:200).padding()
            
            List(walkiesFetcher.walkRequests) { request in
                HStack {
                    Image(request.walkType?.imageName ?? "kona_0")
                    Text(request.walkType?.mumble ?? "")
                    Spacer()
                    Text(request.timestamp?.timeString() ?? "").font(.caption).foregroundColor(Color.gray)
                }.frame(height:55)
            }
        }
    }
}

struct HoomanView_Previews: PreviewProvider {
    static var previews: some View {
        HoomanView()
    }
}
