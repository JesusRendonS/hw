//
//  APIResource.swift
//  ProjectPokedexRev2
//
//  Created by Consultant on 7/16/22.
//

import Foundation

struct NamedAPIResourceList: Decodable{
     
    let count: Int
    
    let next: String?
    
    let previous: String?
    
    let results: [PokeList]

    
}
