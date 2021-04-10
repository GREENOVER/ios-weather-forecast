import UIKit

class ForecatListTableViewCell: UITableViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
