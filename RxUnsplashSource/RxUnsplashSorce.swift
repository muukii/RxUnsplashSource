//
//  RxUnsplashSorce.swift
//  RxUnsplashSource
//
//  Created by muukii on 4/18/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import Foundation
import UIKit

import RxSwift

public enum RxUnsplashSource {
    
    public enum Category: String {
        case Buildings = "buildings"
        case Food = "food"
        case Nature = "nature"
        case People = "people"
        case Technology = "technology"
        case Objects = "objects"
    }
    
    public enum Fixed: String {
        case None = ""
        case Daily = "daily"
        case Weekly = "weekly"
    }
    
    public static func random(fixed: Fixed = .None, size: CGSize) -> Observable<UIImage> {
        
        let url = self.baseURL.append("/\(fixed.rawValue)")
        
        return self.getImage(url, size)
    }
    
    public static func random(category category: Category, fixed: Fixed = .None, size: CGSize) -> Observable<UIImage> {
        
        let url = self.baseURL.append("category/\(category.rawValue)").append("/\(fixed.rawValue ?? "")")
        
        return self.getImage(url, size)
    }
    
    public static func random(user username: String, fixed: Fixed = .None, size: CGSize) -> Observable<UIImage> {
        
        let url = self.baseURL.append("/user/\(username)").append("/\(fixed.rawValue)")
        
        return self.getImage(url, size)
    }
    
    public static func random(userslikes username: String, fixed: Fixed = .None, size: CGSize) -> Observable<UIImage> {
        
        let url = self.baseURL.append("/user/\(username)/likes").append("/\(fixed.rawValue)")
        
        return self.getImage(url, size)
    }
    
    public static func randomSearch(keywords: [String], fromCategory: Category?, size: CGSize) -> Observable<UIImage> {
        
        let query = keywords.joinWithSeparator(",")
        let url: NSURL?
        if let category
            = fromCategory {
            url = self.baseURL.append("/category/\(category.rawValue)/?\(query)")
        } else {
            url = self.baseURL.append("https://source.unsplash.com/?\(query)")
        }
        
        return self.getImage(url, size)
    }
    
    public static func randomSearchFromFeatured(keywords: [String], size: CGSize) -> Observable<UIImage> {
        
        let query = keywords.joinWithSeparator(",")
        let url = self.baseURL.append("/featured/?\(query)")
        
        return self.getImage(url, size)
    }
    
    public static func specificPhoto(photoID: String, size: CGSize) -> Observable<UIImage> {
        
        let url = self.baseURL.append("/\(photoID)")
        
        return self.getImage(url, size)
    }
    
    private static func getImage(url: NSURL?, _ size: CGSize) -> Observable<UIImage> {
        return Observable.create { observer in
            
            guard let url = url?.URLByAppendingPathComponent("/\(size.queryString)"),
                let imageData = NSData(contentsOfURL: url),
                let image = UIImage(data: imageData) else {
                    
                observer.onCompleted()
                return NopDisposable.instance
            }
            
            observer.onNext(image)
            observer.onCompleted()
            
            return NopDisposable.instance
            }
            .subscribeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Default))
            .observeOn(MainScheduler.instance)
    }
    
    private static let baseURL: NSURL = NSURL(string: "https://source.unsplash.com")!
}

private extension NSURL {
    private func append(string: String) -> NSURL {
        return self.URLByAppendingPathComponent(string)
    }
}

private extension CGSize {
    private var queryString: String {
        return "\(Int(self.width))x\(Int(self.height))"
    }
}

