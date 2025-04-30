//
//  FacebookLoginButton.swift
//  copticOrphans
//
//  Created by Michael Hany on 01/05/2025.
//

import SwiftUI

struct FacebookLoginButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "f.circle.fill")
                Text("Sign in with Facebook")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

#Preview {
    FacebookLoginButton(action: {print("Button Clicked")})
}
