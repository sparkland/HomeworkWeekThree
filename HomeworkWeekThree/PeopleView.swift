//
//  PeopleView.swift
//  HomeworkWeekThree
//
//  Created by Mark Craig Robertson on 01/06/2020.
//  Copyright © 2020 Mark Craig Robertson. All rights reserved.
//

import SwiftUI

struct PeopleView: View {
    var personUrl: URL!
    var personFilms: [URL]!
    var filmUrl = URL(string: "")
    var filmEpisode = 0
    var filmTitle = ""
    @State var person: PersonResult?
    @State var film: Film?
    @State var listOfFilms: [Film?] = []
    var detailsNotFound = "Not found"
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section(header: HStack {
                    Image(systemName: "calendar")
                    Text("Birth Year")
                        .fontWeight(.medium)
                        .font(.subheadline)
                })
                {
                    Text("\(person?.birthYear ?? detailsNotFound)")
                        .font(.footnote)
                }
                Section(header: HStack {
                    Image(systemName: "person.fill")
                    Text("Body Details")
                        .fontWeight(.medium)
                        .font(.subheadline)
                })
                {
                    HStack {
                        Text("Height:")
                        Text("\(person?.height ?? detailsNotFound)")
                    }
                     .font(.footnote)
                    HStack {
                        Text("Mass:")
                        Text("\(person?.mass ?? detailsNotFound)")
                    }
                    .font(.footnote)
                }
                Section(header: HStack {
                    Image(systemName: "eye")
                    Text("Features")
                        .fontWeight(.medium)
                        .font(.subheadline)
                })
                {
                    HStack {
                        Text("Hair Colour:")
                        Text("\(person?.hairColor ?? detailsNotFound)")
                    }
                     .font(.footnote)
                    HStack {
                        Text("Eye Colour:")
                        Text("\(person?.eyeColor ?? detailsNotFound)")
                    }
                    .font(.footnote)
                }
            }
            Text("\nAppears in:")
            List {
                ForEach(listOfFilms, id: \.self) { film in
                    NavigationLink(destination: MovieView(
                        filmUrl: film?.url ?? URL(string: "https://swapi.dev/api/films/1"),
                        episodeNumber: film?.episodeId ?? 1,
                        episodeTitle: film?.title ?? "Failed to load film")) {
                        Text(film?.title ?? "")
                    }
                }
            }
            .onAppear(perform: loadPersonDetails)
            .onAppear(perform: getFilmDetails)
            .navigationBarTitle("\(person?.name ?? detailsNotFound)", displayMode: .inline)
        }
    }
    
    func getFilmDetails() {
        if (listOfFilms == []) {
            for filmUrl in personFilms {
                loadFilms(filmUrl: filmUrl)
            }
        }
    }
    
    func loadPersonDetails() {
        let request = URLRequest(url: personUrl)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let person = try? decoder.decode(PersonResult.self, from: data) {
                    self.person = person
                }
            }
        }
        .resume()
    }
    
    func loadFilms(filmUrl: URL) {
        let request = URLRequest(url: filmUrl)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let film = try? decoder.decode(Film.self, from: data) {
                    self.film = film
                }
                self.listOfFilms.append(self.film)
            }
        }
        .resume()
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView(personUrl: URL(string: "https://swapi.dev/api/people/1/"))
    }
}
