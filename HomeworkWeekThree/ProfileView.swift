//
//  ProfileView.swift
//  WeekThree
//
//  Created by Mark Craig Robertson on 27/05/2020.
//  Copyright © 2020 Mark Craig Robertson. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    var profile: Film?
    @State var profileImage = UIImage()
    @State var hasImage = false
    
    var body: some View {
        VStack {
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFit()
                .frame(height: 400)
                .transition(.scale)
            //Text(results)
            //Text("\(profile!.age)")
            //Text(profile!.bio)
        }
    //.onAppear(perform: downloadImage)
    }
    
    /** func downloadImage() {
        // Make sure profile can be unwrapped and it has a value or bail!
        guard let profile = profile else { return }
        
        let imageRequest = URLRequest(url: profile.profilePhotoURL)
        
        URLSession.shared.dataTask(with: imageRequest) { data, response, error in
            guard let unwrappedData = data else { return }
            
            if let profileImage = UIImage(data: unwrappedData) {
                
                DispatchQueue.main.async {
                    withAnimation {
                        self.profileImage = profileImage
                        self.hasImage = true
                    }
                }
            }
        }
    .resume()
    } **/
}
