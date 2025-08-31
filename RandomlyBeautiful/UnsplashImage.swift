//
//  UnsplashImage.swift
//  RandomlyBeautiful
//
//  Created by Edwy Lugo on 07/08/25.
//

import Foundation

struct UnsplashImage: Identifiable, Decodable {
    let id: String
    let urls: Urls
    let user: User

    struct Urls: Decodable {
        let full: String
    }

    struct User: Decodable {
        let name: String
    }
}

struct SearchResult: Decodable {
    let results: [UnsplashImage]
}
