//
//  MainView.swift
//  copticOrphans
//
//  Created by Michael Hany on 28/04/2025.
//

import SwiftUI

struct MainView: View {
    
    @State private var err : String = ""
    @StateObject private var viewModel = RepositoriesViewModel()
    
    var body: some View {
        VStack {
            //MARK: - Text Field
            TextField("Search Repositories...", text: $viewModel.searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            //MARK: - List
            List {
                ForEach(viewModel.repositories) { repo in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(repo.name).font(.headline)
                        if let desc = repo.description {
                            Text(desc).font(.subheadline).foregroundColor(.gray)
                        }
                        Text(repo.html_url)
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    .onAppear {
                        if repo == viewModel.repositories.last {
                            viewModel.search()                        }
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView().frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            //MARK: - Logout Button
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
        
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text("Network Error"),
                message: Text(viewModel.errorMessage ?? "Something went wrong."),
                dismissButton: .default(Text("Retry")) {
                    viewModel.search()
                }
            )
        }
    }
}

#Preview {
    MainView()
}
