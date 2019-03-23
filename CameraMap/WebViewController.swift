//
//  WebViewController.swift
//  CameraMap
//
//  Created by Юханов Сергей Сергеевич on 23/03/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView = WKWebView()
    var currentCity: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideo()

        
    }
    

    override func viewWillLayoutSubviews() {
        
        webView.frame.size = view.frame.size
        webView.frame.origin.x = 0
        webView.frame.origin.y = 0
        
        view.addSubview(webView)
    }

    
    func getVideo() {
        var videoCode: String = ""
        for camera in FirebaseService.cameraData {
            if camera.name == currentCity {
                videoCode = camera.videoCode
            }
        }
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        webView.load(URLRequest(url: url!))
    }

}
