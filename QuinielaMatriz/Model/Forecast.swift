//
//  Forecast.swift
//  QuinielaMatriz
//
//  Created by User on 3/26/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class Forecast {
    
    // MARK: - Properties
    
    var rows: Int
    var columns: Int
    var results: [[User?]] = [[User]]()
    var users: [User?] = [User]()
    var awaySetScores: [[String]]
    var homeSetScores: [[String]]
    enum SquareType {
        case Five
        case Ten
    }

    init(squareOf: SquareType = .Five) {
        switch squareOf {
        case .Five:
            rows = 6
            columns = 6
            awaySetScores = [[], ["0", "5"], ["1", "6"], ["2", "7"], ["3", "8"], ["4", "9"]]
            homeSetScores = [[], ["0", "1"], ["2", "3"], ["4", "5"], ["6", "7"], ["8", "9"]]
            break
        case .Ten:
            rows = 11
            columns = 11
            awaySetScores = [[0..<10].map{ "\($0)" }]
            homeSetScores = [[0..<10].map{ "\($0)" }]
        }
        for _ in 0..<rows {
            users = [User]()
            for _ in 0...columns {
                users.append(nil)
            }
            results.append(users)
        }
    }
}
