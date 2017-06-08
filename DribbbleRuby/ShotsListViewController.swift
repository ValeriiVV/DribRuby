//
//  ShotsListViewController.swift
//  DribbbleRuby
//
//  Created by Valerii Korobov on 03.06.17.
//  Copyright © 2017 Valerii Korobov. All rights reserved.
//

import UIKit
import MBProgressHUD

class ShotsListViewController: UIViewController {
    
    @IBOutlet weak var tableView    : UITableView!
    var refreshControl              : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shots"
        configureTableView()
        configureRefreshControl()
        getShots()
        loadShots(page: 1)
    }
}

extension ShotsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShotsViewModel.shotsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShotTableViewCell.reuseIdentifier, for: indexPath)
        let shot = ShotsViewModel.shotsArray[indexPath.row]
        
        (cell as! ShotTableViewCell).delegate = self
        (cell as! ShotTableViewCell).titleText = shot.title
        (cell as! ShotTableViewCell).descriptionWithHTML = shot.descriptionString
        (cell as! ShotTableViewCell).mainImageView.setCashedImage(apiURL: shot.image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let visibleHeight = tableView.bounds.size.height
            - self.navigationController!.navigationBar.frame.height
            - UIApplication.shared.statusBarFrame.size.height
        let height = visibleHeight / 2
        return height
    }
}

extension ShotsListViewController: ShotTableViewCellDelegate {
    
    func openFullScreenImage(imageView: UIImageView) {
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        
        if (Double((newImageView.image?.size.height)!) > Double((newImageView.image?.size.width)!)) {
            newImageView.contentMode = .scaleAspectFill
        }
            
        else {
            newImageView.contentMode = .scaleAspectFit
        }
        
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeFullScreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func closeFullScreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}

extension ShotsListViewController {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerReusable(reusableClass: ShotTableViewCell.self)
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(refreshShots),
                                 for: .valueChanged)
        
        if #available(iOS 10, *) {
            tableView.refreshControl = refreshControl
        }
            
        else {
            tableView.backgroundView = refreshControl
        }
    }
    
    func loadShots(page: Int) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        weak var weakSelf = self
        
        NetworkManager.sharedInstance.loadShots(page: page) { (shots, error) in
            MBProgressHUD.hide(for: (weakSelf?.view)!, animated: true)
            
            if (error == nil) {
                if (page == 1) {
                    ShotsViewModel.shotsArray.removeAll()
                }
                
                ShotsViewModel.shots = ShotsViewModel.shots + shots!
                
                if (ShotsViewModel.shotsArray.count < 50) {
                    let p = page + 1
                    ShotsViewModel.shots.removeAll()
                    weakSelf?.loadShots(page: p)
                }
                    
                else {
                    weakSelf?.tableView.reloadData()
                    weakSelf?.refreshControl.endRefreshing()
                    weakSelf?.saveShots()
                }
            }
                
            else {
                if let description = error?.localizedDescription {
                    self.alertMessage(title: "Ошибка при загрузке",
                                      alertMessage: description,
                                      buttonTitle: "ОК",
                                      action: { })
                }
            }
        }
    }
    
    @objc func refreshShots() {
        ShotsViewModel.shots.removeAll()
        ShotsViewModel.shotsArray.removeAll()
        
        loadShots(page: 1)
    }
    
    func saveShots() {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: ShotsViewModel.shotsArray)
        UserDefaults.standard.set(encodedData, forKey: "shots")
    }
    
    func getShots() {
        let decode = UserDefaults.standard.data(forKey: "shots")
        
        if decode != nil {
            ShotsViewModel.shotsArray = NSKeyedUnarchiver.unarchiveObject(with: decode!) as! [ShotObject]
            tableView.reloadData()
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
}


