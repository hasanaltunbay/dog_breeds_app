import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
       let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
       let CHANNEL = "platform_channel"
       let batteryChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

       batteryChannel.setMethodCallHandler({
                   [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
                   if (call.method == "getPlatformVersion") {
                       let osVersion = UIDevice.current.systemVersion
                       result("iOS \(osVersion)")
                   } else {
                       result(FlutterMethodNotImplemented)
                   }
               })


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
