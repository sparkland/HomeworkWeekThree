//
//  Result.swift
//  HomeworkWeekThree
//
//  Created by Mark Craig Robertson on 29/05/2020.
//  Copyright © 2020 Mark Craig Robertson. All rights reserved.
//

import Foundation

struct Result: Decodable, Hashable {
    let count: Int
    let next, previous: Bool
    let results: String
}
