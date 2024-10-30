import UIKit
import Flutter
import Speech

@main
@objc class AppDelegate: FlutterAppDelegate {
    let synthesizer = AVSpeechSynthesizer()
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "translate.this.channel", binaryMessenger: controller.binaryMessenger)
        GeneratedPluginRegistrant.register(with: self)
        channel.setMethodCallHandler({(call: FlutterMethodCall, result: FlutterResult) in
            if (call.method == "speak") {
                do{
                    let answer = call.arguments as! String
                    let utterance = AVSpeechUtterance(string: answer)
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                    try AVAudioSession.sharedInstance().setActive(true)
                    self.synthesizer.speak(utterance)
                    
                }catch{
                    print("Fail to enable session")
                }
            }
        })
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
