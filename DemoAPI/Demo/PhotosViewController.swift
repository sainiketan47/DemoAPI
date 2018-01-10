//
//  PhotosViewController.swift
//  Demo
//
//  Created by Ketan on 1/9/18.
//  Copyright © 2018 Ketan Saini. All rights reserved.
//

import UIKit
import Kingfisher

class PhotosViewController: UIViewController {

    var arrPhotos:[Photos]?
    @IBOutlet weak var collViewPhotos: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collViewPhotos.delegate = self
        collViewPhotos.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPhotos?.count ?? 0
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPhotos", for: indexPath as IndexPath)
        if let imgVw = cell.viewWithTag(101) as? UIImageView {
            imgVw.kf.setImage(with: URL(string: arrPhotos?[indexPath.row].thumbnailUrl ?? "photo")!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set collectionview cell size
        let size = (self.view.frame.size.width - 40)/3
        return CGSize(width: size, height: size)
    }
    
}
