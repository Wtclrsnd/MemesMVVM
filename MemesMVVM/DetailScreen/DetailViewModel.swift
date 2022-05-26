//
//  DetailViewModel.swift
//  MemesMVVM
//
//  Created by Emil Shpeklord on 25.05.2022.
//

import UIKit

final class DetailViewModel {
    var meme: SingleMeme

    init(_ meme: SingleMeme) {
        self.meme = meme
    }

    func returnImage() -> UIImage {
        let url = URL(string: meme.url)
        guard let url = url else { return UIImage() }
        if let data = try? Data(contentsOf: url) {
            let image = UIImage(data: data)
            guard let gotImage = image else { return UIImage() }
            return gotImage
        }
        return UIImage()
    }
}
