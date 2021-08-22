//
//  SetTimerVC.swift
//  MatchingGame
//
//  Created by Moosa Baloch on 22/08/2021.
//

import UIKit
protocol SetTimerVCDelegate: NSObject {
    func didUpdateTimer()
}
class SetTimerVC: UIViewController {
    var delegate: SetTimerVCDelegate?
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var viewModel = SetTimerVM(defaults: Defaults.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cancelButton.isHidden = self.viewModel.isCancelButtonHidden()
        self.setNavigationBarTransparent(withIamgeIcon: UIImage.icon ?? UIImage())
    }
    
    @IBAction func buttonActions(_ sender: UIButton) {
        switch sender {
        case self.updateButton:
            self.viewModel.setUpdatedTime(time: self.timePicker.countDownDuration)
            self.delegate?.didUpdateTimer()
            break
        case self.cancelButton:
            break
        default:
            break
        }
        self.navigationController?.popViewController(animated: true)
    }
}

class SetTimerVM {
    private let defaults: Defaults
    init(defaults: Defaults) {
        self.defaults = defaults
    }
    
    func isCancelButtonHidden() -> Bool {
        return self.defaults.getCountDownTimerDefaultTime() == nil
    }
    
    func setUpdatedTime(time: TimeInterval) {
        self.defaults.saveCountDownTimerDefaultTime(timeInSeconds: Int(time))
    }
}
