//
//  AddFoodScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 03/04/25.
//

import SwiftUI

struct AddFoodScreen: View {
    
    @State var searchText: String = ""
    
    var body: some View {
        ScreenBuilder {
           
            AccentPageHeader(pageHeaderTitle: "Add Food")
            
            ScrollContentView {
                CustomTextField(searchText: self.$searchText, placeholder: "Search")
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
        }
    }
}

#Preview {
    AddFoodScreen()
}
