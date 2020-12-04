//
//  ProfileRemindersViewController.swift
//  Reminders
//
//  Created by Sergey on 12/2/20.
//

import UIKit

class ProfileRemindersViewController: UIViewController {

    private let saveButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "ellipsis", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.9)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Frame of the add button
        saveButton.frame = CGRect(x: (view.width / 2) - 40, y: view.height - view.safeAreaInsets.bottom - 40, width: 80, height: 80)
        saveButton.layer.cornerRadius = saveButton.width / 2
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Background Color of the main view
        view.backgroundColor = .systemBackground
        //Adding subviews
        view.addSubview(saveButton)
    }
    
}
