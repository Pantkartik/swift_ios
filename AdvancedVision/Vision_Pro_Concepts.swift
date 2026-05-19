import Vision
import CoreImage

class AdvancedVisionManager {
    
    // MARK: - Hand Pose Detection
    func detectHandPose(in image: CGImage) {
        let request = VNDetectHumanHandPoseRequest { request, error in
            guard let observations = request.results as? [VNHumanHandPoseObservation] else {
                return
            }
            
            for observation in observations {
                do {
                    // Extracting specific points like the index finger tip
                    let indexTip = try observation.recognizedPoint(.indexTip)
                    if indexTip.confidence > 0.8 {
                        print("Index Finger Tip detected at: \(indexTip.location)")
                    }
                } catch {
                    print("Error extracting points: \(error)")
                }
            }
        }
        
        request.maximumHandCount = 2
        
        let handler = VNImageRequestHandler(cgImage: image, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform hand pose request: \(error)")
        }
    }
}
