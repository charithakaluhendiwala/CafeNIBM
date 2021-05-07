

import UIKit
//import Kingfisher

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodDiscription: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView(foodItem: FoodItem){
        lblFoodName.text = foodItem.foodName
        lblFoodDiscription.text = foodItem.foodDescription
        lblFoodPrice.text = "Rs \(foodItem.foodPrice)"
        imgFood.kf.setImage(with: URL(string: foodItem.img))
        
        if foodItem.discount > 0 {
            lblDiscount.isHidden = false
            lblDiscount.text = "\(foodItem.discount)%"
        }else{
            lblDiscount.isHidden = true
            lblDiscount.text = ""
        }
    }
    
//    @IBDesignable public class PaddingLabel: UILabel{
//        @IBInspectable var topInset: CGFloat = 0
//        @IBInspectable var bottomInset: CGFloat = 0
//        @IBInspectable var leftInset: CGFloat = 0
//        @IBInspectable var rightInset: CGFloat = 0
//
//        public override func drawText(in rect: CGRect) {
//            let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//
//            super.drawText(in: rect.inset(by: insets))
//        }
//        public override var intrinsicContentSize: CGSize{
//            let size = super.intrinsicContentSize
//            return ∫CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
//        }
//    }
}
