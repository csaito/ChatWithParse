//
//  ChatViewController.swift
//  ChatWithParse
//
//  Created by Ryan Chee on 10/26/16.
//  Copyright © 2016 Chihiro Saito. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        sendMessage()
    }
    
    func sendMessage() {
        let message = PFObject(className: "Message")
        message["text"] = messageTextField.text!
        message.saveInBackground {
        (success: Bool, error: Error?) -> Void in
            if (success) {
                // The object has been saved.
                NSLog("saved message: " + self.messageTextField.text!)
            } else {
                // There was a problem, check error.description
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
