//
//  FoodItemViewController.swift
//  CafeNIBM10421394
//
//  Created by char1 on 4/24/21.
//  Copyright © 2021 char1. All rights reserved.
//

import UIKit
import Kingfisher

class FoodItemViewController: UIViewController {
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    
    var foodItem: FoodItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let item  = self.foodItem{
            imgFood.kf.setImage(with: URL(string: item.img))
            lblFoodName.text = item.foodName
            lblDiscription.text = item.foodDescription
            lblFoodPrice.text = "RS.\(item.foodPrice)"
        }
    }


    @IBAction func btnBackPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAddtoCart(_ sender: Any) {
    }
    
}
