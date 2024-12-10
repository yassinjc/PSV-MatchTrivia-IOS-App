//
//  Answer.swift
//  MatchTrivia
//
//  Created by Josian van Efferen on 31/05/2023.
//

import Foundation

struct Answer: Identifiable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
