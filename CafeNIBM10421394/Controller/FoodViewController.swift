import UIKit
import Firebase


class FoodViewController: UIViewController {

    @IBOutlet weak var tblFood: UITableView!
    
    var ref: DatabaseReference!

    
    
    //assign valus to table view
    var foodItems: [FoodItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFood.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCell")
        ref = Database.database().reference()
        getFoodItemInfo()
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ViewFoodItem"
//        
//    }
}

extension FoodViewController  :  UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    //show view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblFood.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodTableViewCell
        cell.setupView(foodItem: foodItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ViewFoodItem", sender: nil)
    }
    
    
}

extension FoodViewController {
    func getFoodItemInfo() {
        ref.child("foodItems").observe(.value, with: {
            (snapshot) in
            if let info = snapshot.value {
                if let foodItems = info as? [String: Any] {
                    for item in foodItems {
                        if let foodInfo = item.value as? [String: Any]{
                            let singleFoodItem = FoodItem(_id: "",
                                                          img: foodInfo["image"] as! String,
                                                          foodName: foodInfo["name"] as! String,
                                                          foodDescription: foodInfo["description"] as! String,
                                                          foodPrice: foodInfo["price"] as! Double,
                                                          discount: foodInfo["discount"] as! Int,
                                                          category: foodInfo["category"] as! String)
                            self.foodItems.append(singleFoodItem)
                        }
                    }
                    self.tblFood.reloadData()
                }
            }
        })
    }
}
