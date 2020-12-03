//
//  ViewController.swift
//  Reminders
//
//  Created by Sergey on 12/2/20.
//

import UIKit

class RemindersController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let data = ["hey", "hey", "hey"]
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.9)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Frame of the add button
        addButton.frame = CGRect(x: (view.width / 2) - 40, y: view.height - view.safeAreaInsets.bottom - 40, width: 80, height: 80)
        addButton.layer.cornerRadius = addButton.width / 2
        
        tableView.frame = CGRect(x: 0, y: 200, width: view.width, height: 500)
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Background Color of the main view
        view.backgroundColor = .systemBackground
        //Adding subviews
        view.addSubview(addButton)
        view.addSubview(tableView)
    }

}

extension RemindersController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
