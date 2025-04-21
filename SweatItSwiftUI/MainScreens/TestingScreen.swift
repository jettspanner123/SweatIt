import SwiftUI
import Vision
import CoreML
import AVFoundation

struct TestingScreen: View {
    @StateObject private var cameraModel = CameraViewModel()

    var body: some View {
        VStack {
            Text("Action: \(cameraModel.actionLabel)")
                .font(.title)
                .padding()

            CameraPreview_t(session: cameraModel.session)
                .onAppear {
                    cameraModel.startSession()
                }
                .onDisappear {
                    cameraModel.stopSession()
                }
        }
    }
}

struct CameraPreview_t: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

class CameraViewModel: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    @Published var actionLabel = "Loading..."

    let session = AVCaptureSession()
    private let poseRequest = VNDetectHumanBodyPoseRequest()
    
    private var poseWindow: [[VNHumanBodyPoseObservation]] = []
    private let maxFrames = 30  // Match your model’s input

    override init() {
        super.init()
        configureSession()
    }

    func configureSession() {
        session.sessionPreset = .medium

        guard let camera = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: camera) else {
            print("Camera setup failed")
            return
        }

        session.addInput(input)

        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        session.addOutput(output)
    }

    func startSession() {
        session.startRunning()
    }

    func stopSession() {
        session.stopRunning()
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        try? handler.perform([poseRequest])

        guard let observations = poseRequest.results else { return }

        DispatchQueue.main.async {
            self.processPoses(observations)
        }
    }

    func processPoses(_ poses: [VNHumanBodyPoseObservation]) {
        guard let pose = poses.first else { return }

        // Keep last N poses
        if poseWindow.count >= maxFrames {
            poseWindow.removeFirst()
        }
        poseWindow.append([pose])

        if poseWindow.count == maxFrames {
            classifyAction()
        }
    }

    func classifyAction() {
        // Convert poseWindow into MLMultiArray format for model input
        guard let multiArray = try? convertToMultiArray(poseWindow) else {
            print("Pose conversion failed")
            return
        }

        do {
            let model = try PushupRecogniser(configuration: MLModelConfiguration())
            let input = PushupRecogniserInput(poses: multiArray)
            let result = try model.prediction(input: input)

            DispatchQueue.main.async {
                self.actionLabel = result.label
            }
        } catch {
            print("Classification failed: \(error)")
        }
    }

    func convertToMultiArray(_ window: [[VNHumanBodyPoseObservation]]) throws -> MLMultiArray {
        // Flatten N frames of 18 keypoints (x, y) => MLMultiArray shape [N, 18]
        let numFrames = window.count
        let numKeypoints = 18
        let array = try MLMultiArray(shape: [NSNumber(value: numFrames), NSNumber(value: numKeypoints)], dataType: .double)

        for (frameIdx, poses) in window.enumerated() {
            guard let pose = poses.first else { continue }

            let recognizedPoints = try pose.recognizedPoints(.all)

            let orderedJoints: [VNHumanBodyPoseObservation.JointName] = [
                .nose, .leftEye, .rightEye, .leftEar, .rightEar,
                .leftShoulder, .rightShoulder, .leftElbow, .rightElbow,
                .leftWrist, .rightWrist, .leftHip, .rightHip,
                .leftKnee, .rightKnee, .leftAnkle, .rightAnkle,
                .root
            ]

            for (keypointIdx, joint) in orderedJoints.enumerated() {
                let point = recognizedPoints[joint]?.location ?? CGPoint.zero
                let normalized = Double(point.x + point.y) / 2.0
                let idx = frameIdx * numKeypoints + keypointIdx
                array[idx] = NSNumber(value: normalized)
            }
        }

        return array
    }
}

#Preview {
    TestingScreen()
}
