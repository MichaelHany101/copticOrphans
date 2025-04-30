//
//  LoginView.swift
//  copticOrphans
//
//  Created by Michael Hany on 28/04/2025.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var loginError = ""
    @State private var isLoggedIn = false
    @State private var showSignupSheet = false
    @State private var vm = AuthViewModel()
    @StateObject private var viewModel = FacebookViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                
                //MARK: - Email + Password
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                //MARK: - Login + Sign Up Buttons
                Button(action:{login()
                }){
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                HStack {
                    Text("Don't have an account?")
                    Button("Sign Up") {
                        showSignupSheet = true
                    }
                    .foregroundColor(.blue)
                }
                
                //MARK: - Google + Facebook Sign in
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light)){
                    vm.signInWithGoogle()
                }
                
                //FacebookLoginButton(action: {viewModel.loginWithFacebook()})
                
                //Previous line is commented to prevent crash due to Error in Facebook Developer Account I couldn't choose it in Auth of Firebase, so I download the package and make the ViewModel with View but didn't show the View
                
                if !loginError.isEmpty{
                    Text(loginError)
                        .foregroundColor(.red)
                        .padding()
                }
                
                NavigationLink(value: isLoggedIn){
                    EmptyView()
                }
                .navigationDestination(isPresented: $isLoggedIn){
                    ContentView()
                        .navigationBarBackButtonHidden(true)
                }
                
                
            }
            .padding()
            .sheet(isPresented: $showSignupSheet) {
                SignUpView()
                    .presentationDetents([.medium, .large])
            }
            
        }
    }
    
    //MARK: - Login
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                loginError = error.localizedDescription
            }
            
            isLoggedIn = true
        }
    }
    
}

#Preview {
    LoginView()
}
