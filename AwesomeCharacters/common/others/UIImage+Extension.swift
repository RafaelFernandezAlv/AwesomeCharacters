//
//  UIImage+Extension.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 29/11/21.
//

import Foundation
import UIKit

extension UIImage {
    func blurEffect() -> UIImage? {
        guard let currentFilter = CIFilter(name: "CIGaussianBlur"),
              let cropFilter = CIFilter(name: "CICrop")else { return nil }
        let beginImage = CIImage(image: self)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(10, forKey: kCIInputRadiusKey)

        cropFilter.setValue(currentFilter.outputImage, forKey: kCIInputImageKey)
        cropFilter.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")

        let context = CIContext(options: nil)
        guard let output = cropFilter.outputImage else { return nil }
        let cgimg = context.createCGImage(output, from: output.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        return processedImage
    }
}
