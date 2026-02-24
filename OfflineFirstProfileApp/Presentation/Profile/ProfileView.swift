//
//  ProfileView.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 23/02/26.
//

import SwiftUI
struct ProfileView: View {
    @StateObject private var profileViewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        _profileViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Profile Details")
                        .font(.largeTitle.bold())
                        .padding(.bottom, 10)
                    
                    Group {
                        customTextField("Name", text: $profileViewModel.name)
                        customTextField("Phone Number", text: $profileViewModel.phoneNumber)
                            .keyboardType(.phonePad)
                        customTextField("Email", text: $profileViewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        customTextField("Address", text: $profileViewModel.address)
                        customTextField("Pincode", text: $profileViewModel.pincode)
                            .keyboardType(.numberPad)
                    }
                    
                    Button(action: {
                        Task {
                            await profileViewModel.saveProfile()
                        }
                    }) {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
                .padding(20)
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            Task {
               await profileViewModel.getProfile()
            }
        }
        .alert(profileViewModel.alertMessage, isPresented: $profileViewModel.showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
    
    private func customTextField(_ title: String,
                                 text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            TextField("\(title)", text: text)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
    }
}

