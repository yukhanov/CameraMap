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
    var backButton = UIButton()
    
    var currentCity: String = ""
    let instets: CGFloat = 20
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = currentCity

        WeatherService.getWeatherData(city: currentCity)
        
        NotificationCenter.default.addObserver(self, selector: #selector(send_object2), name: NSNotification.Name(rawValue: "send"), object: nil)

    }
    
    @objc func send_object2(_ status: Notification) {
     
        DispatchQueue.main.async {
            self.weatherLabel.text = ".."
            guard let temp = WeatherService.getWeatherFromName(city: self.currentCity)?.temp else { return }
            self.weatherLabel.text = String(temp)
            self.weatherLabelFrame()
        }
        
        
    }
    

    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
      
        
        var url: String = ""
        for camera in FirebaseService.cameraData {
            if camera.name == currentCity {
                url = camera.url
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
        weatherLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        view.addSubview(weatherLabel)
        
        timeLabel.frame.size.height = 30
        timeLabel.frame.size.width = 30
        timeLabel.frame.origin.y = instets * 3
        timeLabel.frame.origin.x = view.frame.maxX - instets - 200
        view.addSubview(timeLabel)
        
 
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        backButton.frame = CGRect(x: 10, y: 40, width: 60, height: 30)
        backButton.addTarget(self, action: #selector(pressedAction(_:)), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    @objc func pressedAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    func weatherLabelFrame() {
        // получаем размер текста, передавая сам текст и шрифт
        let weatherLabelSize = getLabelSize(text: weatherLabel.text!, font: weatherLabel.font)
        // рассчитываем координату по оси Х
        let weatherLabelX = (view.bounds.width - weatherLabelSize.width) / 2
        // получаем точку верхнего левого угла надписи
        let weatherLabelOrigin =  CGPoint(x: weatherLabelX, y: instets * 2)
        // получаем фрейм и устанавливаем его UILabel
        weatherLabel.frame = CGRect(origin: weatherLabelOrigin, size: weatherLabelSize)
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

