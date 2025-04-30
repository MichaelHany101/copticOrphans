//
//  MainView.swift
//  copticOrphans
//
//  Created by Michael Hany on 28/04/2025.
//

import SwiftUI

struct MainView: View {
    
    @State private var err : String = ""
    
    var body: some View {
        VStack {
            Text("You Logged In Succefully")
            
            Button{
                Task{
                    do{
                        try await AuthViewModel().logout()
                    } catch let e {
                        
                        err = e.localizedDescription
                    }
                }
            } label: {
                Text("Log Out").padding(8)
            }.buttonStyle(.borderedProminent)
            
            Text(err).foregroundColor(.red).font(.caption)
            
            
        }
        .padding()
    }
}

#Preview {
    MainView()
}
