//
//  AddReminderViewController.swift
//  Reminders
//
//  Created by Sergey on 12/4/20.
//

import UIKit

class AddReminderViewController: UIViewController {
    
    //Views that will be displyed on this controller
    private let saveButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "pin", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.9)
        return button
    }()
    
    private let titleTextField : UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.placeholder = "Title..."
        field.font = .systemFont(ofSize: 25, weight: .semibold)
        return field
    }()
    
    private let reminderTextField : UITextView = {
        let field = UITextView()
//        field.borderStyle = .none
//        field.placeholder = "Type your new reminder..."
//        field.layer.borderWidth = 2
//        field.layer.borderColor = UIColor.lightGray.cgColor
        field.font = .systemFont(ofSize: 25, weight: .semibold)
        return field
    }()
    
    private let charactersRemainingLabel : UILabel = {
        let label = UILabel()
        label.text = "150 characters left"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    private let lineView : UIView = {
        let view = UIView()
        view.backgroundColor = .label
        return view
    }()
    
    //Constants and Variables
    let maxLength = 150
    var date = Date()
    
    public var completion: ((String, String, Date) -> Void)?
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setDelegates()
        setTargetsToButtons()
        configureNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Frame of the save button
        saveButton.frame = CGRect(x: (view.width / 2) - 40, y: view.height - view.safeAreaInsets.bottom - 40, width: 80, height: 80)
        saveButton.layer.cornerRadius = saveButton.width / 2
        //Frame of the title textField
        titleTextField.frame = CGRect(x: 20, y: view.safeAreaInsets.top, width: view.width - 40, height: 52)
        //Frame of the line view
        lineView.frame = CGRect(x: 20, y: titleTextField.bottom + 5, width: view.width - 40, height: 2)
        //Frame of the reminder textField
        reminderTextField.frame = CGRect(x: 17, y: lineView.bottom + 10, width: view.width - 34, height: 210)
        reminderTextField.layer.cornerRadius = 10
        //Frame of CharactersRemaining Label
        charactersRemainingLabel.frame = CGRect(x: view.width / 2, y: reminderTextField.bottom + 5, width: view.width / 2 - 40, height: 50)
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Background color of the main view
        view.backgroundColor = .systemBackground
        //Adding subviews
        view.addSubview(saveButton)
        view.addSubview(titleTextField)
        view.addSubview(lineView)
        view.addSubview(reminderTextField)
        view.addSubview(charactersRemainingLabel)
        //First Responder
        titleTextField.becomeFirstResponder()
    }
    
    ///Sets Delegates
    private func setDelegates() {
        titleTextField.delegate = self
        reminderTextField.delegate = self
    }
    
    ///Configures navigationBar
    private func configureNavigationBar() {
        let rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func didTapSaveButton() {
        guard let title = titleTextField.text, !title.isEmpty, let reminder = reminderTextField.text, !reminder.isEmpty else {
            return
        }
        guard let popUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popUp") as? PopUpViewController else {
            return
        }
        popUpVc.completion = { [weak self] date in
            self?.date = date
        }
        completion?(title, reminder, date)
        
    }
    
    ///Sets targets to buttons
    private func setTargetsToButtons() {
        saveButton.addTarget(self, action: #selector(didTapPinButton), for: .touchUpInside)
    }
    
    @objc private func didTapPinButton() {
        guard let popUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popUp") as? PopUpViewController else {
            return
        }
        addChild(popUpVc)
        popUpVc.view.frame = view.frame
        view.addSubview(popUpVc.view)
        popUpVc.didMove(toParent: self)
    }

}


extension AddReminderViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            titleTextField.resignFirstResponder()
            reminderTextField.becomeFirstResponder()
        }
        return true
    }
    
}



extension AddReminderViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 150
    }
    
    func textViewDidChange(_ textView: UITextView) {
        charactersRemainingLabel.text = "\(maxLength - textView.text.count) characters left"
        }
    
}
