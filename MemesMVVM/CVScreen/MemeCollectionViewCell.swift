//
//  MemeCollectionViewCell.swift
//  MemesMVVM
//
//  Created by Emil Shpeklord on 25.05.2022.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemPink
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 4
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyImage(urlString: String) {
        let url = URL(string: urlString)
        guard let url = url else { return }
        if let data = try? Data(contentsOf: url) {
            let image = UIImage(data: data)
            guard let gotImage = image else { return }
            self.photoImageView.image = gotImage
        }
    }
}
