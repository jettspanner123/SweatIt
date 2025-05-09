//
//  SelectRegionScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 22/03/25.
//

import SwiftUI

struct SelectRegionScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedRegion: String
    @Binding var showSelectRegionScreen: Bool
    
    @State var searchText: String = ""
    @State var pageTranslation: CGSize = .zero
    
    let indianStatesAndUTs = [
        "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh",
        "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand",
        "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur",
        "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab",
        "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura",
        "Uttar Pradesh", "Uttarakhand", "West Bengal",
        "Andaman and Nicobar Islands", "Chandigarh", "Dadra and Nagar Haveli and Daman and Diu",
        "Lakshadweep", "Delhi", "Puducherry", "Ladakh", "Jammu and Kashmir"
    ]
    
    @State var filteredState: Array<String> = []
    
    func onSearhcTextChange() -> Void {
        self.filteredState = self.indianStatesAndUTs.filter { $0.lowercased().starts(with: self.searchText.lowercased()) && $0.lowercased() != self.selectedRegion.lowercased() }
    }
    
    
    var body: some View {
        ScreenBuilder {
            
            AccentPageHeader_NoAction(pageHeaderTitle: "Indian Regions", icon: "xmark", action: {
                withAnimation {
                    self.showSelectRegionScreen = false
                }
            })
            .gesture(
                DragGesture()
                    .onChanged { changeValue in
                        if changeValue.translation.height > .zero {
                            withAnimation {
                                self.pageTranslation = changeValue.translation
                            }
                        }
                    }
                    .onEnded { changeValue in
                        if changeValue.translation.height > 150 {
                            withAnimation {
                                self.showSelectRegionScreen = false
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.pageTranslation = .zero
                            }
                        }
                    }
            )
            
            ScrollContentView {
                CustomTextField(searchText: self.$searchText, placeholder: "Search Region")
                    .onChange(of: self.searchText) {
                        self.onSearhcTextChange()
                    }
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
                if !self.selectedRegion.isEmpty {
                    SectionHeader(text: "Selected Region")
                        .padding(.top, 25)
                        .transition(.offset(x: -UIScreen.main.bounds.width / 2).combined(with: .blurReplace))
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    HStack {
                        Text(self.selectedRegion)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .applicationDropDownButton(ApplicationLinearGradient.blueGradientInverted, height: 40)
                    .transition(.offset(x: -UIScreen.main.bounds.width / 2).combined(with: .blurReplace))
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                }
                
                
                if self.searchText.isEmpty {
                    SectionHeader(text: "All Regions")
                        .padding(.top, 25)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    CustomList {
                        ForEach(self.indianStatesAndUTs.indices, id: \.self) { index in
                            Text(self.indianStatesAndUTs[index])
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(self.selectedRegion == self.indianStatesAndUTs[index] ? .white : .white.opacity(0.35))
                                .frame(height: 25)
                                .takeMaxWidthLeading()
                                .padding(.horizontal, 15)
                                .background(.white.opacity(0.001))
                                .onTapGesture {
                                    withAnimation {
                                        self.selectedRegion = self.indianStatesAndUTs[index]
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation {
                                            self.showSelectRegionScreen = false
                                        }
                                    }
                                }
                            
                            
                            if index != self.indianStatesAndUTs.count - 1 {
                                CustomDivider()
                            }
                        }
                    }
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                } else {
                    if self.filteredState.isEmpty {
                        VStack(spacing: 15) {
                            Image(systemName: "globe.desk.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.white.opacity(0.15))
                            
                            Text("No search results for \(self.searchText)")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding(.top, 100)
                    } else {
                        SectionHeader(text: "Search Results for '\(self.searchText)'")
                            .padding(.top, 25)
                            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                        
                        CustomList {
                            ForEach(self.filteredState.indices, id: \.self) { index in
                                Text(self.filteredState[index])
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(self.selectedRegion == self.filteredState[index] ? .white : .white.opacity(0.35))
                                    .frame(height: 30)
                                    .takeMaxWidthLeading()
                                    .padding(.horizontal, 15)
                                    .background(.white.opacity(0.001))
                                    .onTapGesture {
                                        withAnimation {
                                            self.selectedRegion = self.filteredState[index]
                                            self.searchText = ""
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            withAnimation {
                                                self.showSelectRegionScreen = false
                                            }
                                        }
                                    }
                                
                                
                                if index != self.filteredState.count - 1 {
                                    CustomDivider()
                                }
                            }
                        }
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    }
                    
                }
            }
        }
        .offset(y: self.pageTranslation.height)
    }
}
