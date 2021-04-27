//
//  DataController.swift
//  Edison
//
//  Created by 이용준 on 2021/03/13.
//

import UIKit

final class DataController {
    static let shared = DataController()
    
    private var preference: UserDefaults { UserDefaults.standard }
    
    static let dataKey = "cellArray"
    
    private var imageCache = [String: UIImage]()
    
    // MARK: - Data
    private(set) var memos = [Memo]()
    
    // MARK: - Initialization
    private init() {
        if let savedData = load() {
            memos = savedData
        }
    }
    
    // MARK: - Action
    func add(item: Memo) {
        // print("Add \(item) to data")
        memos.append(item)
        save()
    }
    
    func insert(item: Memo, at: Int) {
        memos.insert(item, at: at)
        save()
    }
    
    func itemEdited() {
        save()
    }
    
    func remove(index: Int) {
        memos.remove(at: index)
        save()
    }
    
    func sortByAscend() {
        memos.sort(by: { $0.title < $1.title })
        save()
    }
    
    func sortByDescend() {
        memos.sort(by: {$0.title > $1.title})
        save()
    }
    
    // MARK: - Saved data
    private func load() -> [Memo]? {
        let savedData = preference.data(forKey: Self.dataKey)
        guard let data = savedData else {
            // print("No saved data")
            return nil
        }
        
        let decodedData = try? PropertyListDecoder().decode([Memo].self, from: data)
        // print("Load data \(String(describing: decodedData))")
        return decodedData
    }
    
    private func save() {
        guard let encodedData = try? PropertyListEncoder().encode(memos) else {
            fatalError("I DIED")
        }
        // print("Save data")
        
        
        NotificationCenter.default
            .post(name: .reloadNotificaiton,
                  object: self,
                  userInfo: nil)

        preference.set(encodedData, forKey: Self.dataKey)
    }
    
    // MARK: - Save Image
    func assign(image: UIImage?, to memo: Memo) {
        if let image = image {
            let imageID = newImageID()
            save(image: image, for: imageID)
            memo.setImageID(imageID)
        } else {
            memo.setImageID("")
            // TODO: Delete image from file
        }
        save()
    }
    
    @discardableResult
    private func save(image: UIImage, for imageID: String) -> URL? {
        cacheImage(image, for: imageID)
        
        createImageDirectoryIfNeeded()
        
        guard let imageURL = newImageURL(for: imageID) else {
            return nil
        }
        do {
            try image.jpegData(compressionQuality: 1)?.write(to: imageURL, options: .atomic)
            return imageURL
        } catch {
            // print(error.localizedDescription)
            return nil
        }
    }
    
    func loadImage(for imageID: String) -> UIImage? {
        if let image = getCachedImage(for: imageID) {
            return image
        }
        
        guard let imageURL = imageDirectory()?.appendingPathComponent("\(imageID).jpg") else {
            return nil
        }
        guard let data = FileManager.default.contents(atPath: imageURL.path) else {
            return nil
        }
        
        let image = UIImage(data: data)
        cacheImage(image, for: imageID)
        
        return image
    }
    
    private func cacheImage(_ image: UIImage?, for imageID: String) {
        imageCache[imageID] = image
    }
    
    private func getCachedImage(for imageID: String) -> UIImage? {
        return imageCache[imageID]
    }
    
    // MARK: - Delete Data
    private func delete() {
        
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
                // print(error.localizedDescription)
            }
        }
    }
}
