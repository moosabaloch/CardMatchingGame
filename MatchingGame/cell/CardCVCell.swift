//
//  CardCVCell.swift
//  MatchingGame
//
//  Created by Moosa Baloch on 22/08/2021.
//

import UIKit

class CardCVCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var emojiLabel: UILabel!
    static let name = "CardCVCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.emojiLabel.minimumScaleFactor = 0.5
        self.emojiLabel.adjustsFontSizeToFitWidth = true
    }
    
    var card: Card? {
        didSet {
            self.updateCardData()
        }
    }
    
    private func updateCardData() {
        guard let card = self.card else { return }
        if card.isMatched {
            self.cardMatched()
            return
        } else {
            self.contentView.alpha = 1
            self.backView.isHidden = card.isFlipped
            self.frontView.isHidden = !card.isFlipped
        }
        self.emojiLabel.text = card.emoji
    }
    
    func cardMatched() {
        UIView.animate(withDuration: 0.3) {
            self.contentView.alpha = 0.6
            self.backView.isHidden = true
            self.frontView.isHidden = false
        }
    }
    
    func flipToFront() {
        UIView.transition(from: backView,
                          to: frontView,
                          duration: 0.3,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews],
                          completion: nil)
    }
    
    func flipToBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.transition(from: self.frontView,
                              to: self.backView,
                              duration: 0.3,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        }
    }
}
