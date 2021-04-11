//
//  MainViewController.swift
//  Homework2.2(Build2)
//
//  Created by Артем Соколовский on 09.04.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setValues(for color: Color)
}

class MainViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    var color = Color(red: 1.00, green: 1.00, blue: 1.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = UIColor(displayP3Red: CGFloat(color.red),
                                           green: CGFloat(color.green),
                                           blue: CGFloat(color.blue),
                                           alpha: 1)
    }
    
    override func viewWillLayoutSubviews() {
        mainView.layer.cornerRadius = mainView.frame.height / 10
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let settingsVC = navigationVC.topViewController as? SettingsViewController else { return }
        settingsVC.color = color
        settingsVC.delegate = self
    }
    
}

extension MainViewController: SettingsViewControllerDelegate {
    func setValues(for color: Color) {
        mainView.backgroundColor = UIColor(displayP3Red: CGFloat(color.red),
                                           green: CGFloat(color.green),
                                           blue: CGFloat(color.blue),
                                           alpha: 1)
        self.color = color
    }
}


