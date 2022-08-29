

import UIKit

class favoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var imFavoritIrem: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMall: UILabel!
    @IBOutlet weak var lblStore: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
