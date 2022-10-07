//
//  ViewController.swift
//  MemoryKeeper
//
//  Created by Grant Watson on 10/5/22.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var memories = [Memory]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMemory))
        let defaults = UserDefaults.standard
        if let savedMemories = defaults.object(forKey: "memories") as? Data {
            let decoder = JSONDecoder()
            do {
                memories = try decoder.decode([Memory].self, from: savedMemories)
            } catch {
                print("Failed to load memories")
            }
        }
        
        print(memories[0])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoryCell", for: indexPath) as? MemoryCell else {
            fatalError("Unable to dequeue cell.")
        }
        
        let memory = memories[indexPath.row]
        
        cell.caption.text = memory.caption
        
        let path = getDocumentsDirectory().appendingPathComponent(memory.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path())
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            vc.selectedMemory = memories[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    @objc func addMemory() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            picker.sourceType = .camera
//        }
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let memory = Memory(image: imageName, caption: "Caption")
    
        dismiss(animated: true)
        
        let ac = UIAlertController(title: "Add caption", message: "Add a caption to your image to make it even more memorable.", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default) { [weak ac] _ in
            guard let caption = ac?.textFields?[0].text else { return }
            memory.caption = caption
        })
        
        present(ac, animated: true)
        memories.append(memory)
        save()
        collectionView.reloadData()
    }
    
    func save() {
        let encoder = JSONEncoder()
        
        if let savedData = try? encoder.encode(memories) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "memories")
        } else {
            print("Failed to save memories")
        }
    }
}

