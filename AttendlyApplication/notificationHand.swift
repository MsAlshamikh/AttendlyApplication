//
//  notificationHand.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 01/03/1444 AH.
//

import UIKit

class notificationHand: UIViewController {
    
private let notificationPublisher = Notificationpublisher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func sendNotification(_ sender: Any) {
        print("what happen?")
        notificationPublisher.sendNotification(title: "good job", subtitle: "you do it", body: "yes yes", badge: 1, dleayInterval: nil)
    }
    

}
