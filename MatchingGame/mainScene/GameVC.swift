//
//  GameVC.swift
//  MatchingGame
//
//  Created by Moosa Baloch on 22/08/2021.
//

import UIKit

class GameVC: UIViewController {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    let arr: [Int] = (0..<16).map({ $0 })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        let spacing: CGFloat = 8
        let layout = UICollectionViewFlowLayout()
        let cellMaxWH = (self.collectionView.bounds.width / 4) - spacing
        layout.itemSize = CGSize(width: cellMaxWH, height: cellMaxWH)
        layout.minimumInteritemSpacing = spacing / 2
        layout.minimumLineSpacing = spacing / 2
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        self.collectionView.setCollectionViewLayout(layout, animated: false)
        self.collectionView.register(UINib(nibName: CardCVCell.name, bundle: nil), forCellWithReuseIdentifier: CardCVCell.name)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.openSettings()
    }
    
    func openSettings() {
        let timerVC = SetTimerVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(timerVC, animated: true)
    }
}

// MARK: UICollectionViewDelegate && UICollectionViewDataSource
extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCVCell.name, for: indexPath) as? CardCVCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

