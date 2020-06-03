//
//  CharacterView.swift
//  HomeworkWeekThree
//
//  Created by Mark Craig Robertson on 31/05/2020.
//  Copyright © 2020 Mark Craig Robertson. All rights reserved.
//

import SwiftUI

struct CharacterView: View {
    private let charactersURL = URL(string: "https://swapi.dev/api/people")!
    @State var people: People?
    @State var moreCharacters: String?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(people?.results ?? [], id: \.self) { person in
                    NavigationLink(destination: PeopleView(personUrl: person.url, personFilms: person.films)) {
                        Text("\(person.name)")
                    }
                }
            }
            .navigationBarTitle("Star Wars by Character (\(people?.count ?? 0))", displayMode: .inline)
            .onAppear(perform: self.loadCharacters)
        }
    }
    
    func checkForMoreCharacters() {
        if (moreCharacters != "Null") {
            loadMoreCharacters(moreCharactersURL: moreCharacters ?? "")
        }
    }
    
    func loadCharacters() {
        let request = URLRequest(url: charactersURL)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let people = try? decoder.decode(People.self, from: data) {
                    self.people = people
                }
                self.moreCharacters = self.people?.next ?? "Null"
                self.checkForMoreCharacters()
            }
        }
        .resume()
    }
    
    func loadMoreCharacters(moreCharactersURL: String) {
        let request = URLRequest(url: URL(string: moreCharactersURL)!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let people = try? decoder.decode(People.self, from: data) {
                    self.people?.results.append(contentsOf: people.results)
                    if (people.next != nil) {
                        self.moreCharacters? = people.next ?? "Null"
                    } else {
                        self.moreCharacters = "Null"
                    }
                }
                self.checkForMoreCharacters()
            }
        }
        .resume()
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}
