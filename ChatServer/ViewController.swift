//
//  ViewController.swift
//  ChatServer
//
//  Created by Owen LeJeune on 2018-04-04.
//  Copyright © 2018 Owen LeJeune. All rights reserved.
//

import UIKit
import SwiftWebSocket

class ViewController: UIViewController, UITextFieldDelegate{
    
    let CONNECT_SEGMENT_INDEX = 0;
    let DISCONNECT_SEGMENT_INDEX = 1;
    var socket = WebSocket(url: URL(string: "ws://localhost:3000/")!);
    
    var keyboardHeight: CGFloat = 0.0;

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messagesArea: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func connectionStateToggled(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == CONNECT_SEGMENT_INDEX {
            socket.open();
//            messagesArea.text! += "Connected Successfully"
            messageTextField.isEnabled = true;
            sendButton.isEnabled = true;
        }else{
            socket.close();
            messageTextField.isEnabled = false;
            sendButton.isEnabled = false;
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let messageText = messageTextField.text;
        if let message = messageText {
            //send message
            messagesArea.text! += "\nSent: \(message)"
            socket.send(message);
        }
        messageTextField.text = "";
        messageTextField.resignFirstResponder();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        socket.delegate = self;
        messageTextField.delegate = self;
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        socket.close();
        
        socket.event.open = {
            print("opened")
        }
        socket.event.close = { code, reson, clean in
            print("close")
        }
        socket.event.error = { error in
            print("error \(error)");
        }
        socket.event.message = { message in
            if let text = message as? String {
                self.messagesArea.text! += "\nReceived: \(text)"
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder();
        sendMessage(sendButton);
        return true;
    }
    
    deinit {
        socket.close()
//        socket.delegate = nil;
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

}
