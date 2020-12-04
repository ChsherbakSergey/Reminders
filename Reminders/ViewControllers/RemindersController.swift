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
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return tableView
//    }()
    
    private var collectionView : UICollectionView?
    
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
//        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: addButton.bottom - 230)
        //frame of the collection view
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: addButton.bottom - 230)
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Background Color of the main view
        view.backgroundColor = .systemBackground
        //Adding subviews
        view.addSubview(addButton)
//        view.addSubview(tableView)
        //Adding collectionView into the main view
        configureCollectionView()
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    ///Configures collectionView()
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: (view.width - 40) / 2,
                                 height: (view.width - 40) / 2)
        collectionView?.backgroundColor = .red
        //Cell
        collectionView?.register(ReminderCollectionViewCell.self, forCellWithReuseIdentifier: ReminderCollectionViewCell.identifier)
    }
    
    //Sets bar button items
    private func configureNavigationController() {
        let rightBarButtonitem = UIBarButtonItem(title: "Hit", style: .done, target: self, action: #selector(didTapHitButton))
        rightBarButtonitem.tintColor = .label
        navigationItem.rightBarButtonItem = rightBarButtonitem
    }
    
    ///Sets delegates
    private func setDelegates() {
//        tableView.delegate = self
//        tableView.dataSource = self
        collectionView?.delegate = self
        collectionView?.dataSource = self
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
        vc.completion = { [weak self] title, reminder, date in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                let newModel = Reminder(title: title, date: date, identifier: "id_\(title)", reminder: reminder)
                self?.models.append(newModel)
//                self?.tableView.reloadData()
                self?.collectionView?.reloadData()
                let content = UNMutableNotificationContent()
                content.sound = .default
                content.badge = 1
                content.title = title
                content.body = "Din't you forgot? You have some things to do"
                
                let triggerDate = date
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
        content.body = "Din't you forgot? You have some things to do"
        
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

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource and UICollectionViewDelegateFlowLayout Realization

extension RemindersController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReminderCollectionViewCell.identifier, for: indexPath) as! ReminderCollectionViewCell
        cell.congigure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
