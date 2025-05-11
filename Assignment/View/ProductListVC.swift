//
//  ProductListVC.swift
//  Assignment
//
//  Created by Abhay Chaurasia on 11/05/25.
//

import UIKit
import CoreData
import UserNotifications



class ProductListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notificationBackView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var valueToggle: UILabel!
    @IBOutlet weak var toggle: UISwitch!
    
    var viewModel = ProductListViewModel()
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Api Call"
        setupUI()
        setupBindings()
        requestNotificationPermission()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }

    func setupUI() {
        self.backView.layer.cornerRadius = 12
        toggle.isOn = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        tableView.delegate = self
        tableView.dataSource = self
       // indicatior()
    }

    func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.stopAnimation()
                self?.tableView.reloadData()
            }
        }

        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.stopAnimation()
                self?.serviceError(responseCode: error)
            }
        }
    }

    @IBAction func tapOnResetBtn(_ sender: Any) {
        CoreDataManager.shared.deleteAllProducts()
        tableView.reloadData()
        viewModel.fetchFromAPI()
    }

    @IBAction func notificationToggle(_ sender: UISwitch) {
        if sender.isOn {
            NotificationManager.shared.requestAuthorization { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.valueToggle.text = "Yes"
                        UserDefaults.standard.set(true, forKey: "notificationsEnabled")
                    } else {
                        self.valueToggle.text = "No"
                        sender.isOn = false
                        UserDefaults.standard.set(false, forKey: "notificationsEnabled")
                        self.showNotificationDeniedAlert()
                    }
                }
            }
        } else {
            self.valueToggle.text = "No"
            UserDefaults.standard.set(false, forKey: "notificationsEnabled")
        }
    }
}

extension ProductListVC: UITableViewDataSource, UITableViewDelegate, UNUserNotificationCenterDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoreDataTableViewCell", for: indexPath) as! CoreDataTableViewCell
        let product = viewModel.products[indexPath.row]
        cell.nameLabel.text = product.name
        cell.dataLbl.text = product.color
        cell.productLbl.text = product.caseSize
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let name = viewModel.products[indexPath.row].name ?? "Item"
            showDeletionNotification(item: name)
            viewModel.deleteProduct(at: indexPath.row)
        }
    }
    
        
}
