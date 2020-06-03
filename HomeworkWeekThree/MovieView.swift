//
//  MovieView.swift
//  HomeworkWeekThree
//
//  Created by Mark Craig Robertson on 31/05/2020.
//  Copyright © 2020 Mark Craig Robertson. All rights reserved.
//

import SwiftUI

struct MovieView: View {
    var filmUrl: URL!
    var episodeNumber: Int!
    var episodeTitle: String!
    var imageUrl = "https://www.coverwhiz.com/uploads/movies/"
    @State var film: Film?
    @State var posterImage = UIImage()
    let unknownDetail = "Unknown"
    let episodeNumerals: KeyValuePairs = [1: "I",2: "II",3: "III",4: "IV",5: "V",6: "VI"]
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                Image(uiImage: posterImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .transition(.scale)
                VStack(alignment: .leading) {
                    Text("Released:")
                        .font(.footnote)
                    Text("\(film?.releaseDate ?? unknownDetail)\n")
                        .font(.caption)
                    Text("Director:")
                        .font(.footnote)
                    Text("\(film?.director ?? unknownDetail)\n")
                        .font(.caption)
                    Text("Producer:")
                        .font(.footnote)
                    Text("\(film?.producer ?? unknownDetail)\n")
                        .font(.caption)
                }
            }
            VStack {
                Text("\nThe story so far...")
                Text("\n\(film?.openingCrawl ?? unknownDetail)")
                    .font(.caption)
                Spacer()
            }
        }
        .navigationBarTitle("Episode \(episodeNumerals[episodeNumber-1].value) - \(film?.title ?? "Movie Not Found")", displayMode: .inline)
        .onAppear(perform: self.loadFilmDetails)
        .onAppear(perform: self.downloadImage)
    }
    
    func loadFilmDetails() {
        let request = URLRequest(url: filmUrl)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let film = try? decoder.decode(Film.self, from: data) {
                    self.film = film
                }
            }
        }
        .resume()
    }
    
    func downloadImage() {
        let episodeTitleSplit = episodeTitle.components(separatedBy: " ").joined(separator: "-")
        var episodeImageUrl = "https://logos-download.com/wp-content/uploads/2016/09/Star_Wars_logo-1.png"
        if (episodeNumber != 0) {
            episodeImageUrl = "\(imageUrl)Star-Wars-Episode-\(episodeNumerals[episodeNumber-1].value)-\(episodeTitleSplit).jpg"
        }
        let imageRequest = URLRequest(url: URL(string: episodeImageUrl)!)
        URLSession.shared.dataTask(with: imageRequest) { data, response, error in
            guard let unwrappedData = data else { return }
            if let posterImage = UIImage(data: unwrappedData) {
                DispatchQueue.main.async {
                    withAnimation(.easeIn) {
                        self.posterImage = posterImage
                    }
                }
            }
        }
        .resume()
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(filmUrl: URL(string: "https://swapi.dev/api/films/1"), episodeNumber: 4, episodeTitle: "A New Hope")
    }
}
