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
	
	private func loadImages() {
		let imageExtensions = ["png", "jpg", "jpeg"]
		var imageURLs = [NSURL]()
		for ext in imageExtensions {
			if let urls = NSBundle.mainBundle().URLsForResourcesWithExtension(ext, subdirectory: "StudentImages") {
				imageURLs.appendContentsOf(urls)
			}
		}
		
		images = imageURLs.flatMap { (url) -> StudentImage? in
			guard let imageData = NSData(contentsOfURL: url),
			image = UIImage(data: imageData) else { return nil }
			let name = url.URLByDeletingPathExtension?.lastPathComponent ?? ""
			return StudentImage(image: image, name: name)
		}
	}
	
	// MARK: UICollectionViewDataSource
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StudentCell", forIndexPath: indexPath) as? StudentCell else {
			return UICollectionViewCell()
		}
		
		let studentImage = images[indexPath.row]
		cell.imageView.image = studentImage.image
		cell.nameLabel.text = studentImage.name
		
		return cell
	}
	
	// MARK: Public Properties
	
	// MARK: Private Properties
	
	private var images = [StudentImage]() {
		didSet {
			collectionView?.reloadData()
		}
	}
	
	// MARK: Outlets
}
