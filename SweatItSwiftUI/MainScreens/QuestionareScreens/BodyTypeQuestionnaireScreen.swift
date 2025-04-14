//
//  BodyTypeQuestionnaireScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 22/03/25.
//

import SwiftUI

struct BodyTypeQuestionnaireScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    @State var currentSelectedBodyType: Extras.BodyType = .none
    
    func getStoredBodyType() -> Void {
        self.currentSelectedBodyType = self.appStates.userData.bodyType
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Choose any of the following body types, which you think fits you the best.")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
                    .padding(.horizontal, 3)
                
//                if self.currentSelectedBodyType != .none {
//                    switch self.currentSelectedBodyType {
//                    case .skinny:
//                        Text("Bro, even a stick is thicker than u 😂")
//                            .font(.system(size: 12, weight: .regular, design: .rounded))
//                            .foregroundStyle(.white.opacity(0.5))
//                            .takeMaxWidthLeading()
//                            .padding(.horizontal, 8)
//                            .padding(.top, 5)
//                            .transition(.offset(x: -UIScreen.main.bounds.width).combined(with: .blurReplace))
//                    case .muscular:
//                        Text("You'r absolute chad 🗿")
//                            .font(.system(size: 12, weight: .regular, design: .rounded))
//                            .foregroundStyle(.white.opacity(0.5))
//                            .takeMaxWidthLeading()
//                            .padding(.horizontal, 8)
//                            .padding(.top, 5)
//                            .transition(.offset(x: -UIScreen.main.bounds.width).combined(with: .blurReplace))
//                    case .skinnyFat:
//                        Text("Go back to you desk and work, nerd 🤡")
//                            .font(.system(size: 12, weight: .regular, design: .rounded))
//                            .foregroundStyle(.white.opacity(0.5))
//                            .takeMaxWidthLeading()
//                            .padding(.horizontal, 8)
//                            .padding(.top, 5)
//                            .transition(.offset(x: -UIScreen.main.bounds.width).combined(with: .blurReplace))
//                    case .fat:
//                        Text("You in a competition against an elephant or something. 🐘😂")
//                            .font(.system(size: 12, weight: .regular, design: .rounded))
//                            .foregroundStyle(.white.opacity(0.5))
//                            .takeMaxWidthLeading()
//                            .padding(.horizontal, 8)
//                            .padding(.top, 5)
//                            .transition(.offset(x: -UIScreen.main.bounds.width).combined(with: .blurReplace))
//                    case .none:
//                        Text("")
//                    }
//                }
                
                SectionHeader(text: "Choose Type")
                    .padding(.top, 25)
                
                
                
                ForEach(Extras.BodyType.allCases, id: \.self) { bodyType in
                    if bodyType != .none {
                        VStack(alignment: .leading) {
                            Text(bodyType.rawValue)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(self.currentSelectedBodyType == bodyType ? .white : .white.opacity(0.5))
                                .takeMaxWidthLeading()
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 100, alignment: .top)
                        .background(self.currentSelectedBodyType == bodyType ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
                        .overlay {
                            defaultShape
                                .stroke(.white.opacity(0.18))
                        }
                        .clipShape(defaultShape)
                        .overlay {
                            HStack {
                                switch bodyType {
                                case .skinny:
                                    Image(self.appStates.userData.gender == .male ? ApplicationImages.maleSkinny : ApplicationImages.femaleSkinny)
                                        .opacity(self.currentSelectedBodyType == bodyType ? 1 : 0.5)
                                        .allowsHitTesting(false)
                                case .muscular:
                                    Image(self.appStates.userData.gender == .male ? ApplicationImages.maleMuscular : ApplicationImages.femaleMuscular)
                                        .offset(x: self.appStates.userData.gender == .male ? 80 : 60)
                                        .opacity(self.currentSelectedBodyType == bodyType ? 1 : 0.5)
                                        .allowsHitTesting(false)
                                case .skinnyFat:
                                    Image(self.appStates.userData.gender == .male ? ApplicationImages.maleSkinnyFat : ApplicationImages.femaleSkinnyFat)
                                        .offset(x: self.appStates.userData.gender == .male ? 0 : 55, y: self.appStates.userData.gender == .male ? -35: 20)
                                        .opacity(self.currentSelectedBodyType == bodyType ? 1 : 0.5)
                                        .scaleEffect(self.appStates.userData.gender == .female ? 0.75 : 1)
                                        .allowsHitTesting(false)
                                case .fat:
                                    Image(self.appStates.userData.gender == .male ? ApplicationImages.maleFat : ApplicationImages.femaleFat)
                                        .opacity(self.currentSelectedBodyType == bodyType ? 1 : 0.5)
                                        .offset(x: self.appStates.userData.gender == .female ? 30 : 0)
                                        .allowsHitTesting(false)
                                case .none:
                                    Image("skinny")
                                        .allowsHitTesting(false)
                                }
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                        }
                        .clipped()
                        .onTapGesture {
                            withAnimation {
                                self.currentSelectedBodyType = bodyType
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding)
            .onChange(of: self.currentSelectedBodyType) {
                self.appStates.userData.bodyType = self.currentSelectedBodyType
            }
            .onAppear {
                self.getStoredBodyType()
            }
        }
    }
}

