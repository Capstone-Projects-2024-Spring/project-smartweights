//
//  PlayerView.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/20/24.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    var url: URL
    
    var body: some View {
        PlayerViewControllerRepresentable(url: url)
            .frame(width: 250, height: 200)// Set the desired size of the video player
    }
}

struct PlayerViewControllerRepresentable: UIViewControllerRepresentable {
    var url: URL
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: url)
        let playerViewController = CustomAVPlayerViewController()
        playerViewController.player = player
        playerViewController.delegate = context.coordinator // Set the delegate
        
        // Automatically enter fullscreen when playback begins
        playerViewController.entersFullScreenWhenPlaybackBegins = true
        
        // Automatically exit fullscreen when playback ends
        playerViewController.exitsFullScreenWhenPlaybackEnds = true
        
        // Add custom controls
        playerViewController.showsPlaybackControls = true
        
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Update the view controller if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    // Coordinator to handle AVPlayerViewControllerDelegate methods
    class Coordinator: NSObject, AVPlayerViewControllerDelegate {
        // No need to implement AVPlayerViewControllerDelegate methods in this case
    }
}

// Custom AVPlayerViewController to override shouldAutorotate property
class CustomAVPlayerViewController: AVPlayerViewController {
    override var shouldAutorotate: Bool {
        return true
    }
}



#Preview {
    let url = Bundle.main.url(forResource: "SWTutorialv2", withExtension: "mp4")
    return PlayerView(url: url!)
}
