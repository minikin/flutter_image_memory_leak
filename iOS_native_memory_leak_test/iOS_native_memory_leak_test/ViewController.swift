//
//  ViewController.swift
//  iOS_native_memory_leak_test
//
//  Created by Andrew Averin on 21/11/2019.
//  Copyright © 2019 Andrew Averin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var pathsToImage: [String] = []
    private let cellId = "MyCustomCell"
    private let imageCount : Int = 70
    private let imageWidth : Int = 320
    private let imageHeight : Int = 240
    
    private let isLocal = true
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        initializationPathImage()
        print(pathsToImage.last!)
        registerCustomCell()
    }
    
    private func registerCustomCell() {
        let nib = UINib(nibName: "MyCustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
    }
    
    private func setImage(from url: String, completion: ((UIImage)->())?) {
        guard let imageURL = !isLocal ? URL(string: url) : URL(fileURLWithPath: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)

            DispatchQueue.main.async {
                guard let loadedImage = image else {
                    completion?(UIImage())
                    return
                }
                
                completion?(loadedImage)
            }
        }
    }
    
    private func initializationPathImage() {
        if(isLocal) {
            let folderName = "\(imageWidth)x\(imageHeight)"
            let documentsPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).path
            let pathToFolder = "\(documentsPath)/\(folderName)/"
            
            if(!FileManager.default.fileExists(atPath: pathToFolder)) {
                do {
                    try FileManager.default.createDirectory(atPath: pathToFolder, withIntermediateDirectories: true, attributes: nil)
                }
                catch {
                    print("Error: Can't create folder: \(pathToFolder)")
                }
            }
            
            do {
                let filePaths = try FileManager.default.contentsOfDirectory(atPath: pathToFolder)
                if(filePaths.isEmpty) {
                    var count = 0;
                    while(count != imageCount) {
                        guard let imageURL = URL(string: "https://loremflickr.com/\(imageWidth)/\(imageHeight)?random=\(count)") else { return }
                        
                        do {
                            let imageData = try Data(contentsOf: imageURL)
                            let writePathToFile = "\(pathToFolder)image\(count).jpg"
                            let urlWriteFile = URL(fileURLWithPath: writePathToFile)
                            print(urlWriteFile.absoluteString)
                            try imageData.write(to: urlWriteFile)
                            pathsToImage.append(writePathToFile)
                        }
                            
                        catch {
                            print("Error: Somethings wrong on load or write file")
                        }
                        
                        print(pathsToImage.last!)
                        count += 1
                    }
                } else {
                    filePaths.forEach { pathsToImage.append(pathToFolder + $0) }
                }
            }
                
            catch {
                print("Error: Can't load files: \(pathToFolder)")
            }
            
        } else {
            var count = 0;
            while(count != imageCount) {
                pathsToImage.append("https://loremflickr.com/\(imageWidth)/\(imageHeight)?random=\(count)")
                print(pathsToImage.last!)
                count += 1
            }
        }
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pathsToImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MyCustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        setImage(from: pathsToImage[indexPath.row]) { (image) in
            cell.imageCell.image = image
        }
        
        return cell
    }
}

