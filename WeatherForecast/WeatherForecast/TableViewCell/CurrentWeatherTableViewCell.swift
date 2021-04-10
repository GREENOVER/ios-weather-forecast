import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var currentAddress: UILabel!
    @IBOutlet weak var rangeOfTemperature: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
