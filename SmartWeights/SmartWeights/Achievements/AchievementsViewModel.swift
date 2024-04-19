//
//  MorePageViewModel.swift
//  SmartWeights
//
//  Created by Timothy Bui on 4/3/24.
//

import Foundation
import Photos
import UIKit
import SwiftUI

class AchievementsViewModel: NSObject, ObservableObject {
    @Published var showingScreenshotSavedAlert = false
    @Published var showingShareSheet = false
    @Published var screenshot: UIImage?
    
    var userDBManager = UserDBManager()
    @Published var balance = 0
    @Published var achievements: [Achievement] = [
        Achievement(title: "1st Sign In", description: "Sign in for the first time.", image: Image("C-1stLogin"), reward: 100, currentProgress: 1, progressGoal: 1),
        Achievement(title: "1st Workout", description: "Complete your first workout.", image: Image("C-1stWorkout"), reward: 100, currentProgress: 1, progressGoal: 1),
        Achievement(title: "New Shopper", description: "Purchase your first item.", image: Image("C-1stItemBought"), reward: 100, currentProgress: 1, progressGoal: 1),
        Achievement(title: "Outfit Change", description: "Customize your pet's outfit and background for the first time.", image: Image("C-1stOutfitChange"), reward: 100, currentProgress: 0, progressGoal: 1)
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
            // Define the crop area (you can adjust these values to fit your needs)
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
