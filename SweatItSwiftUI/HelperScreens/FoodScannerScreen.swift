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
    
    @Binding var showCameraScreen: Bool
    
    @State var pageTranslation: CGSize = .zero
    
    @State var cameraObject = CameraModel()
    
    var body: some View {
        ZStack {
            
            CameraPreview(camera: self.cameraObject)
                .ignoresSafeArea()
            
            
            VStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
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
                            self.showCameraScreen = false
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
        .onAppear {
            self.cameraObject.checkPermissiont()
        }
        .zIndex(.infinity)
    }
}

class CameraModel: ObservableObject {
    @Published var isTaken: Bool = false
    
    @Published var session = AVCaptureSession()
    @Published var output = AVCapturePhotoOutput()
    
    @Published var previewLayer: AVCaptureVideoPreviewLayer!
    
    func checkPermissiont() -> Void {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.setUp()
            return
        default:
            return
        }
    }
    
    func setUp() -> Void {
        do {
            self.session.beginConfiguration()
            
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            let input = try AVCaptureDeviceInput(device: device!)
            
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
            
        } catch {
            print(error.localizedDescription)
        }
    }
}


struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIViewType(frame: UIScreen.main.bounds)
        self.camera.previewLayer = AVCaptureVideoPreviewLayer(session: self.camera.session)
        self.camera.previewLayer.frame = view.frame
        self.camera.previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(self.camera.previewLayer)
        
        self.camera.session.startRunning()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
}
