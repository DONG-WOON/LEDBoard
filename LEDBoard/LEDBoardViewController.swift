//
//  LEDBoardViewController.swift
//  LEDBoard
//
//  Created by 서동운 on 7/19/23.
//


import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var topInputView: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var textColorSettingButton: UIButton!
    @IBOutlet weak var ledBoard: UILabel!
    @IBOutlet weak var backgroundColorWell: UIColorWell!
    
    weak var delegate: UIColorPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designTopTextField()
        settingColorWell()
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        topInputView.isHidden.toggle()
        view.endEditing(true)
    }
    
    @IBAction func textColorSettingButtonDidTapped(_ sender: UIButton) {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
        bottomLabel.text = topTextField.text
        sender.text = nil
    }
    
    @IBAction func inputButtonDidTapped(_ sender: Any) {
        textFieldDidEndOnExit(topTextField)
        view.endEditing(true)
    }
    
    func designTopTextField() {
        topTextField.borderStyle = .roundedRect
        topTextField.keyboardType = .emailAddress
    }
    
    func settingColorWell() {
        backgroundColorWell.addTarget(self, action: #selector(colorWellDidChanged), for: .valueChanged)
    }
    
    @objc func colorWellDidChanged(_ sender: UIColorWell?) {
        view.backgroundColor = sender?.selectedColor
    }
}

extension BoardViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let selectedColor = viewController.selectedColor
        ledBoard.textColor = selectedColor
        topTextField.textColor = selectedColor
        textColorSettingButton.setTitleColor(selectedColor, for: .normal)
    }
}
