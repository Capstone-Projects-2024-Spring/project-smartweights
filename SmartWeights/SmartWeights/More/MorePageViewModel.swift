//
//  MorePageViewModel.swift
//  SmartWeights
//
//  Created by Timothy Bui on 4/3/24.
//

import Foundation
import Photos
import UIKit

class MorePageViewModel: NSObject, ObservableObject {
    var userDBManager = UserDBManager()
    @Published var showingScreenshotSavedAlert = false
    @Published var showingShareSheet = false
    @Published var balance = 0
    @Published var screenshot: UIImage?
    @Published var achievements: [Achievement] = [
        Achievement(title: "Achievement 1", description: "", img: "trophy.circle", reward: 50),
        Achievement(title: "Achievement 2", description: "", img: "trophy.circle", reward: 100),
        Achievement(title: "Achievement 3", description: "", img: "trophy.circle", reward: 200),
        Achievement(title: "Achievement 4", description: "", img: "trophy.circle", reward: 400),
        Achievement(title: "Achievement 5", description: "", img: "trophy.circle", reward: 800),
        Achievement(title: "Achievement 6", description: "", img: "trophy.circle", reward: 1600),
    ]
    
    override init() {
        super.init()
        getBalance()
    }
    
    func getBalance() {
        userDBManager.getCurrency { (currency, error) in
            if let error = error {
                print("Error getting currency: \(error.localizedDescription)")
            } else if let currency = currency {
                DispatchQueue.main.async {
                    self.balance = Int(currency)
                }
            }
        }
    }
    
    func addToBalance(amount: Int) {
        print("Adding \(amount) to \(balance)")
        userDBManager.updateCurrency(newCurrency: Int64(balance + amount)) { error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                print("SUCCESS")
            }
        }
        
        return balance += amount
    }
    
    func claimAchievement(id: UUID) {
        if let index = achievements.firstIndex(where: { $0.id == id }) {
            achievements[index].claim()
            addToBalance(amount: achievements[index].reward)
        }
    }
    
    func takeScreenshot() {
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        let scale = UIScreen.main.scale
        let bounds = window?.bounds ?? .zero

        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
        if let context = UIGraphicsGetCurrentContext() {
            window?.layer.render(in: context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let img = image {
            let cropArea = CGRect(x:0, y: 300, width: 10000, height: 2100)
            if let cgImage = img.cgImage?.cropping(to: cropArea){
                let croppedImage = UIImage(cgImage: cgImage)
                self.screenshot = croppedImage // Store the screenshot
                DispatchQueue.main.async {
                    self.showingShareSheet = true // Directly show share sheet
                }
            }
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer) {
            DispatchQueue.main.async {
                if error == nil {
                    self.showingScreenshotSavedAlert = true
                } else {
                    // Handle any errors here, maybe set another published property to show an error message.
                }
            }
        }
}
