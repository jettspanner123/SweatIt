//
//  FoodScannerScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 13/03/25.
//

import SwiftUI
import AVFoundation

struct FoodScannerScreen: View {
    
    enum ScannerType: String, CaseIterable {
        case barcode = "camera.fill", food = "Food"
    }
    
    @Binding var showCameraScreen: Bool
    
    @State var pageTranslation: CGSize = .zero
    
    @State var isFlashlightOn: Bool = false
    @State var flashLightDimentions: CGFloat = UIScreen.main.bounds.width - 60
    @State var currentScannerType: ScannerType = .barcode
    
    var captureDevice: AVCaptureDevice! = AVCaptureDevice.default(for: .video) ?? nil
    
    @State var tempState: Bool = false
    
    @State var isFoodVisible: Bool = false
    
    func changeFlashlight(to state: Bool) {
        guard let captureDevice = captureDevice else { return }
        do {
            try captureDevice.lockForConfiguration()
            
            if captureDevice.hasTorch {
                if state {
                    try captureDevice.setTorchModeOn(level: 1)
                } else {
                    captureDevice.torchMode = .off
                }
            }
        } catch {
            print(String(error.localizedDescription))
        }
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            if self.currentScannerType == .food {
                Text(self.isFoodVisible ? "Food Visible" : "Food Not Visible")
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(height: 35)
                    .padding(.horizontal)
                    .background(self.isFoodVisible ? ApplicationLinearGradient.greenGradient : ApplicationLinearGradient.redGradient)
                    .clipShape(Capsule())
                    .offset(y: 60)
                    .zIndex(.infinity)
                    .transition(.offset(y: -UIScreen.main.bounds.height / 2).combined(with: .blurReplace))
            }
            
            
            if self.currentScannerType == .food {
                HStack {
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .background(AppBackgroundBlur(radius: 100, opaque: true))
                .background(.darkBG.opacity(0.5))
                .offset(y: UIScreen.main.bounds.height - 150)
                .zIndex(9999)
                .transition(.offset(y: 150))
            }
            
            if self.currentScannerType == .barcode {
                
                // MARK: Page header with buttons
                HStack {
                    Text("Food Analysis")
                        .font(.system(size: 25, weight: .light, design: .rounded))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .overlay {
                    
                    // MARK: BUtton overlay
                    HStack {
                        Image(systemName: "xmark")
                            .scaleEffect(1)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.white.opacity(0.001))
                            .onTapGesture {
                                withAnimation {
                                    self.showCameraScreen = false
                                }
                                
                            }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }
                .offset(y: 65)
                .zIndex(11111)
                .transition(.offset(y: -200))
                
            }
            
            VStack {
                
                
                // MARK: MAsk camera square
                HStack {
                    
                    // MARK: HOrizontal red line hai ye
                    if self.currentScannerType == .barcode {
                        HStack {
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .background(ApplicationLinearGradient.redGradient)
                        .transition(.blurReplace)
                        
                    }
                    
                }
                .frame(width: self.flashLightDimentions, height: self.currentScannerType == .barcode ? self.flashLightDimentions : UIScreen.main.bounds.height - ApplicationPadding.mainScreenVerticalPadding * 2 - 70, alignment: self.tempState ? .top : .bottom)
                .overlay {
                    defaultShape
                        .stroke(self.currentScannerType == .food ? .clear : .white.opacity(0.18))
                }
                .clipShape(defaultShape)
                
                
                HStack {
                    
                    // MARK: Upload from gallery button
                    HStack {
                        Image(systemName: "photo")
                            .foregroundStyle(.white)
                        
                        Text("Gallery")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .padding(12)
                    .background(ApplicationLinearGradient.redGradient)
                    .overlay {
                        Capsule()
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(Capsule())
                    .onTapGesture {
                        print("Hello world")
                    }
                    
                    
                    
                    // MARK: Choose scanner type
                    HStack(spacing: 0) {
                        
                        HStack {
                            Image(systemName: "camera.fill")
                                .foregroundStyle(.white)
                            
                        }
                        .frame(width: 45, height: 45)
                        .background(self.currentScannerType == .barcode ? ApplicationLinearGradient.redGradient : ApplicationLinearGradient.clearGradient)
                        .clipShape(Capsule())
                        .onTapGesture {
                            withAnimation {
                                self.currentScannerType = .barcode
                            }
                        }
                        
                        HStack {
                            Image("Food")
                                .foregroundStyle(.white)
                            
                        }
                        .frame(width: 45, height: 45)
                        .background(self.currentScannerType == .food ? ApplicationLinearGradient.redGradient : ApplicationLinearGradient.clearGradient)
                        .clipShape(Capsule())
                        .onTapGesture {
                            withAnimation {
                                self.currentScannerType = .food
                            }
                        }
                        .sensoryFeedback(.increase, trigger: self.currentScannerType)
                        .sensoryFeedback(.impact, trigger: self.isFlashlightOn)
                        
                    }
                    .background(.darkBG)
                    .overlay {
                        Capsule()
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(Capsule())
                    .clipped()
                    
                    
                    
                    // MARK: Flash light button
                    HStack {
                        Image(systemName: self.isFlashlightOn ? "flashlight.on.fill" : "flashlight.off.fill")
                            .foregroundStyle(.white)
                    }
                    .frame(width: 45, height: 45)
                    .background(self.isFlashlightOn ? ApplicationLinearGradient.redGradient : ApplicationLinearGradient.darkBGSameGradient)
                    .overlay {
                        Circle()
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(Circle())
                    .onTapGesture {
                        withAnimation {
                            self.isFlashlightOn.toggle()
                        }
                        self.changeFlashlight(to: self.isFlashlightOn)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, ApplicationPadding.mainScreenVerticalPadding + 50)
            .background(AppBackgroundBlur(radius: self.currentScannerType == .food ? 0 : 10, opaque: true))
            .background(self.currentScannerType == .food ? .clear : .darkBG.opacity(0.88))
            .zIndex(9999)
            
            
            
            // MARK: Shutter button
            if self.currentScannerType == .food {
                HStack {
                    Image(systemName: "camera.fill")
                        .foregroundStyle(.black)
                }
                .frame(width: 80, height: 80)
                .background(Circle().fill(.white.gradient))
                .offset(y: UIScreen.main.bounds.height - 170)
                .zIndex(11111)
                .transition(.asymmetric(insertion: .offset(x: -UIScreen.main.bounds.width), removal: .offset(x: UIScreen.main.bounds.width)))
                .onTapGesture {
                    ApplicationHelper.playSound(of: ApplicationHelper.Sounds.cameraShutter)
                }
            }
            
            
            CameraView()
                .ignoresSafeArea()
                .zIndex(9997)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.black)
        .offset(y: self.pageTranslation.height)
        .ignoresSafeArea()
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
                    if value.translation.height < 150 {
                        withAnimation(.bouncy) {
                            self.pageTranslation = .zero
                        }
                    } else {
                        withAnimation(.smooth) {
                            self.showCameraScreen = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            self.pageTranslation = .zero
                        }
                    }
                }
        )
        .onAppear {
            withAnimation(.linear(duration: 1.5).delay(0).repeatForever(autoreverses: true)) {
                self.tempState.toggle()
            }
        }
    }
}


struct CameraView: UIViewControllerRepresentable {
    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        var parent: CameraView
        
        init(parent: CameraView) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        let session = AVCaptureSession()
        
        session.beginConfiguration()
        
        guard let device = AVCaptureDevice.default(for: .video) else { return viewController }
        guard let input = try? AVCaptureDeviceInput(device: device) else { return viewController }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = viewController.view.bounds
        viewController.view.layer.addSublayer(previewLayer)
        
        let output = AVCaptureVideoDataOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        
        session.commitConfiguration()
        session.startRunning()
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
    FoodScannerScreen(showCameraScreen: .constant(true))
}
