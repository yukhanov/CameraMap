//
//  AppDelegate.swift
//  CameraMap
//
//  Created by Юханов Сергей Сергеевич on 12/03/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let city1: CameraCity = CameraCity(name: "Petergof", lat: 59.88, lon: 29.91, cameraURL: "https://media-01.obit.ru/peterhof/index.m3u8")
        let city2: CameraCity = CameraCity(name: "Changgu", lat: -8.65, lon: 115.12, cameraURL: "http://158.69.241.131:1935/cam2/cam2.stream/chunklist_w1237951149.m3u8")
        let city3: CameraCity = CameraCity(name: "London", lat: 25.19, lon: 55.27, cameraURL: "https://hddn01.skylinewebcams.com/live.m3u8?a=ae7k8uabnmnuch0vapuugnqes5")
        let city4: CameraCity = CameraCity(name: "San-Diego", lat: 32.77, lon: -117.25, cameraURL: "https://edge04.hdontap.com/ingest03-hd1/catamaran-ptz_evanshotels.stream/playlist.m3u8")
        
        WeatherService.cameraCityList.append(city1)
        WeatherService.cameraCityList.append(city2)
        WeatherService.cameraCityList.append(city3)
        WeatherService.cameraCityList.append(city4)
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//
//        let nav = UINavigationController()
//        let rootVC = CameraMapViewController(nibName: nil, bundle: nil)
//        nav.viewControllers = [rootVC]
//
//        window?.rootViewController = nav
//        window?.makeKeyAndVisible()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav1 = UINavigationController()
        let mainView = CameraMapViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller
        nav1.viewControllers = [mainView]
        self.window!.rootViewController = nav1
        self.window?.makeKeyAndVisible()

        //FirebaseApp.configure()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

