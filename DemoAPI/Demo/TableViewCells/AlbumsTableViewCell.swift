//
//  AlbumsTableViewCell.swift
//  Demo
//
//  Created by Ketan Saini on 08/01/18.
//  Copyright © 2018 Ketan Saini. All rights reserved.
//

import UIKit

protocol AlbumCellDelegate: class {
    func albumSelected(index: Int)
}

class AlbumsTableViewCell: UITableViewCell {

    @IBOutlet weak var collViewAlbum: UICollectionView!
    weak var delegate: AlbumCellDelegate?
    
    
    var arrAlbum = [Albums]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setupCell() {
        collViewAlbum.delegate = self
        collViewAlbum.dataSource = self
        collViewAlbum.reloadData()
    }
}

extension AlbumsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAlbum.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAlbum", for: indexPath) as? AlbumCollectionViewCell {
            cell.lblTitle.text = arrAlbum[indexPath.row].title
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.albumSelected(index: indexPath.row)
    }
    
}
