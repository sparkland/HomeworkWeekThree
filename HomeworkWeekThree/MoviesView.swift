//
//  MoviesView.swift
//  HomeworkWeekThree
//
//  Created by Mark Craig Robertson on 31/05/2020.
//  Copyright © 2020 Mark Craig Robertson. All rights reserved.
//

import SwiftUI

struct MoviesView: View {
    private let filmsURL = URL(string: "https://swapi.dev/api/films")!
    @State var films: Films?
    let episodeNumerals: KeyValuePairs = [1: "I",2: "II",3: "III",4: "IV",5: "V",6: "VI"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(films?.results ?? [], id: \.self) { film in
                    NavigationLink(destination: MovieView(filmUrl: film.url, episodeNumber: film.episodeId, episodeTitle: film.title)) {
                        Text("Episode \(self.episodeNumerals[film.episodeId-1].value) - \(film.title)")
                    }
                }
            }
            .navigationBarTitle("Star Wars by Movie (\(films?.count ?? 0))", displayMode: .inline)
            .onAppear(perform: self.loadFilms)
        }
    }
    
    func loadFilms() {
        let request = URLRequest(url: filmsURL)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let films = try? decoder.decode(Films.self, from: data) {
                    self.films = films
                }
            }
        }
        .resume()
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
