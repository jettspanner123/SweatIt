import SwiftUI
import UIKit

struct CameraView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var capturedImage: UIImage?
    @State private var isShowingCamera = true

    var body: some View {
        ZStack {
            if isShowingCamera {
                CameraPreview(isShown: $isShowingCamera, capturedImage: $capturedImage)
                    .ignoresSafeArea()
            }
        }
        .onChange(of: capturedImage) {
            if capturedImage != nil {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct CameraPreview: UIViewControllerRepresentable {
    @EnvironmentObject var appStates: ApplicationStates
    @Binding var isShown: Bool
    @Binding var capturedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // no need to update anything live
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPreview

        init(parent: CameraPreview) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.capturedImage = image
            }
            parent.isShown = false
            withAnimation {
                self.parent.appStates.showCameraScreen = false
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
            withAnimation {
                self.parent.appStates.showCameraScreen = false
            }
        }
    }
}

