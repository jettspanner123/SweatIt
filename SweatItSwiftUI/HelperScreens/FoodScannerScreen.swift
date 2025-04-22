import SwiftUI
import AVFoundation
@preconcurrency import GoogleGenerativeAI
//
//struct FoodScannerScreen: View {
//
//    // MARK: - State Variables
//    @Binding var showCameraScreen: Bool
//    @State private var selectedImage: UIImage?
//    @State private var showImagePicker = false
//    @State private var sourceType: UIImagePickerController.SourceType = .camera
//    @State private var responseText: String?
//
//    let model: GenerativeModel
//
//    // MARK: - Initialization
//    init(showCameraScreen: Binding<Bool>) {
//        self._showCameraScreen = showCameraScreen
//        let apiKey = "AIzaSyAnqRlW22bqKvIKWNgzKCT3UgbHK8vqlhw" // Replace with your actual API key
//        model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: apiKey)
//    }
//
//    // MARK: - Image Resizing
//    private func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//        image.draw(in: CGRect(origin: .zero, size: size))
//        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return resizedImage
//    }
//
//    // MARK: - Food Analysis
//    private func analyzeFood(image: UIImage) {
//        Task {
//            guard let resizedImage = resizeImage(image, to: CGSize(width: 512, height: 512)) else {
//                responseText = "Failed to resize image."
//                return
//            }
//            let prompt = """
//            Identify the food in this image and estimate its nutritional content. Provide the response using only these labels with their values:
//
//            Food Item: <value>
//            Approx Calories: <value>
//            Weight: <value> grams
//            Protein: <value> grams
//            Fat: <value> grams
//            Carbs: <value> grams
//
//            If the photo does not contain any food image, them simply give <null>, nothing else.
//            """
//            do {
//                let response = try await model.generateContent(prompt, resizedImage)
//                responseText = response.text ?? "No response received."
//            } catch {
//                responseText = "Error: \(error.localizedDescription)"
//            }
//        }
//    }
//
//    // MARK: - Body
//    var body: some View {
//
//        ZStack(alignment: .top) {
//
//
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(
//                AppBackgroundBlur(radius: 100, opaque: true)
//        )
//        .ignoresSafeArea()
////        ZStack(alignment: .top) {
////            // Background
////            Color.black.ignoresSafeArea()
////
////            // Main UI Elements
////            VStack {
////                // Control Buttons
////                HStack {
////                    // Gallery Button
////                    Button(action: {
////                        self.sourceType = .photoLibrary
////                        self.showImagePicker = true
////                    }) {
////                        HStack {
////                            Image(systemName: "photo")
////                            Text("Gallery")
////                        }
////                        .padding(12)
////                        .background(Color.red)
////                        .foregroundColor(.white)
////                        .clipShape(Capsule())
////                    }
////
////                    // Camera Button
////                    Button(action: {
////                        self.sourceType = .camera
////                        self.showImagePicker = true
////                    }) {
////                        HStack {
////                            Image(systemName: "camera.fill")
////                            Text("Take Photo")
////                        }
////                        .padding(12)
////                        .background(Color.blue)
////                        .foregroundColor(.white)
////                        .clipShape(Capsule())
////                    }
////                }
////                .padding(.top, 20)
////
////                Spacer()
////
////                // Response Text Overlay
////                if let text = responseText {
////                    Text(text)
////                        .foregroundColor(.black)
////                        .padding()
////                        .background(Color.white)
////                        .cornerRadius(10)
////                        .padding()
////                }
////            }
////            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
////            .padding(.top, 50)
////            .background(Color.black.opacity(0.88))
////        }
////        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
////        .ignoresSafeArea()
////        .sheet(isPresented: $showImagePicker) {
////            ImagePicker(selectedImage: self.$selectedImage, sourceType: self.sourceType)
////        }
////        .onChange(of: selectedImage) { newImage in
////            if let image = newImage {
////                analyzeFood(image: image)
////            }
////        }
//    }
//}

struct FoodScannerScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    
    @State var pageTranslation: CGSize = .zero
    @State var responseText: String = ""
    
    let model: GenerativeModel
    
    init() {
        let apiKey = "AIzaSyAnqRlW22bqKvIKWNgzKCT3UgbHK8vqlhw"
        model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: apiKey)
    }
    private func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    private func analyzeFood(image: UIImage) {
        
        
        Task {
            withAnimation {
                self.appStates.isFoodScannerLoading = true
            }
            guard let resizedImage = resizeImage(image, to: CGSize(width: 512, height: 512)) else {
                responseText = "Failed to resize image."
                return
            }
//            var caloriesPerGram: Double
//        var protienPerGram: Double
//        var carbsPerGram: Double
//        var fatsPerGram: Double
            let prompt: String = """
            Generate a strict JSON object with foodName as non-empty string of max 5 words, 
            foodDescription as non-empty of atleast 50 words and max 75 words and foodType which is also a non-empty string and can be either of these [`Junk 💩`, `Clean 🥦`, `Beverage 🥛`], just like the others foodImage shoudl also be non-empty string with a link to the image anywhere from the web,
            don't generate it yourself, make sure that the food should be in the middle of the image and the image should be white, and one thing over everything is the the image should be valid, not like that broken image,foodQuantity as a double value representing grams, calories, protein, carbs, fats, protienPerGram, carbsPerGram, fatsPerGram and calories_per_gram as double values if the image is of food, just give out null if the image is not a food item — and return only the JSON object without extra text and if there is no food item just return null no other text.
            """
            
            do {
                let response = try await model.generateContent(prompt, resizedImage)
                responseText = response.text ?? "No response received."
                self.appStates.scannedFoodDetail = response.text ?? "No response received."
                print(responseText)
            } catch {
                responseText = "Error: \(error.localizedDescription)"
            }
            withAnimation {
                self.appStates.isFoodScannerLoading = false
            }
        }
        
        
    }
    
    
    var body: some View {
        ZStack {
            CameraView(capturedImage: self.$appStates.currentSelectedFoodImage)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppBackgroundBlur(radius: 100, opaque: true))
        .background(.darkBG.opacity(0.54))
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
                    if value.translation.height > 100 {
                        withAnimation {
                            self.appStates.showCameraScreen = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                self.pageTranslation = .zero
                            }
                        }
                    } else {
                        withAnimation {
                            self.pageTranslation = .zero
                        }
                    }
                    
                    
                }
        )
        .zIndex(.infinity)
        .onChange(of: self.appStates.currentSelectedFoodImage) {
            if let image = self.appStates.currentSelectedFoodImage {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.analyzeFood(image: image)
                }
                return
            }
            
            print("didn't get image")
        }
        .onChange(of: self.appStates.isFoodScannerLoading) {
            print("Food loading", self.appStates.isFoodScannerLoading)
        }
    }
}


