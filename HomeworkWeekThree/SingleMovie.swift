//
//  ContentView.swift
//  SuperHerosSocial
//
//  Created by Laurie Gray on 27/05/2020.
//  Copyright © 2020 Laurie Gray. All rights reserved.
//
/** import SwiftUI
struct ContentView: View {
    private let profilesURL = URL(string: "https://swapi.dev/api/films/1")!
    // Optional Profile - we know it might exist but not right away
    @State var profiles: Profile?
    @State var showSheet: Bool = false
    var body: some View {
        
        TabView {
        NavigationView {
            List {
                //ForEach(profiles, id: \.self) { profile in
                        //NavigationLink(destination: ProfileView(profile: profile)) {
                Text("\(profiles?.title ?? "Not Value")")
                        //}
                //}
            }
            .onAppear(perform: self.loadFilm)
            .navigationBarTitle("Star Wars Movies")
            //.environment(.colorScheme, (settings.$prefersDarkMode))
        }
    }
    }
    
    func loadFilm() {
        // URL Request
        let request = URLRequest(url: profilesURL)
        // Data Task
        URLSession.shared.dataTask(with: request) { data, response, error in
            // If we have data, unwrap it and pass it in - else bail!
            if let data = data {
                // Use the data to try and make it into a Profile model - else bail!
                // `self` here is just a snapshot
                if let profiles = try? JSONDecoder().decode(Profile.self, from: data) {
                    // Store the profile to show it later
                    self.profiles = profiles
                }
            }
        }
    .resume()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} **/
