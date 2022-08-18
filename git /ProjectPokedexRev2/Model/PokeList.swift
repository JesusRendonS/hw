//
//  PokeList.swift
//  ProjectPokedexRev2
//
//  Created by Consultant on 7/16/22.
//

import Foundation

struct PokeList: Decodable{
let results: [ResultName]
}

struct ResultName: Decodable{
    let name: String
    
}
