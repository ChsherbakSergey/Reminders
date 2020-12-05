//
//  PopUpTableViewViewController.swift
//  Reminders
//
//  Created by Sergey on 12/5/20.
//

import UIKit

protocol PopUpTableViewViewControllerDelegate: AnyObject {
    func didTapAddColor(with color: UIColor, colorString: String)
}

class PopUpTableViewViewController: UIViewController {

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
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    //Constants and variables
    weak var delegate: PopUpTableViewViewControllerDelegate?
    let arrayOfColors = ["Red", "Orange", "Pink", "Green", "Teal",  "Black", "Yellow", "Blue", "Gray", "Brown"]
    var chosenColor : UIColor = .white
    var chosenColorString = "default"
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setTargetsToButtons()
        showPopUpAnimation()
        setDelegates()
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
        tableView.frame = CGRect(x: popUpView.left, y: 15, width: popUpView.width - 40, height: 210)
        tableView.layer.cornerRadius = 15
        //Frame of the whenToRemind Label
//        chooseAColorLabel.frame = CGRect(x: 20, y: 15, width: view.width - 40, height: 52)
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Color of the main view:
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        //Adding subviews
        view.addSubview(popUpView)
        popUpView.addSubview(cancelButton)
        popUpView.addSubview(saveButton)
        popUpView.addSubview(tableView)
//        popUpView.addSubview(chooseAColorLabel)
    }
    
    ///Sets delegates
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    ///Sets targets to buttons
    private func setTargetsToButtons() {
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    }
    
    @objc private func didTapSaveButton() {
        delegate?.didTapAddColor(with: chosenColor, colorString: chosenColorString)
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

//MARK: - UITableViewDelegate and UITableViewDataSource Realization

extension PopUpTableViewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfColors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let color = arrayOfColors[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = color
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        
        if indexPath.row == 0 {
            cell.backgroundColor = .systemRed
            cell.textLabel?.textColor = .white
        } else if indexPath.row == 1 {
            cell.backgroundColor = .systemOrange
            cell.textLabel?.textColor = .white
        } else if indexPath.row == 2 {
            cell.backgroundColor = .systemPink
            cell.textLabel?.textColor = .white
        } else if indexPath.row == 3 {
            cell.backgroundColor = .systemGreen
            cell.textLabel?.textColor = .white
        } else if indexPath.row == 4 {
            cell.backgroundColor = .systemTeal
            cell.textLabel?.textColor = .white
        } else if indexPath.row == 5 {
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .white
        } else if indexPath.row == 6 {
            cell.backgroundColor = .yellow
            cell.textLabel?.textColor = .black
        } else if indexPath.row == 7 {
            cell.backgroundColor = .systemBlue
            cell.textLabel?.textColor = .white
        } else if indexPath.row == 8 {
            cell.backgroundColor = .systemGray
            cell.textLabel?.textColor = .white
        } else if indexPath.row == 9 {
            cell.backgroundColor = .brown
            cell.textLabel?.textColor = .white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        if indexPath.row == 0 {
            chosenColor = .systemRed
            chosenColorString = "Red"
        } else if indexPath.row == 1 {
            chosenColor = .systemOrange
            chosenColorString = "Orange"
        } else if indexPath.row == 2 {
            chosenColor = .systemPink
            chosenColorString = "Pink"
        } else if indexPath.row == 3 {
            chosenColor = .systemGreen
            chosenColorString = "Green"
        } else if indexPath.row == 4 {
            chosenColor = .systemTeal
            chosenColorString = "Teal"
        } else if indexPath.row == 5 {
            chosenColor = .black
            chosenColorString = "Black"
        } else if indexPath.row == 6 {
            chosenColor = .systemYellow
            chosenColorString = "Yellow"
        } else if indexPath.row == 7 {
            chosenColor = .systemBlue
            chosenColorString = "Blue"
        } else if indexPath.row == 8 {
            chosenColor = .systemGray
            chosenColorString = "Gray"
        } else if indexPath.row == 9 {
            chosenColor = .brown
            chosenColorString = "Brown"
        }
        
    }
    
}
