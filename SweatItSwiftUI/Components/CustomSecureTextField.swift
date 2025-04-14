//
//  CustomSecureTextField.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 12/04/25.
//

import SwiftUI

struct CustomSecureTextField: View {
    
    @State var isSecure: Bool = true
    
    @Binding var searchText: String
    var placeholder: String
    
    var body: some View {
        if self.isSecure {
            SecureField("", text: self.$searchText, prompt: Text(self.placeholder).font(.system(size: 13)).foregroundStyle(.white.opacity(0.5)))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .padding(.horizontal)
                .background(.darkBG.opacity(0.54))
                .overlay {
                    defaultShape
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(defaultShape)
                .allowsHitTesting(true)
                .overlay {
                    HStack {
                        Image(systemName: self.isSecure ? "eye.slash.fill" : "eye.fill")
                            .foregroundStyle(.white.opacity(0.5))
                            .padding()
                            .onTapGesture {
                                withAnimation {
                                    self.isSecure.toggle()
                                }
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
        } else {
            TextField("", text: self.$searchText, prompt: Text(self.placeholder).font(.system(size: 13)).foregroundStyle(.white.opacity(0.5)))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .padding(.horizontal)
                .background(.darkBG.opacity(0.54))
                .overlay {
                    defaultShape
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(defaultShape)
                .allowsHitTesting(true)
                .overlay {
                    HStack {
                        Image(systemName: self.isSecure ? "eye.slash.fill" : "eye.fill")
                            .foregroundStyle(.white.opacity(0.5))
                            .padding()
                            .onTapGesture {
                                withAnimation {
                                    self.isSecure.toggle()
                                }
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
        }
    }
}

