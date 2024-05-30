//
//  GoogleAuthorization .swift
//  Chat
//
//  Created by Vlad on 28.05.24.
//

import Foundation

protocol GoogleAuthorization {
    func loginUsingGoogle(loginVC: LoginViewController, errorCompletion: @escaping (Error?) -> Void, succesCompletion: @escaping () -> Void)
}
