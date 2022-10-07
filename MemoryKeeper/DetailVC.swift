//
//  DetailVC.swift
//  MemoryKeeper
//
//  Created by Grant Watson on 10/6/22.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteMemory))
        
        imageView.image = image
    }
    
    @objc func deleteMemory() {
        
    }
}
