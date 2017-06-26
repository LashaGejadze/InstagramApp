//
//  NewsFeed.swift
//  
//
//  Created by macosx on 20.06.17.
//
//

import UIKit

class NewsFeed: UIViewController {
    
    //Mark: IBOutlets
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let identifier_table = "xxTableCellxx"
    fileprivate let identifier_collection = "xxCollectionCellxx"
    
    // MARK: - Data Object
    fileprivate lazy var dataObject = [UserObject]()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchInformation() // fetch information
    }
    
    // This function will call HTTPWorker which i have created in Core folder
    // after http worker will give us some result we should make action using it
    private func fetchInformation () {
        DispatchQueue.global(qos: .userInitiated).async {
            let worker = HttpWorker()
            worker.fetchUserInformationFromRemoteServer { [weak self] (object) in
                if object != nil {
                    self?.dataObject = object!
                    self?.dataSourceAndDelegation(with: true) // we have objects so lets init tableView and CollectionView
                } else {
                    self?.dataSourceAndDelegation(with: false) // we do not have any object so lets deAlloc Table and Collection
                }
            }
        }
    }
    
    // MARK: - Assign TableView Delegates
    private func dataSourceAndDelegation (with status: Bool) {
        DispatchQueue.main.async { [weak self] in
            if status {
                self?.tableView.delegate = self
                self?.tableView.dataSource = self
                
                self?.collectionView.delegate = self
                self?.collectionView.dataSource = self
            } else {
                self?.tableView.delegate = nil
                self?.tableView.dataSource = nil
                
                self?.collectionView.delegate = nil
                self?.collectionView.dataSource = nil
            }
            
            self?.collectionView.reloadData()
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension NewsFeed: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataObject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier_collection, for: indexPath) as? NewsCollCell else {
            fatalError("Could not dequeue cell with identifier xxCollectionCellxx")
        }
        
        let object = self.dataObject[indexPath.item]
        
        // assign avatar
        let url = URL(string: object.img) // cast string to url
        cell.avatar.sd_setImage(with: url)
        cell.userName.text = object.userName
        
        return cell
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension NewsFeed: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier_table, for: indexPath) as? NewsTableCell else {
            fatalError("Could not dequeue cell with identifier xxxNewsFeedTabCell")
        }
        
        cell.tag = indexPath.row
        let object = self.dataObject[indexPath.row]
        
        if cell.tag == indexPath.row { // trick to disable redraw for incorrect cells
            // assign avatar
            let url = URL(string: object.img)
            cell.avatar.sd_setImage(with: url)
            cell.userImage.sd_setImage(with: url)
            
            cell.name.text = object.userName
            cell.like.text = object.likes + " likes"
            cell.views.text = "View all \(object.views!) comments"
        }
        
        return cell
    }
}

