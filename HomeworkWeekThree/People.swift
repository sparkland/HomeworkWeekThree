//
//  Character.swift
//  HomeworkWeekThree
//
//  Created by Mark Craig Robertson on 31/05/2020.
//  Copyright © 2020 Mark Craig Robertson. All rights reserved.
//

import Foundation

// MARK: - Person
struct People: Decodable, Hashable {
    let count: Int
    let next: String?
    var results: [PersonResult]
}

// MARK: - PersonResult
struct PersonResult: Decodable, Hashable {
    let name: String
    let birthYear: String
    let height: String
    let mass: String
    let hairColor: String
    let eyeColor: String
    let films: [URL]
    let url: URL
}
