//
//  LoginViewController.swift
//  VinylizR
//
//  Created by Nathan Turner on 11/16/16.
//  Copyright © 2016 Nathan Turner. All rights reserved.
//

import Foundation
import AVFoundation
import Material

class LoginViewController: ViewController {
    var player: AVPlayer?
    private var nameField: TextField!
    private var emailField: ErrorTextField!
    private var passwordField: TextField!
    
    /// A constant to layout the textFields.
    private let constant: CGFloat = 32
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.grey.lighten5
        loadVideo()
        prepareEmailField()
        preparePasswordField()
    }
    
    /// Programmatic update for the textField as it rotates.
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        emailField.width = view.height - 2 * constant
    }
    
    private func prepareEmailField() {
        emailField = ErrorTextField(frame: CGRect(x: constant, y: constant, width: view.width - (2 * constant), height: constant))
        emailField.placeholder = "Email"
        emailField.textColor = UIColor.white
        emailField.detail = "Error, incorrect email"
        emailField.isClearIconButtonEnabled = true
        emailField.delegate = self
        
        let leftView = UIImageView()
        leftView.image = Icon.email
        
        emailField.leftView = leftView
        emailField.leftViewMode = .always
        emailField.dividerNormalColor = .white
        emailField.dividerActiveColor = .blue
        
        // Set the colors for the emailField, different from the defaults.
        //        emailField.placeholderNormalColor = Color.amber.darken4
        //        emailField.placeholderActiveColor = Color.pink.base
        //        emailField.dividerNormalColor = Color.cyan.base
        //        emailField.dividerActiveColor = Color.green.base
        
        view.addSubview(emailField)
    }
    
    private func preparePasswordField() {
        passwordField = TextField()
        passwordField.textColor = UIColor.white
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 8 characters"
        passwordField.clearButtonMode = .whileEditing
        passwordField.isVisibilityIconButtonEnabled = true
        
        // Setting the visibilityIconButton color.
        passwordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
        view.layout(passwordField).top(3 * constant).horizontally(left: constant, right: constant)
    }
    
    func loadVideo() {
        //this line is important to prevent background music stop
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch { }
        
        let path = Bundle.main.path(forResource: "recordspinning",
                                    ofType:"mp4")
        
        player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.opacity = 0.4
        
        self.view.layer.addSublayer(playerLayer)
        
        self.setVideoToStart()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.setVideoToStart),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem)
    }
    
    func setVideoToStart() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
}

extension UIViewController: TextFieldDelegate {
    /// Executed when the 'return' key is pressed when using the emailField.
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = true
        return true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = false
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    public func textField(textField: UITextField,
                          didChange text: String?) {
        print("did change", text ?? "")
    }
    
    public func textField(textField: UITextField,
                          willClear text: String?) {
        print("will clear", text ?? "")
    }
    
    public func textField(textField: UITextField,
                          didClear text: String?) {
        print("did clear", text ?? "")
    }
}
