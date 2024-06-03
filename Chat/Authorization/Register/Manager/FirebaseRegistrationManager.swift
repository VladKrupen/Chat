//
//  FirebaseRegistrationManager.swift
//  Chat
//
//  Created by Vlad on 16.05.24.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

final class FirebaseRegistrationManager: UserAuthentication, UserCreator, ImageUploader {
    
    private let auth = Auth.auth()
    private let databaseRef = Database.database(url: "https://chat-b2805-default-rtdb.europe-west1.firebasedatabase.app").reference()
    private let storage = Storage.storage()
    
    func authUser(email: String, password: String, completion: @escaping ((any Error)?) -> Void) {
        auth.createUser(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
    
    func createUser(imageURLString: String, firstname: String, lastname: String, email: String, completion: @escaping ((any Error)?) -> Void) {
        guard let userId = auth.currentUser?.uid else {
            let error = NSError(domain: "Не удалось получить id", code: 401)
            completion(error)
            return
        }
        
        let newUser = ChatAppUser(id: userId, firstname: firstname, lastname: lastname, email: email, imageURLString: imageURLString)
        
        guard let userData = try? JSONEncoder().encode(newUser) else {
            let error = NSError(domain: "Не получилось создать данные", code: 401)
            completion(error)
            return
        }
        
        guard let userJSON = try? JSONSerialization.jsonObject(with: userData) as? [String: Any] else {
            let error = NSError(domain: "Не получислось получить словарь", code: 401)
            completion(error)
            return
        }
        
        self.databaseRef.child(Constants.dataName).child(userId).setValue(userJSON) { error, _ in
            completion(error)
        }
    }
    
    func uploadImage(image: Data, completion: @escaping (Result<String, Error>) -> Void, completionCreate: @escaping () -> Void) {
        guard let userId = auth.currentUser?.uid else {
            let error = NSError(domain: "Не удалось получить id", code: 401)
            completion(.failure(error))
            return
        }
        let reference = storage.reference().child(Constants.storageName).child(userId)
        uploadImageData(reference: reference, image: image) { [weak self] error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            self?.getImageURLString(reference: reference, completion: completion, completionCreate: completionCreate)
        }
    }
    
    private func uploadImageData(reference: StorageReference, image: Data, completion: @escaping (Error?) -> Void) {
        let dispatchGroup = DispatchGroup()
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        dispatchGroup.enter()
        reference.putData(image, metadata: metadata) { _, error in
            dispatchGroup.leave()
            guard error == nil else {
                completion(error)
                return
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(nil)
        }
    }
    
    private func getImageURLString(reference: StorageReference, completion: @escaping (Result<String, Error>) -> Void, completionCreate: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        var imageURLString: String = String()
        dispatchGroup.enter()
        reference.downloadURL { imageURL, error in
            guard error == nil else {
                completion(.failure(error!))
                dispatchGroup.leave()
                return
            }
            if let url = imageURL {
                imageURLString = url.absoluteString
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            completion(.success(imageURLString))
            completionCreate()
        }
    }
}
