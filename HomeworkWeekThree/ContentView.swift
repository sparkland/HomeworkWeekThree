//
//  ContentView.swift
//  HomeworkWeekThree
//
//  Created by Mark Craig Robertson on 29/05/2020.
//  Copyright © 2020 Mark Craig Robertson. All rights reserved.
//

import SwiftUI
struct ContentView: View {
    
    var body: some View {
        
        TabView {
            MoviesView()
                .tabItem {
                    Image(systemName: "film")
                    Text("By Movie")
                }
            CharacterView()
                .tabItem {
                    Image(systemName: "person")
                    Text("By Character")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
