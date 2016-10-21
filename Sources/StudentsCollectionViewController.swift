//
//  StudentsCollectionViewController.swift
//  StudentList
//
//  Created by Andrew Madsen on 7/1/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

struct StudentImage {
	let image: UIImage
	let name: String
}

class StudentsCollectionViewController: UICollectionViewController {
	
	// MARK: Overridden
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
		flowLayout?.estimatedItemSize = CGSize(width: 128, height: 150)
		loadImages()
	}
	
	// MARK: Public Methods
	
	// MARK: Actions
	
	// MARK: Private Methods
	
	fileprivate func loadImages() {
		let imageExtensions = ["png", "jpg", "jpeg"]
		var imageURLs = [URL]()
		for ext in imageExtensions {
			if let urls = Bundle.main.urls(forResourcesWithExtension: ext, subdirectory: "StudentImages") {
				imageURLs.append(contentsOf: urls)
			}
		}
		
		images = imageURLs.flatMap { (url) -> StudentImage? in
			guard let imageData = try? Data(contentsOf: url),
			let image = UIImage(data: imageData) else { return nil }
			let name = url.deletingPathExtension().lastPathComponent ?? ""
			return StudentImage(image: image, name: name)
		}
	}
	
	// MARK: UICollectionViewDataSource
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCell", for: indexPath) as? StudentCell else {
			return UICollectionViewCell()
		}
		
		let studentImage = images[(indexPath as NSIndexPath).row]
		cell.imageView.image = studentImage.image
		cell.nameLabel.text = studentImage.name
		
		return cell
	}
	
	// MARK: Public Properties
	
	// MARK: Private Properties
	
	fileprivate var images = [StudentImage]() {
		didSet {
			collectionView?.reloadData()
		}
	}
	
	// MARK: Outlets
}
