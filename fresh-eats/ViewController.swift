//
//  ViewController.swift
//  fresh-eats
//
//  Created by Kevin Truong on 2022-08-22.
//

import UIKit
// must be imported to use UIHostingController in viewcontroller
import SwiftUI

class ViewController: UIViewController {
    // this func is used to call all other functions within the app
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

//Create a UIHostingController class that hosts your SwiftUI view
class SwiftUIViewHostingController: UIHostingController<RestaurantContent> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: RestaurantContent())
    }
}





