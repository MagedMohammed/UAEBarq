//
//  ViewController.swift
//  UAEBarq
//
//  Created by Maged Omar on 5/1/20.
//  Copyright © 2020 Maged Omar. All rights reserved.
//

import UIKit

protocol VideosViewProtocol {
    func videosData(data:[Videos])
    func showAlert(title:String, message: String)
}

class VideosViewController: UIViewController {
    
    //    MARK- Outlet
    @IBOutlet weak var videosTableView: UITableView!
    
    @IBOutlet weak var googleMapButton: UIButton!{
        didSet{
            self.googleMapButton.layer.cornerRadius = 12
            self.googleMapButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var newControllerButton: UIButton!{
        didSet{
            self.newControllerButton.layer.cornerRadius = 12
            self.newControllerButton.layer.masksToBounds = true
        }
    }
    //    MARK:- Properties
    var videosData = [Videos]()
    var presenter: VideosPresenterProtocol!
    var cellId = "VideosTableViewCell"
    
    
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = VideosPresenter(view: self)
        self.presenter.getAllVideos()
        self.videosTableView.delegate = self
        self.videosTableView.dataSource = self
        self.videosTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    //    MARK:- Action
    @IBAction func new_ControllerAction(_ sender: UIButton) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "New_Controller") as? New_ControllerViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    @IBAction func googleMapsAction(_ sender: UIButton) {
        //GoogleMapsViewController
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoogleMapsViewController") as? GoogleMapsViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
}
//MARK:- Confirm Protocol VideosViewProtocol
extension VideosViewController: VideosViewProtocol {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func videosData(data: [Videos]) {
        self.videosData = data
        DispatchQueue.main.async {
            self.videosTableView.reloadData()
        }
    }
}
//MARK:- TableView Delegate & DataSource func
extension VideosViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videosData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:VideosTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId , for: indexPath) as! VideosTableViewCell
        let title = self.videosData[indexPath.row].title ?? ""
        let description = self.videosData[indexPath.row].description ?? ""
        cell.setupCell(title: title, description: description)
        cell.selectionStyle = .none
        return cell
    }
    
}
