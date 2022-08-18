//
//  NetworkError.swift
//  ProjectPokedexRev2
//
//  Created by Consultant on 7/16/22.
//

import Foundation

enum NetworkError: Error {
    case badData
    case badURL
    case other(Error)
}
