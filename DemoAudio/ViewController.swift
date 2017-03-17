//
//  ViewController.swift
//  DemoAudio
//
//  Created by Francisco Ocampo Romero on 17/03/17.
//  Copyright © 2017 devf. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
  
  var player : AVPlayer!
  
  
  @IBAction func play(_ sender : UIButton) {
    //con esto mantenemos la sesión del audio para no perderla en background
    UIApplication.shared.beginReceivingRemoteControlEvents()
    self.becomeFirstResponder()
    try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
    try! AVAudioSession.sharedInstance().setActive(true)
    
    //Aquí va la url y la instancia del avplayer
    let url = URL(string: "you-url")
    let sound = AVPlayerItem(url: url!)

    //checa si el estatus del player para poner pausa o play
    if player == nil || player.rate != 1.0 {
      self.player = try! AVPlayer(playerItem: sound)
      self.player.allowsExternalPlayback = true
      self.player.play()
    } else {
      self.player.pause()
    }
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Aquí habilitas el player del control center cuando la pantalla está bloqueada
    let playerCenter = MPRemoteCommandCenter.shared()
    // habilito solo el control de play
    playerCenter.playCommand.isEnabled = true
    playerCenter.playCommand.addTarget(self, action: #selector(self.play(_:)))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

