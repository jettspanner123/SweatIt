//
//  UserDetailsPage.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 12/04/25.
//

import SwiftUI

struct UserDetailsPage: View {
    
    
    var body: some View {
        ScreenBuilder {
            
            UserDetailsPageHeader()
            
            ScrollContentView {
                
                SectionHeader(text: "Personal Details")
                    .padding(.top, 5)
                CustomList {
                    SpaceSeparatedKeyValue(key: "Email Id", value: User.current.currentUser.emailId)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    SpaceSeparatedKeyValue(key: "Full Name", value: User.current.currentUser.fullName)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    SpaceSeparatedKeyValue(key: "Phone Number", value: "9875660105")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                }
                
                SectionHeader(text: "Other Details")
                    .padding(.top, 25)
                
                CustomList {
                    SpaceSeparatedKeyValue(key: "Username", value: User.current.currentUser.username)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    SpaceSeparatedKeyValue(key: "Height", value: String(format: "%.f cm", User.current.currentUser.currentHeight))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    
                    CustomDivider()
                    
                    
                    SpaceSeparatedKeyValue(key: "Weight", value: String(format: "%.f cm", User.current.currentUser.currentWeight))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    
                    
                    CustomDivider()
                    
                    
                    SpaceSeparatedKeyValue(key: "Body Type", value: User.current.currentUser.bodyType.rawValue)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    
                    CustomDivider()
                    
                    
                    SpaceSeparatedKeyValue(key: "Gender", value: User.current.currentUser.gender.rawValue)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    
                    CustomDivider()
                    
                    
                    SpaceSeparatedKeyValue(key: "Goal", value: User.current.currentUser.goal.rawValue)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    
                    CustomDivider()
                    
                    SpaceSeparatedKeyValue(key: "Level", value: User.current.currentUser.level.rawValue)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    
                }
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}

struct UserDetailsPageHeader: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var showEditUserDetailsPage: Bool = false
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .padding(20)
                    .background(.darkBG.opacity(0.001))
                    .onTapGesture {
                        self.dismiss()
                    }
                    .offset(x: -160, y: 10)
                
                Text("User Details")
                    .font(.system(size: 25, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                    .offset(y: 10)
                
                Image(systemName: "square.and.pencil")
                    .foregroundStyle(.white)
                    .padding(20)
                    .background(.darkBG.opacity(0.001))
                    .onTapGesture {
                        self.showEditUserDetailsPage = true
                    }
                    .offset(x: 160, y: 10)
                
            }
            .offset(y: 25)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 137)
        .background(AppBackgroundBlur(radius: 50, opaque: true))
        .background(Color("DarkBG").opacity(0.55))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.18))
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .offset(y: -70)
        .zIndex(100)
        .navigationDestination(isPresented: self.$showEditUserDetailsPage, destination: {
            UserDetailsEditScreen()
        })
        
    }
}




#Preview {
    UserDetailsEditScreen()
}

