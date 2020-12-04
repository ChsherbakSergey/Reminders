//
//  ViewController.swift
//  Reminders
//
//  Created by Sergey on 12/2/20.
//

import UIKit
import UserNotifications

class RemindersController: UIViewController {
    
    //Views that will be displayed on this controller
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "plus", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.9)
        return button
    }()
    
    //Constants and variables
    var models = [Reminder]()

    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setDelegates()
        setTargetsToButtons()
        configureNavigationController()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Frame of the add button
        addButton.frame = CGRect(x: (view.width / 2) - 40, y: view.height - view.safeAreaInsets.bottom - 40, width: 80, height: 80)
        addButton.layer.cornerRadius = addButton.width / 2
        //frame of the tableView
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: addButton.bottom - 230)
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Background Color of the main view
        view.backgroundColor = .systemBackground
        //Adding subviews
        view.addSubview(addButton)
        view.addSubview(tableView)
    }
    
    //Sets bar button items
    private func configureNavigationController() {
        let rightBarButtonitem = UIBarButtonItem(title: "Hit", style: .done, target: self, action: #selector(didTapHitButton))
        rightBarButtonitem.tintColor = .label
        navigationItem.rightBarButtonItem = rightBarButtonitem
    }
    
    ///Sets delegates
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    ///Sets targets to buttons
    private func setTargetsToButtons() {
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    @objc private func didTapAddButton() {
        //Show vc where user can add a new reminder
        let vc = AddReminderViewController()
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.title = "New Reminder"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapHitButton() {
        //Show test notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { [weak self] success, error in
            if success {
                //Schedule notification
                self?.scheduleNotification()
            } else if let error = error {
                print("Got an error: \(error)")
            }
        })
    }
    
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.badge = 1
        content.title = "Hey, today is a goood day!"
        content.body = "Don't you forgot? You have some things to do"
        
        let triggerDate = Date().addingTimeInterval(8)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: triggerDate), repeats: false)
        let request = UNNotificationRequest(identifier: "Things_to_do", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print("Notifications was not fired")
            } else {
                print("Cool, notification has been fired!")
            }
        })
    }

}

//MARK: - UITableViewDelegate and UITableViewDataSource Realization

extension RemindersController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
