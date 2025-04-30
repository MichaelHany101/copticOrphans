//
//  FacebookViewModel.swift
//  copticOrphans
//
//  Created by Michael Hany on 01/05/2025.
//

import Foundation
import FacebookLogin
import FirebaseAuth

class FacebookViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    
    func loginWithFacebook() {
        let manager = LoginManager()
        manager.logIn(permissions: ["email"], from: nil) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            
            guard let token = AccessToken.current?.tokenString else {
                self.errorMessage = "Facebook token missing"
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.isLoggedIn = true
                }
            }
        }
    }
}
