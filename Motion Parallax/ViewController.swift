//
//  ViewController.swift
//  Motion Parallax
//
//  Created by Yash Shah on 20/03/22.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let backgroundImageView = UIImageView(frame: view.frame)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "bgImage")
        view.addSubview(backgroundImageView)
        
        let overlayView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        overlayView.frame = view.frame
        view.addSubview(overlayView)
        
        let containerView = UIView()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 16
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "bgImage")
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 16
        containerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        let imageViewCenter = view.center
        
        motionManager.startDeviceMotionUpdates(to: .main) { data, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                print("Error in the data")
                return
            }
            let multiple: Double = 30
            let xOffset = CGFloat(multiple * min(max(-1, data.attitude.roll), 1))
            let yOffset = CGFloat(multiple * min(max(-1, data.attitude.pitch), 1))
            print("X: \(data.attitude.roll) Y: \(data.attitude.pitch)")
            UIView.animate(withDuration: 0.15) {
//                imageView.center = CGPoint(x: imageViewCenter.x - xOffset, y: imageViewCenter.y - yOffset)
                containerView.center = CGPoint(x: imageViewCenter.x + xOffset, y: imageViewCenter.y + yOffset)
            }
        }
    }
}

