//
//  ImageUploader.swift
//  Chat
//
//  Created by Vlad on 3.06.24.
//

import Foundation

protocol ImageUploader {
    func uploadImage(image: Data, completion: @escaping (Result<String, Error>) -> Void, completionCreate: @escaping () -> Void)
}
