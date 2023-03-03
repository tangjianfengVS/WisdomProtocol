//
//  File.swift
//  Pods
//
//  Created by 汤建锋 on 2023/3/2.
//

import UIKit

fileprivate let WisdomImageCache = NSCache<AnyObject, AnyObject>()

fileprivate var WisdomTrackingImages: [WisdomWeakable<UIImageView>]?

extension UIImageView {
    
    private struct WisdomLoadImage{ static var imageName = "WisdomLoadImage.imageName" }
    
    fileprivate var loadImageName: String {
        set { objc_setAssociatedObject(self, &WisdomLoadImage.imageName, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
        get { return objc_getAssociatedObject(self, &WisdomLoadImage.imageName) as? String ?? "" }
    }

    func loadImageable(imageName: String, placeholderImage: UIImage?=nil) {
        image = nil
        let res_imageName = imageName.replacingOccurrences(of: "/", with: "")
        loadImageName = res_imageName
        if res_imageName.isEmpty {
            image = placeholderImage
            return
        }
        WisdomProtocolCore.load(imageName: res_imageName) { [weak self] (image, image_name) in
            if let myself = self, image_name == myself.loadImageName {
                myself.image = image
            }
        } emptyClosure: { [weak self] in
            if let myself = self, myself.loadImageName.isEmpty {
                myself.image = placeholderImage
            }
        }
    }
}

extension WisdomProtocolCore {
    
    static var ImageCachePath: String {
        get { return (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? "")+"/" }
    }
    
    // save
    static func save(image: UIImage, imageName: String){
        if Thread.isMainThread, WisdomTrackingImages?.count ?? 0 > 0 {
            updateImage()
        }else if WisdomTrackingImages?.count ?? 0 > 0 {
            DispatchQueue.main.async { updateImage() }
        }
        
        DispatchQueue.global().async {
            let res_imageName = imageName.replacingOccurrences(of: "/", with: "")
            if res_imageName.isEmpty {
                return
            }
            
            WisdomImageCache.setObject(image, forKey: res_imageName as AnyObject)
            
            let cachePath = ImageCachePath+res_imageName
            var imageData = image.pngData()
            if imageData == nil {
                imageData = image.jpegData(compressionQuality: 1)
            }
            let urlPath = URL(fileURLWithPath: cachePath)
            do {
                try imageData?.write(to: urlPath, options: Data.WritingOptions.atomicWrite)
            }catch {
                print(error)
            }
        }
        
        func updateImage(){
            WisdomTrackingImages = WisdomTrackingImages?.compactMap({ weakable in
                if let imageView = weakable.able {
                    if !imageView.loadImageName.isEmpty, imageView.loadImageName == imageName.replacingOccurrences(of: "/", with: "") {
                        imageView.image = image
                    }
                    return weakable
                }
                return nil
            })
        }
    }
    
    // load
    static func load(imageName: String, imageClosure: @escaping (UIImage,String)->(), emptyClosure: @escaping ()->()){
        let res_imageName = imageName.replacingOccurrences(of: "/", with: "")
        if res_imageName.isEmpty {
            emptyClosure()
            return
        }
        
        if let image = WisdomImageCache.object(forKey: res_imageName as AnyObject) as? UIImage {
            imageClosure(image, imageName)
        }else {
            DispatchQueue.global().async {
                let imageURL = URL(fileURLWithPath: ImageCachePath+res_imageName) as CFURL
                let options = [
                    kCGImageSourceCreateThumbnailFromImageAlways: true,
                    kCGImageSourceCreateThumbnailWithTransform: true,
                    kCGImageSourceShouldCacheImmediately: true,
                    kCGImageSourceThumbnailMaxPixelSize: 500
                ] as CFDictionary
                
                var image: UIImage?
                if let source: CGImageSource = CGImageSourceCreateWithURL(imageURL, nil),
                   let imageRef: CGImage = CGImageSourceCreateThumbnailAtIndex(source, 0, options) {
                    let res_image: UIImage = UIImage(cgImage: imageRef)
                    image = res_image
                    WisdomImageCache.setObject(res_image, forKey: res_imageName as AnyObject)
                }
                DispatchQueue.main.async {
                    image == nil ? emptyClosure() : imageClosure(image!, imageName)
                }
            }
        }
    }
    
    static func trackImageable(imageView: UIImageView){
        if WisdomTrackingImages == nil {
            WisdomTrackingImages = []
        }
        Self.missImageable(imageView: imageView)
        WisdomTrackingImages?.append(WisdomWeakable(able: imageView))
    }
    
    static func missImageable(imageView: UIImageView) {
        WisdomTrackingImages = WisdomTrackingImages?.compactMap({ weakable in
            if let able = weakable.able, able != imageView {
                return weakable
            }
            return nil
        })
    }
}
