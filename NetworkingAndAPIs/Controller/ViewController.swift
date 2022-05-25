//
//  ViewController.swift
//  NetworkingAndAPIs
//
//  Created by Laptop World on 21/10/1443 AH.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps
import PullToRefresh
import ESPullToRefresh

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //---------------------- outlet ---------------
    
    //myLabel = Label error that appear when error occur if page = 1
    @IBOutlet weak var myLabel: UILabel!
    //myView = view error that include label and button reload
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityLoadingPage: UIActivityIndicatorView!
    
    
    //---------------------- actions ---------------
    // btnError = reloadData when error occur
    @IBAction func btnError(_ sender: UIButton) {
        self.loadingData()
        self.activityLoadingPage.startAnimating()
        self.fetchLocations()
    }
    
    //---------------------- variables ---------------
    
    var items: [LocationObject] = []
    var page = 1
    
    //---------------------- LifeCycle ---------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //init loading
        self.loadingData()
        self.activityLoadingPage.startAnimating()
        self.fetchLocations()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        setupTableRefresh()
        self.tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    @objc func getData(){
        fetchLocations()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let item = items[indexPath.row]
        cell.cellConfiguration(item: item)
        //cell.textLabel?.text = item.name
        //cell.detailTextLabel?.text = item.address
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as! MapViewController
        //let item = items[indexPath.row]
        // i need item if i will make event
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupTableRefresh(){

            //if refresh from top
            self.tableView.es.addPullToRefresh { [weak self] in
                guard let self = self else { return }
                self.page = 1
                self.fetchLocations()
                print("top")
            }
            //if reach end
            self.tableView.es.addInfiniteScrolling { [weak self] in
                guard let self = self else { return }
                self.fetchLocations()
            }
        }
}
extension ViewController {
    
    func loadingData() {
        self.tableView.alpha = 0
        self.myView.alpha = 0
    }
    
    func showErrorOnPage(err: String) {
        self.tableView.alpha = 0
        self.myView.alpha = 1
        self.myLabel.text = err
    }
    
    func hideError() {
        self.tableView.alpha = 1
        self.myView.alpha = 0
    }
    
    func fetchLocations() {
        AF.request("https://iskan.roqay.solutions/api/v1/locations?page=" + page.description).responseData { [self] (response) in
            debugPrint(response.response)
            self.activityLoadingPage.stopAnimating()
            self.tableView.es.stopLoadingMore()
            self.tableView.es.stopPullToRefresh()
        switch response.result {
        case .success(let value):
            let response = JSON(value)
            print("Response JSON: \(response["data"]["data"])")
            let dataArr = response["data"]["data"]
            let decoder = JSONDecoder()
            do {
                let list = try decoder.decode([LocationObject].self, from: dataArr.rawData())
                //self.items = list
                if list.count > 0 {
                    self.hideError()
                    if self.page == 1 {
                        items = list
                    }else {
                        items.append(contentsOf: list)
                    }
                    self.page = page + 1
                }else {
                    if self.page == 1 {
                        //empty in page 1
                        self.showErrorOnPage(err: "No Data Found!")
                    }else {
                        self.tableView.es.noticeNoMoreData()
                    }
                }
                self.tableView.reloadData()
            } catch {
                if(self.page == 1) {
                    self.showErrorOnPage(err: error.localizedDescription)
                }else{
                    self.tableView.es.noticeNoMoreData()
                }
            }
        case .failure(let error):
            self.showErrorOnPage(err: error.localizedDescription)
            print(error)
            break
        }
    }
  }
}

