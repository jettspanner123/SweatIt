//
//  AddAgendaScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 26/03/25.
//

import SwiftUI

struct AddAgendaScreen: View {
    
    @Binding var showAddAgendaScreen: Bool
    @Binding var agendaList: Array<Agenda_t>
    
    
    @State var pageTranslation: CGSize = .zero
    @State var agendaTitle: String = ""
    
    
    @State var agendaDescription: String = "Description"
    @State var isSubmitButtonClicked: Bool = false
    
    @State var showErrorMessage: Bool = false
    
    
    func addAgenda() -> Void {
        withAnimation {
            self.isSubmitButtonClicked = true
        }
        
        if self.agendaTitle.isEmpty || self.agendaDescription.isEmpty {
            withAnimation {
                self.isSubmitButtonClicked = false
                self.showErrorMessage = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.showErrorMessage = false
                }
            }
            
            return
        }
        
        self.agendaList.append(.init(title: self.agendaTitle, description: self.agendaDescription))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.isSubmitButtonClicked = false
                self.showAddAgendaScreen = false
            }
        }
    }
    
    
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            
            // MARK: Submit button
            HStack {
                if self.isSubmitButtonClicked {
                    ProgressView()
                        .tint(.white)
                        .frame(maxWidth: .infinity)
                        .transition(.blurReplace)
                } else {
                    Text("Submit")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .transition(.blurReplace)
                }
            }
            .applicationDropDownButton(ApplicationLinearGradient.redGradient, height: 40)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            .offset(y: BOTTOM_BUTTON_OFFSET)
            .zIndex(.infinity)
            .onTapGesture {
                self.addAgenda()
                ApplicationHelper.impactOccured(style: .light)
            }
            
            
            // MARK: Page heading
            HStack {
                
                Text("Add Agenda")
                    .font(.system(size: 25, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                
            }
            .frame(maxWidth: .infinity)
            .overlay {
                HStack {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .padding()
                        .background(.white.opacity(0.001))
                        .onTapGesture {
                            withAnimation {
                                self.showAddAgendaScreen = false
                            }
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding + 5)
            }
            .padding(.top, ApplicationPadding.mainScreenVerticalPadding - SCROLL_CONSTANT)
            .padding(.bottom, 20)
            .background(
                HStack {
                    
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(AppBackgroundBlur(radius: 10, opaque: false))
                    .padding(.top, -15)
                    .padding(.horizontal, -15)
                    .padding(.bottom, 15)
            )
            
            .zIndex(11)
            
            
            
            
            
            
            
            
            
            
            // MARK: Scroll content View
            ScrollView(.vertical, showsIndicators: false) {
                
                
                // MARK: Vertical stack
                VStack {
                    
                    SectionHeader(text: "Agenda Details")
                    
                    
                    // MARK: Agenda title
                    CustomTextField(searchText: self.$agendaTitle, placeholder: "Title")
                    
                    
                    
                    
                    // MARK: Agenda Description
                    HStack {
                        TextEditor(text: self.$agendaDescription)
                            .font(.system(size: 15))
                            .background(.clear)
                            .scrollContentBackground(.hidden)
                            .padding(.top, 5)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .applicationDropDownButton(height: 150)
                    
                    if self.showErrorMessage {
                        Text("All the fields must be filled.")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundStyle(.red)
                            .padding(.top)
                            .transition(.blurReplace)
                    }
                    
                    
                }
                .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding + (SCROLL_CONSTANT * 2) + 10)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
            }
            
        }
        .frame(maxWidth: .infinity)
        .background(AppBackgroundBlur(radius: 100, opaque: true))
        .background(.darkBG.opacity(0.54))
        .clipped()
        .ignoresSafeArea()
        .offset(y: self.pageTranslation.height)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.height > .zero {
                        withAnimation(.bouncy) {
                            self.pageTranslation = value.translation
                        }
                    }
                }
                .onEnded { value in
                    if value.translation.height > 150 {
                        withAnimation(.smooth) {
                            self.showAddAgendaScreen = false
                        }
                        
                        DispatchQueue.main
                            .asyncAfter(deadline: .now() + 0.4, execute: {
                                self.pageTranslation = .zero
                            })
                    } else {
                        withAnimation(.smooth) {
                            self.pageTranslation = .zero
                        }
                    }
                }
        )
    }
}

