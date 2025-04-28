//
//  ContentView.swift
//  copticOrphans
//
//  Created by Michael Hany on 28/04/2025.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    
    var body: some View {
        VStack {
            if userLoggedIn {
                MainView()
            }
            else {
                LoginView()
            }
        }.onAppear{
            
            Auth.auth().addStateDidChangeListener{auth, user in
                
                if (user != nil) {
                    
                    userLoggedIn = true
                } else{
                    userLoggedIn = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
