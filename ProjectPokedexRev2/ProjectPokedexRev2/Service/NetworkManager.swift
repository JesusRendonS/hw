//
//  NetworkManager.swift
//  ProjectPokedexRev2
//
//  Created by Consultant on 7/16/22.
//

import UIKit

import Foundation


class NetworkManager {
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
}

extension NetworkManager {
    func fetchPage(urlStr: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {

        guard let url = URL(string: urlStr) else {
            // completion error
            return
        }

        self.session.dataTask(with: url) { data, response, error in

            // Do error handling

            guard let data = data else {
                // return error
                return
            }


            do {
                let page = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(page))
            } catch {
                completion(.failure(error))
            }

        }.resume()

    }
    
}


extension NetworkManager {

    func fetchMainPage(urlStr: String, completion: @escaping (Result<PokeList, Error>) -> Void) {

        guard let url = URL(string: urlStr) else {
            // completion error
            return
        }

        self.session.dataTask(with: url) { data, response, error in

            // Do error handling

            guard let data = data else {
                // return error
                return
            }


            do {
                let page = try JSONDecoder().decode(PokeList.self, from: data)
                completion(.success(page))
            } catch {
                completion(.failure(error))
            }

        }.resume()

    }



    func fetchImageData(urlStr: String, completion: @escaping (Result<Data, Error>) -> Void) {

        guard let url = URL(string: urlStr) else {
            // completion error
            return
        }

        self.session.dataTask(with: url) { data, response, error in

            // Do error handling

            guard let data = data else {
                // return error
                return
            }

            completion(.success(data))

        }.resume()

    }

}
