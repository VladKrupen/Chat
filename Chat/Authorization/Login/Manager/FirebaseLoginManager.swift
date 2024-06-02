//
//  FirebaseLoginManager.swift
//  Chat
//
//  Created by Vlad on 16.05.24.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

final class FirebaseLoginManager: UserAuthentication, GoogleAuthorization {
    
    private let auth = Auth.auth()
    private let firebaseRegistrationManager = FirebaseRegistrationManager()
    
    func authUser(email: String, password: String, completion: @escaping ((any Error)?) -> Void) {
        auth.signIn(withEmail: email, password: password) { [weak self] _, error in
            completion(error)
        }
    }
    
    func loginUsingGoogle(loginVC: LoginViewController, spinerCompletion: @escaping () -> Void, errorCompletion: @escaping ((any Error)?) -> Void, succesCompletion: @escaping () -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            let error = NSError(domain: "Не удалось получить id", code: 401)
            errorCompletion(error)
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: loginVC) { [weak self] result, error in
            spinerCompletion()
            guard error == nil else {
                let error = NSError(domain: "Не удалось войти в систему", code: 401)
                errorCompletion(error)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                let error = NSError(domain: "Не удалось получить idToken", code: 401)
                errorCompletion(error)
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            guard let profile = result?.user.profile else {
                let error = NSError(domain: "Не удалось получить данные профиля Google", code: 401)
                errorCompletion(error)
                return
            }
            
            Auth.auth().signIn(with: credential) { [weak self] result, error in
                guard error == nil else {
                    let error = NSError(domain: "Не удалось аутентифицироваться", code: 401)
                    errorCompletion(error)
                    return
                }
                self?.firebaseRegistrationManager.createUser(firstname: profile.givenName ?? "", lastname: profile.familyName ?? "", email: profile.email) { [weak self] error in
                    guard error == nil else {
                        let error = NSError(domain: "Не удалось создать профиль", code: 401)
                        errorCompletion(error)
                        return
                    }
                }
                succesCompletion()
            }
        }
    }
}
