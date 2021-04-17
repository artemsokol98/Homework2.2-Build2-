//
//  ViewController.swift
//  Homework2.2(Build2)
//
//  Created by Артем Соколовский on 28.03.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: IB - Outlets
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var settingsView: UIView!
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    var color: Color!
    var delegate: SettingsViewControllerDelegate!
    
    let bar = UIToolbar()
   
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redLabel.text = String(format: "%.2f", color.red)
        greenLabel.text = String(format: "%.2f", color.green)
        blueLabel.text = String(format: "%.2f", color.blue)
        
        redSlider.value = color.red
        greenSlider.value = color.green
        blueSlider.value = color.blue
        
        redTF.text = String(format: "%.2f", color.red)
        greenTF.text = String(format: "%.2f", color.green)
        blueTF.text = String(format: "%.2f", color.blue)
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self

        redTF.keyboardType = .decimalPad
        greenTF.keyboardType = .decimalPad
        blueTF.keyboardType = .decimalPad

        redTF.addDoneButtonToKeyboard()
        greenTF.addDoneButtonToKeyboard()
        blueTF.addDoneButtonToKeyboard()
        
        settingsView.backgroundColor = UIColor(displayP3Red: CGFloat(color.red),
                                               green: CGFloat(color.green),
                                               blue: CGFloat(color.blue),
                                               alpha: 1)
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }

    override func viewWillLayoutSubviews() {
        settingsView.layer.cornerRadius = settingsView.frame.height / 10
    }
    
    // MARK: - IB Actions
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        settingsView.backgroundColor = UIColor(displayP3Red: CGFloat(redSlider.value),
                                               green: CGFloat(greenSlider.value),
                                               blue: CGFloat(blueSlider.value),
                                               alpha: 1)
        switch sender {
        case redSlider:
            setValue(for: redLabel, for: redTF)
        case greenSlider:
            setValue(for: greenLabel, for: greenTF)
        default:
            setValue(for: blueLabel, for: blueTF)
        }
    }
    
    @IBAction func saveSettingsButton() {
        view.endEditing(true)
        delegate.setValues(for: color)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setValue(for labels: UILabel..., for textField: UITextField) {
        labels.forEach { label in
            switch label {
            case redLabel:
                label.text = string(from: redSlider)
                color.red = redSlider.value
            case greenLabel:
                label.text = string(from: greenSlider)
                color.green = greenSlider.value
            default:
                label.text = string(from: blueSlider)
                color.blue = blueSlider.value
            }
        }
        
        switch textField {
            case redTF:
                redTF.text = string(from: redSlider)
            case greenTF:
                greenTF.text = string(from: greenSlider)
            default:
                blueTF.text = string(from: blueSlider)
        }
            
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }

}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else { return }
        switch textField {
        case redTF:
            color.red = numberValue
            redLabel.text = String(format: "%.2f", numberValue)
            redSlider.value = numberValue
        case greenTF:
            color.green = numberValue
            greenLabel.text = String(format: "%.2f", numberValue)
            greenSlider.value = numberValue
        default:
            color.blue = numberValue
            blueLabel.text = String(format: "%.2f", numberValue)
            blueSlider.value = numberValue
        }
        settingsView.backgroundColor = UIColor(displayP3Red: CGFloat(redSlider.value),
                                               green: CGFloat(greenSlider.value),
                                               blue: CGFloat(blueSlider.value),
                                               alpha: 1)
    }
}

extension UITextField{

 func addDoneButtonToKeyboard(){
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    doneToolbar.barStyle = UIBarStyle.default

    let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                    target: nil,
                                    action: nil)
    let done = UIBarButtonItem(title: "Done",
                               style: UIBarButtonItem.Style.done,
                               target: self,
                               action: #selector(self.doneButtonAction))

    // не понимаю почему в этом методе нужен action с применением objective-C, 
    // но по-другому не работает:(
    // И не до конца понимаю этот код, надо еще разобрать или придумать новое.
    var items = [UIBarButtonItem]()
    items.append(flexSpace)
    items.append(done)

    doneToolbar.items = items
    doneToolbar.sizeToFit()

    self.inputAccessoryView = doneToolbar
 }
    @objc func doneButtonAction(sender: UIBarButtonItem) {
        self.resignFirstResponder()
    }
}
// add comment for development
// another comment for development

// next comment for main branch
