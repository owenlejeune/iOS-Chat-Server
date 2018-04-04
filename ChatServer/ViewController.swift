//
//  ViewController.swift
//  ChatServer
//
//  Created by Owen LeJeune on 2018-04-04.
//  Copyright © 2018 Owen LeJeune. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController {
    
    let CONNECT_SEGMENT_INDEX = 0;
    let DISCONNECT_SEGMENT_INDEX = 1;

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messagesArea: UITextView!
    
    @IBAction func connectionStateToggled(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == CONNECT_SEGMENT_INDEX {
            //connect to web socket server
            messagesArea.text! += "\nConnecting"
        }else{
            //disconnect from web socket server
            messagesArea.text! += "\nDisconnecting"
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let messageText = messageTextField.text;
        if let message = messageText {
            //send message
            messagesArea.text! += "\nSent: \(message)"
        }
        messageTextField.text = "";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
