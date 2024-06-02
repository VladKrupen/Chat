//
//  GoogleAuthorization .swift
//  Chat
//
//  Created by Vlad on 28.05.24.
//

import Foundation

protocol GoogleAuthorization {
    func loginUsingGoogle(loginVC: LoginViewController, spinerCompletion: @escaping () -> Void, errorCompletion: @escaping (Error?) -> Void, succesCompletion: @escaping () -> Void)
}
