//
//  ViewController.swift
//  Demo
//
//  Created by Ketan Saini on 08/01/18.
//  Copyright © 2018 Ketan Saini. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController, AlbumCellDelegate {
    @IBOutlet weak var collViewUsers: UICollectionView!
    @IBOutlet weak var tblViewDetails: UITableView!
    
    let arrSection = ["Post", "Albums", "ToDo's"]
    var arrUsers = [User]()
    var arrPosts = [Posts]()
    var arrAlbums = [Albums]()
    var arrTodos = [Todos]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collViewUsers.delegate = self
        collViewUsers.dataSource = self
        
        tblViewDetails.estimatedRowHeight = 44.0
        tblViewDetails.rowHeight = UITableViewAutomaticDimension
        
        let lblSelectUser = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        lblSelectUser.text = "Please select a user"
        lblSelectUser.center = tblViewDetails.center
        lblSelectUser.textAlignment = .center
        
        tblViewDetails.backgroundView = lblSelectUser
        
        getUsersAPI()
    }
    
    //------------- API CALL------------//
    
    func getUsersAPI() {
        let URL = "https://jsonplaceholder.typicode.com/users"
        Alamofire.request(URL).responseArray { (response: DataResponse<[User]>) in
            
            if let userArray = response.result.value {
                self.arrUsers = userArray
                self.collViewUsers.reloadData()
            }
        }
    }
    
    func getUserPostsAPI(userID: Int) {
        let URL = "https://jsonplaceholder.typicode.com/posts?userId=\(userID)"
        Alamofire.request(URL).responseArray { (response: DataResponse<[Posts]>) in
            
            if let postArray = response.result.value {
                self.arrPosts = postArray
                self.tblViewDetails.reloadData()
            }
        }
    }
    
    func getUserAlbumsAPI(userID: Int) {
        let URL = "https://jsonplaceholder.typicode.com/albums?userId=\(userID)"
        Alamofire.request(URL).responseArray { (response: DataResponse<[Albums]>) in
            
            if let albumsArray = response.result.value {
                self.arrAlbums = albumsArray
                
            }
        }
    }
    
    func getUserPhotosAPI(albumID: Int) {
        let URL = "https://jsonplaceholder.typicode.com/photos?albumId=\(albumID)"
        Alamofire.request(URL).responseArray { (response: DataResponse<[Photos]>) in
            
            if let photosArray = response.result.value {
                self.performSegue(withIdentifier: "photoDetail", sender: photosArray)
            }
        }
    }
    
    func getUserTodosAPI(userID: Int) {
        let URL = "https://jsonplaceholder.typicode.com/todos?userId=\(userID)"
        Alamofire.request(URL).responseArray { (response: DataResponse<[Todos]>) in
            
            if let todosArray = response.result.value {
                self.arrTodos = todosArray
                self.tblViewDetails.reloadData()
            }
        }
    }
    
    func todosStatusUpdateAPI(userID: Int) {
        let URL = "https://jsonplaceholder.typicode.com/todos?userId=\(userID)"
        Alamofire.request(URL).responseArray { (response: DataResponse<[Todos]>) in
            
            if let todosArray = response.result.value {
                self.arrTodos = todosArray
                self.tblViewDetails.reloadData()
            }
        }
    }

    //------------- API CALL END------------//
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func albumSelected(index: Int) {
        getUserPhotosAPI(albumID: index)
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == "photoDetail" {
            if let photoVC = segue.destination as? PhotosViewController, let photos = sender as? [Photos] {
                photoVC.arrPhotos = photos
            }
        }
        
        if segue.identifier == "postDetail" {
            if let postVC = segue.destination as? PostDetailViewController, let post = sender as? Posts {
                postVC.post = post
            }
        }
     }
 }


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - UITableView Delegate/Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return arrPosts.count
        }
        if section == 1 {
            return 1
        }
        if section == 2 {
            return arrTodos.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrSection[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSection.count
    }
    
    // TableView cell for row at index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellDesc", for: indexPath) as? DescTableViewCell {
                cell.lblDescription.text = arrPosts[indexPath.row].title
                return cell
                
            }
            return UITableViewCell()
            
        } else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellAlbum", for: indexPath) as? AlbumsTableViewCell {
                cell.arrAlbum = self.arrAlbums
                cell.delegate = self
                cell.setupCell()
                return cell
                
            }
            return UITableViewCell()
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellDesc", for: indexPath) as? DescTableViewCell {
                cell.lblDescription.text = arrTodos[indexPath.row].title
                return cell
            }
            return UITableViewCell()
        }
       
    }
    
    // MARK: - TableView row tap Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.performSegue(withIdentifier: "postDetail", sender: self.arrPosts[indexPath.row])
        } else if indexPath.section == 2 {
            
        }
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrUsers.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellUsers", for: indexPath as IndexPath) as? UsersCollectionViewCell {
            cell.lblName.text = self.arrUsers[indexPath.row].name ?? ""
            return cell
        }

        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tblViewDetails.delegate = self
        tblViewDetails.dataSource = self
        tblViewDetails.backgroundView = nil
        let userId = arrUsers[indexPath.row].id ?? 1
        getUserPostsAPI(userID: userId)
        getUserAlbumsAPI(userID: userId)
        getUserTodosAPI(userID: userId)
    }

}
/*
 Base Url: https://jsonplaceholder.typicode.com
 
 Endpoints:
 
 users
 
 posts?userId={userId}
 
 albums
 
 todos
 
 photos

 */
