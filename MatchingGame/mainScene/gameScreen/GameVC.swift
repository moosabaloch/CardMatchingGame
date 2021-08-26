//
//  GameVC.swift
//  MatchingGame
//
//  Created by Moosa Baloch on 22/08/2021.
//

import UIKit

class GameVC: UIViewController {
        
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    lazy var viewModel: GameVM = {
        GameVM(delegate: self, cardRepository: CardRepository(), defaults: Defaults.shared)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarTransparent(withIamgeIcon: UIImage.icon ?? UIImage())
        self.setupCollectionView()
        self.viewModel.scheduleTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateBoxSize()
    }
    
    private func setupCollectionView() {
        self.collectionView.register(UINib(nibName: CardCVCell.name, bundle: nil), forCellWithReuseIdentifier: CardCVCell.name)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    
    private func updateBoxSize() {
        let spacing: CGFloat = 8
        let layout = UICollectionViewFlowLayout()
        let cellMaxWH = (self.collectionView.bounds.width / self.viewModel.gridCount.toCGFloat) - spacing
        layout.itemSize = CGSize(width: cellMaxWH, height: cellMaxWH)
        layout.minimumInteritemSpacing = spacing / 2
        layout.minimumLineSpacing = spacing / 2
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        self.collectionView.setCollectionViewLayout(layout, animated: false)
    }
        
    @IBAction func actionRestart(_ sender: Any) {
        self.viewModel.restartGame()
    }
    
    @IBAction func actionOpenSetting(_ sender: Any) {
        let timerVC = SetTimerVC.instantiate(storyboard: .main)
        timerVC.delegate = self
        self.navigationController?.pushViewController(timerVC, animated: true)
    }
}

// MARK: UICollectionViewDelegate && UICollectionViewDataSource
extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.cardArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCVCell.name, for: indexPath) as? CardCVCell else {
            return UICollectionViewCell()
        }
        cell.card = self.viewModel.cardArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelectItemAt(indexPath: indexPath)
    }
}

// MARK: GameVMDelegate
extension GameVC: GameVMDelegate {
    func flipBackCards(indexPaths: [IndexPath]) {
        indexPaths.forEach({ indexPath in
            (self.collectionView.cellForItem(at: indexPath) as? CardCVCell)?.flipToBack()
        })
    }
    
    func cardsMatched(indexPaths: [IndexPath]) {
        indexPaths.forEach({ indexPath in
            (self.collectionView.cellForItem(at: indexPath) as? CardCVCell)?.cardMatched()
        })
    }
    
    func reloadItems() {
        self.collectionView.reloadData()
    }
    
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction2 = UIAlertAction(title: actionTitle, style: .default, handler: { [weak self] _ in
            self?.viewModel.restartGame()
        })
        alert.addAction(alertAction2)
        present(alert, animated: true, completion: nil)
    }
    
    func updateCountdownTimer(timeString: String, warning: Bool) {
        self.timeLabel.text = timeString
        self.timeLabel.textColor = warning ? .systemRed : .darkGray
    }
    
    func updateScore(newScore: String) {
        self.scoreLabel.text = newScore
    }
    
    func flipToFront(indexPath: IndexPath) {
        (collectionView.cellForItem(at: indexPath) as? CardCVCell)?.flipToFront()
    }
}

// MARK: SetTimerVCDelegate
extension GameVC: SetTimerVCDelegate {
    func didUpdateTimer() {
        self.viewModel.restartGame()
    }
}
