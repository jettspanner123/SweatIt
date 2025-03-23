//
//  BodyTypeQuestionnaireScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 22/03/25.
//

import SwiftUI

struct BodyTypeQuestionnaireScreen: View {
    
    @State var currentSelectedBodyType: Extras.BodyType = .none
    var body: some View {
        VStack {
            Text("Choose any of the following body types, which you think fits you the best.")
                .font(.system(size: 12, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .takeMaxWidthLeading()
                .padding(.horizontal, 3)
            
            if self.currentSelectedBodyType != .none {
                switch self.currentSelectedBodyType {
                case .skinny:
                    Text("Bro, even a stick is thicker than u 😂")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .padding(.horizontal, 8)
                        .padding(.top, 5)
                        .transition(.offset(x: -UIScreen.main.bounds.width).combined(with: .blurReplace))
                case .muscular:
                    Text("You'r absolute chad 🗿")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .padding(.horizontal, 8)
                        .padding(.top, 5)
                        .transition(.offset(x: -UIScreen.main.bounds.width).combined(with: .blurReplace))
                case .skinnyFat:
                    Text("Go back to you desk and work, nerd 🤡")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .padding(.horizontal, 8)
                        .padding(.top, 5)
                        .transition(.offset(x: -UIScreen.main.bounds.width).combined(with: .blurReplace))
                case .fat:
                    Text("You in a competition against an elephant or something. 🐘😂")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .padding(.horizontal, 8)
                        .padding(.top, 5)
                        .transition(.offset(x: -UIScreen.main.bounds.width).combined(with: .blurReplace))
                case .none:
                    Text("")
                }
            }
            
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
                                Image("skinny")
                                    .opacity(self.currentSelectedBodyType == bodyType ? 1 : 0.5)
                                    .allowsHitTesting(false)
                            case .muscular:
                                Image("upperbody")
                                    .offset(x: 80)
                                    .opacity(self.currentSelectedBodyType == bodyType ? 1 : 0.5)
                                    .allowsHitTesting(false)
                            case .skinnyFat:
                                Image("skinny_fat")
                                    .offset(y: -35)
                                    .opacity(self.currentSelectedBodyType == bodyType ? 1 : 0.5)
                                    .allowsHitTesting(false)
                            case .fat:
                                Image("fat")
                                    .opacity(self.currentSelectedBodyType == bodyType ? 1 : 0.5)
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
    }
}

