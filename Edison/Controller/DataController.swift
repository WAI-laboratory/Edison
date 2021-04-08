//
//  DataController.swift
//  Edison
//
//  Created by 이용준 on 2021/03/13.
//

import UIKit

final class DataController {
    private var preference: UserDefaults { UserDefaults.standard }
    
    static let dataKey = "cellArray"
    
    // MARK: - Data
    private(set) var data = [Memo]()
    
    // MARK: - Initialization
    init() {
        if let savedData = load() {
            data = savedData
        }
    }
    
    // MARK: - Action
    func add(item: Memo) {
        print("Add \(item) to data")
        data.append(item)
        save()
    }
    
    // MARK: - Saved data
    private func load() -> [Memo]? {
        let savedData = preference.data(forKey: Self.dataKey)
        guard let data = savedData else {
            print("No saved data")
            return nil
        }
        
        let decodedData = try? PropertyListDecoder().decode([Memo].self, from: data)
        print("Load data \(String(describing: decodedData))")
        return decodedData
    }
    
    private func save() {
    
        guard let encodedData = try? PropertyListEncoder().encode(data) else {
            fatalError("I DIED")
        }
        print("Save data")
        preference.set(encodedData, forKey: Self.dataKey)
    }
    
    // MARK: - Save Image
    func assign(image: UIImage, to memo: Memo) {
        let imageID = newImageID()
        save(image: image, for: imageID)
        memo.imageID = imageID
        save()
    }
    
    @discardableResult
    private func save(image: UIImage, for imageID: String) -> URL? {
        createImageDirectoryIfNeeded()
        
        guard let imageURL = newImageURL(for: imageID) else {
            return nil
        }
        do {
            try image.jpegData(compressionQuality: 1)?.write(to: imageURL, options: .atomic)
            return imageURL
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadImage(for imageID: String) -> UIImage? {
        guard let imageURL = imageDirectory()?.appendingPathComponent("\(imageID).jpg") else {
            return nil
        }
        guard let data = FileManager.default.contents(atPath: imageURL.path) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    // MARK: - Directory
    private func imageDirectory() -> URL? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let imageDirURL = documentsURL?.appendingPathComponent("images", isDirectory: true)
        return imageDirURL
    }
    
    private func newImageID() -> String {
        return UUID().uuidString
    }
    
    private func newImageURL(for imageID: String) -> URL? {
        let imageName = "\(imageID).jpg"
        return imageDirectory()?.appendingPathComponent(imageName, isDirectory: false)
    }
    
    private func createImageDirectoryIfNeeded() {
        guard let imageDirURL = imageDirectory() else { return }
        let manager = FileManager.default
        if !manager.fileExists(atPath: imageDirURL.path) {
            do {
                try manager.createDirectory(at: imageDirURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
