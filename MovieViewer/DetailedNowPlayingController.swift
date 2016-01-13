//
//  DetailedNowPlayingController.swift
//  MovieViewer
//
//  Created by Nikhil Thota on 1/13/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class DetailedNowPlayingController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
        
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
