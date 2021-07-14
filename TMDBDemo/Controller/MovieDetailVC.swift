//
//  MovieDetailVC.swift
//  TMDBDemo
//
//  Created by Paresh Thakkar on 13/07/21.
//

import UIKit
import Cosmos
class MovieDetailVC: UIViewController {

    @IBOutlet weak var txtOverview: UITextView!
    @IBOutlet weak var genView5: UIView!
    @IBOutlet weak var genView4: UIView!
    @IBOutlet weak var genView2: UIView!
    @IBOutlet weak var genView3: UIView!
    @IBOutlet weak var genView1: UIView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTop: UILabel!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    var image = UIImage()
    var ratings = Double()
    var ratingText = String()
    var overview = String()
    var genArray : [String] = []
    var movieTitle = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if genArray.count == 1
        {
            self.genView1.isHidden = false
            self.lbl1.text = genArray[0]
            self.genView2.isHidden = true
            self.genView3.isHidden = true
            self.genView4.isHidden = true
            self.genView5.isHidden = true
        }
        else if genArray.count == 2
        {
            self.genView1.isHidden = false
            self.lbl1.text = genArray[0]
            self.genView2.isHidden = false
            self.lbl2.text = genArray[1]
            self.genView3.isHidden = true
            self.genView4.isHidden = true
            self.genView5.isHidden = true
        }
        else if genArray.count == 3
        {
            self.genView1.isHidden = false
            self.lbl1.text = genArray[0]

            self.genView2.isHidden = false
            self.lbl2.text = genArray[1]

            self.genView3.isHidden = false
            self.lbl3.text = genArray[2]

            self.genView4.isHidden = true
            self.genView5.isHidden = true
        }
        else if genArray.count == 4
        {
            self.genView1.isHidden = false
            self.lbl1.text = genArray[0]

            self.genView2.isHidden = false
            self.lbl2.text = genArray[1]

            self.genView3.isHidden = false
            self.lbl3.text = genArray[2]

            self.genView4.isHidden = false
            self.lbl4.text = genArray[3]

            self.genView5.isHidden = true
        }
        else if genArray.count == 5
        {
            self.genView1.isHidden = false
            self.lbl1.text = genArray[0]

            self.genView2.isHidden = false
            self.lbl2.text = genArray[1]

            self.genView3.isHidden = false
            self.lbl3.text = genArray[2]

            self.genView4.isHidden = false
            self.lbl4.text = genArray[3]
            
            self.genView5.isHidden = false
            self.lbl5.text = genArray[4]
        }
        self.ratingView.settings.fillMode = .half
        self.imgPoster.image = image
        self.lblMovieName.text = movieTitle
        self.lblTop.text = movieTitle
        self.ratingView.rating = ratings
        self.ratingView.text = ratingText
        self.txtOverview.text = overview
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
