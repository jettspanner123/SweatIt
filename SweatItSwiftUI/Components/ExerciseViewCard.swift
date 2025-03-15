import SwiftUI

struct ExerciseViewCard: View {
    
    var exercise: Exercise_t
    
    var body: some View {
        HStack {
            
            // MARK: Image view
            HStack {
                Image("pushups")
                    .scaleEffect(0.5)
            }
            .frame(maxHeight: .infinity)
            .frame(width: 100)
            .background(.white)
            
            // MARK: Content view
            VStack {
                Text(self.exercise.exerciseName)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Spacer()
                // MARK: Targetted muscles
                HStack {
                    ForEach(self.exercise.targettedMuscles.prefix(2), id: \.self) { muscle in
                        HStack(spacing: 5) {
                            Text(muscle.rawValue)
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 13))
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        //                        .background(.darkBG.opacity(0.54))
                        .background(ApplicationLinearGradient.redGradient)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white.opacity(0.18))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    if self.exercise.targettedMuscles.count > 2 {
                        
                        Image(systemName: "ellipsis")
                            .resizable()
                            .frame(width: 10, height: 3)
                            .foregroundStyle(.white.opacity(0.5))
                            .offset(y: 5)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .overlay {
                
                // MARK: Navigation icon
                HStack {
                    Image(systemName: "chevron.right")
                        .scaleEffect(0.75)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 25)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 90,  alignment: .leading)
        .background(.darkBG.opacity(0.54))
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.18))
        }
        .clipShape(defaultShape)
    }
}
