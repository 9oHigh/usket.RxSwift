//
//  FilterService.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2022/09/26.
//

import UIKit
import RxSwift
import CoreImage

final class FilterService {
    
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
    
    func applyFilter(to InputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: InputImage) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgimg =
                self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                
                let processedImage = UIImage(cgImage: cgimg, scale: InputImage.scale, orientation: InputImage.imageOrientation)
                
                completion(processedImage)
            }
        }
    }
}
