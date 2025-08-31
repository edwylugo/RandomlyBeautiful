//
//  ImageLoader.swift
//  RandomlyBeautiful
//
//  Created by Edwy Lugo on 07/08/25.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var currentImage: UIImage?
    @Published var credit: String = ""
    
    private var images: [UnsplashImage] = []
    private var imageIndex = 0
    private let appID = "7d021f6d3c120398f3a3cec4cdaf5a45ae22c5e1a07d7b4eb04823b557622a80"
    
    func fetchImages(for category: String) {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?client_id=\(appID)&query=\(category)&per_page=100") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            if let result = try? JSONDecoder().decode(SearchResult.self, from: data) {
                DispatchQueue.main.async {
                    self.images = result.results
                    self.loadNextImage()
                }
            }
        }.resume()
    }
    
    func loadNextImage() {
        guard !images.isEmpty else { return }
        let index = imageIndex % images.count
        imageIndex += 1
        
        let imageURL = images[index].urls.full
        let credit = images[index].user.name
        
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let uiImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.currentImage = uiImage
                self.credit = credit
                DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                    self.loadNextImage()
                }
            }
        }.resume()
    }
}
