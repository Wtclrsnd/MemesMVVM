//
//  MemesViewModel.swift
//  MemesMVVM
//
//  Created by Emil Shpeklord on 25.05.2022.
//

import Foundation

protocol MemesViewModelDelegate: AnyObject {
    
}
final class MemesViewModel {
    var memeData: [MemeElement] = []

    func getData(completion: @escaping () -> Void) {
        let urlString = "https://api.imgflip.com/get_memes"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        APIManager.getData(request: request, completion: { memes in
            DispatchQueue.main.async {
                self.memeData = memes.data.memes
                completion()
            }
        })
    }

    func numberOrRows() -> Int {
        return self.memeData.count
    }
}
