//
//  UIImage+Scale.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 13/09/23.
//

import UIKit

extension UIImage {    
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthScaleRatio = targetSize.width / size.width
        let heightScaleRatio = targetSize.height / size.height
        
        // To keep the aspect ratio, scale by smaller scaling ratio
        let scaleFactor = min(widthScaleRatio, heightScaleRatio)
        
        // Compute the new image size that preservers aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        
        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        
        let image = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return image
    }
}
