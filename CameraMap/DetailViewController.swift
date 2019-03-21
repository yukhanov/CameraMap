//
//  DetailViewController.swift
//  WorldCameras
//
//  Created by Юханов Сергей Сергеевич on 23/01/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit
import AVFoundation


class DetailViewController: UIViewController {


    var weatherLabel = UILabel()
    var timeLabel = UILabel()
    
    var currentCity: String = ""
    var heightList: [CGFloat] = []
    let instets: CGFloat = 20
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        
        WeatherService.getWeatherData(city: currentCity)
        
        NotificationCenter.default.addObserver(self, selector: #selector(send_object2), name: NSNotification.Name(rawValue: "send"), object: nil)

    }
    
    @objc func send_object2(_ status: Notification) {
     
        DispatchQueue.main.async {
            
           self.weatherLabel.text = String(WeatherService.getWeatherFromName(city: self.currentCity)!.temp)
        }
        
        
    }
    

    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
      
        
        var url: String = ""
        for camera in WeatherService.cameraCityList {
            if camera.name == currentCity {
                url = camera.cameraURL
            }
        }
        let videoURL = URL(string: url)
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        
      
        
        playerLayer.frame = self.view.bounds
        playerLayer.frame.origin.x = 0
        playerLayer.frame.origin.y = 0
        
        self.view.layer.addSublayer(playerLayer)
        player.play()
        player.isMuted = true
        
        
        weatherLabel.frame.size.height = 30
        weatherLabel.frame.size.width = 70
        weatherLabel.frame.origin.y = instets
        weatherLabel.frame.origin.x = view.frame.maxX - instets - 20
        
//        nil in font
//        weaterLabelFrame()
        weatherLabel.textColor = UIColor.green
        view.addSubview(weatherLabel)
        
        timeLabel.frame.size.height = 30
        timeLabel.frame.size.width = 30
        timeLabel.frame.origin.y = instets * 3
        timeLabel.frame.origin.x = view.frame.maxX - instets - 200
        view.addSubview(timeLabel)
        
        
    }
    func weaterLabelFrame() {
        // получаем размер текста, передавая сам текст и шрифт
        let weaterLabelSize = getLabelSize(text: weatherLabel.text!, font: weatherLabel.font)
        // рассчитываем координату по оси Х
        let weaterLabelX = (view.bounds.width - weaterLabelSize.width) / 2
        // получаем точку верхнего левого угла надписи
        let weaterLabelOrigin =  CGPoint(x: weaterLabelX, y: instets)
        // получаем фрейм и устанавливаем его UILabel
        weatherLabel.frame = CGRect(origin: weaterLabelOrigin, size: weaterLabelSize)
    }
    func getLabelSize(text: String, font: UIFont) -> CGSize {
        // определяем максимальную ширину текста - это ширина ячейки минус отступы слева и справа
        let maxWidth = view.bounds.width - instets * 2
        // получаем размеры блока под надпись
        // используем максимальную ширину и максимально возможную высоту
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        // получаем прямоугольник под текст в этом блоке и уточняем шрифт
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        // получаем ширину блока, переводим ее в Double
        let width = Double(rect.size.width)
        // получаем высоту блока, переводим ее в Double
        let height = Double(rect.size.height)
        // получаем размер, при этом округляем значения до большего целого числа
        let size = CGSize(width: ceil(width), height: ceil(height))
        //        let size = CGSize(width: width, height: height)
        return size
    }
    

}

