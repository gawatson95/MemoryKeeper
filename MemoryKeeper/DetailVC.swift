//
//  DetailVC.swift
//  MemoryKeeper
//
//  Created by Grant Watson on 10/6/22.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedMemory: Memory?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteMemory))
        
        if let imageToLoad = selectedMemory?.image {
            imageView.image = UIImage(named: imageToLoad)
            print("Image loaded")
            print(imageToLoad)
        }
    }
    
    @objc func deleteMemory() {
//        let index = memories.firstIndex(of: selectedMemory)
//        memories.remove(at: index)
    }

}
