import SwiftUI

struct MacrosViewCard: View {
    var body: some View {
        VStack {
            Text("Macros")
                .font(.system(size: 20, weight: .light, design: .rounded))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: Protein heading
            Text("Protien")
                .font(.system(size: 15, weight: .light, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
            
            // MARK: Protein loading bar
            GeometryReader { geometry in
                HStack {
                    
                    // MARK: actual loading bar
                    HStack {
                        
                    }
                    .frame(maxHeight: .infinity)
                    .frame(width: geometry.size.width * 0.2)
                    .background(ApplicationLinearGradient.greenGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay {
                        HStack {
                           Text("12g")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 15)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 40)
                .background(ApplicationLinearGradient.greenGradient.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    HStack {
                        Text("82g")
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 15)
                }
                
                
            }
            .frame(height: 35)
            
            
             // MARK: Carbs heading
            Text("Carbs")
                .font(.system(size: 15, weight: .light, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
            
            
            // MARK: Carbs loading bar
            GeometryReader { geometry in
                HStack {
                    
                    // MARK: actual loading bar
                    HStack {
                        
                    }
                    .frame(maxHeight: .infinity)
                    .frame(width: geometry.size.width * 0.65)
                    .background(ApplicationLinearGradient.brownGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay {
                        HStack {
                           Text("17g")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 15)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 40)
                .background(ApplicationLinearGradient.brownGradient.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    HStack {
                        Text("30g")
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 15)
                }
                
                
            }
            .frame(height: 35)
            
            
            // MARK: Fats heading
            Text("Fats")
                .font(.system(size: 15, weight: .light, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
            
            
            
            // MARK: Fats loading bar
            GeometryReader { geometry in
                HStack {
                    
                    // MARK: actual loading bar
                    HStack {
                        
                    }
                    .frame(maxHeight: .infinity)
                    .frame(width: geometry.size.width * 0.5)
                    .background(ApplicationLinearGradient.goldenGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay {
                        HStack {
                           Text("7g")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 15)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 40)
                .background(ApplicationLinearGradient.goldenGradient.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    HStack {
                        Text("15g")
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 15)
                }
                
                
            }
            .frame(height: 45)
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(.darkBG.opacity(0.54))
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.18))
        }
        .clipShape(defaultShape)
        
    }
}

