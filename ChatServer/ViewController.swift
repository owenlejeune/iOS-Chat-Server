//
//  ViewController.swift
//  ChatServer
//
//  Created by Owen LeJeune on 2018-04-04.
//  Copyright © 2018 Owen LeJeune. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController, UITextFieldDelegate, WebSocketDelegate{
    
    let CONNECT_SEGMENT_INDEX = 0;
    let DISCONNECT_SEGMENT_INDEX = 1;
    let ws = WebSocket(url: URL(string: "ws://localhost:3000")!)
    var keyboardHeight: CGFloat = 0.0;
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messagesArea: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("recevied text")
        messagesArea.text! += "\nReceiving: \(text)"
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("recevied data")
    }
    
    
    @IBAction func connectionStateToggled(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == CONNECT_SEGMENT_INDEX {
            ws.connect();
            messageTextField.isEnabled = true;
            sendButton.isEnabled = true;
        }else{
            ws.disconnect();
            messageTextField.isEnabled = false;
            sendButton.isEnabled = false;
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let messageText = messageTextField.text;
        if let message = messageText {
            ws.write(string: message);
        }
        messageTextField.text = "";
        messageTextField.resignFirstResponder();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ws.delegate = self;
        messageTextField.delegate = self;
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardHeight == 0.0{ keyboardHeight = keyboardSize.height; }
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardHeight
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardHeight
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage(sendButton);
        return true;
    }
    
    deinit {
        ws.disconnect()
        ws.delegate = nil;
    }
    
    
}
