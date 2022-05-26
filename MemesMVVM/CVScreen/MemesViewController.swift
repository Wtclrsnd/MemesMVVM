//
//  ViewController.swift
//  MemesMVVM
//
//  Created by Emil Shpeklord on 25.05.2022.
//

import UIKit

final class MemesViewController: UIViewController {

    private var viewModel: MemesViewModel

    private let reusableIdentifier = "myCell"

    init(vm: MemesViewModel) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        layout.itemSize = CGSize(width: (width - 60) / 2, height: width / 2)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 50

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: reusableIdentifier)

        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        viewModel.getData(completion: {
            self.collectionView.reloadData()
        })
    }

    private func setUpUI() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        navigationController?.navigationBar.tintColor = .systemPink
        title = "Memes"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension MemesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOrRows()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reusableIdentifier,
            for: indexPath) as? MemeCollectionViewCell else { return UICollectionViewCell() }
        cell.applyImage(urlString: viewModel.memeData[indexPath.row].url)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = viewModel.memeData[indexPath.row]
        let singeMeme = SingleMeme(name: meme.name, url: meme.url)
        let vm = DetailViewModel(singeMeme)
        let vc = DetailViewController(vm: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
