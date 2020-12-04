//
//  PopUpViewController.swift
//  Reminders
//
//  Created by Sergey on 12/4/20.
//

import UIKit

class PopUpViewController: UIViewController {

    private let popUpView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let cancelButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .regular)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .regular)
        return button
    }()
    
    private let saveButton : UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .regular)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    private let whenToRemindLabel : UILabel = {
        let label = UILabel()
        label.text = "When to remind?"
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .regular)
        return label
    }()
    
    //Constants and variables
    public var completion: ((Date) -> Void)?
    
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setTargetsToButtons()
        showPopUpAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Frame of the popUpView
        popUpView.frame = CGRect(x: 20, y: view.height / 2 - 150, width: view.width - 40, height: 300)
        popUpView.layer.cornerRadius = 35
        //Frame of the save button
        saveButton.frame = CGRect(x: popUpView.width - 145, y:
                                    230, width: 125, height: 50)
        saveButton.layer.cornerRadius = 8
        //Frame of the save button
        cancelButton.frame = CGRect(x: popUpView.width - 280, y:
                                    230, width: 125, height: 50)
        cancelButton.layer.cornerRadius = 8
        //Frame of the date picker
        datePicker.frame = CGRect(x: popUpView.left, y: 55, width: popUpView.width - 40, height: 170)
        //Frame of the whenToRemind Label
        whenToRemindLabel.frame = CGRect(x: 20, y: 15, width: view.width - 40, height: 52)
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Color of the main view:
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        //Adding subviews
        view.addSubview(popUpView)
        popUpView.addSubview(cancelButton)
        popUpView.addSubview(saveButton)
        popUpView.addSubview(datePicker)
        popUpView.addSubview(whenToRemindLabel)
    }
    
    ///Sets targets to buttons
    private func setTargetsToButtons() {
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    }
    
    @objc private func didTapSaveButton() {
        let date = datePicker.date
        completion?(date)
        finishAnimation()
    }

    @objc private func didTapCancelButton() {
        finishAnimation()
    }
    
    private func showPopUpAnimation() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    private func finishAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 1.0
        }, completion: {done in
            if done {
                self.view.removeFromSuperview()
            }
        })
    }
    
}
