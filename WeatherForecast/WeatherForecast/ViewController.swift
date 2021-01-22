import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    private let apiKey: String = "02337d7f6423f1596383c1797c318936"
    private var latitude: Double = 37.68382
    private var longitude: Double = 126.742401
    private var locationAddress: String = ""
    
    private let locationManager = CLLocationManager()
    private var currentWeather: CurrentWeather?
    private var forecastList: ForecastList?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        settingBackgroundImage()
        
        settingLocationManager()
        searchForLocationInformation()
    }
    
    func settingBackgroundImage() {
        let imageView = UIImageView(image: UIImage(named: "backgroundImage"))
        self.tableView.backgroundView = imageView
    }
    
    func settingLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func searchForLocationInformation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locationManager.location?.coordinate else {
            print("현재 위치 위경도 값을 받아올 수 없습니다.")
            return
        }
        latitude = coordinate.latitude
        longitude = coordinate.longitude
        
        convertToAddress()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치허용을 누르지 않아 정보를 받아올 수 없습니다.")
    }
    
    func convertToAddress() {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let locale = Locale(identifier: "Ko-kr")
        
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                guard let city = address.last?.administrativeArea,
                      let district = address.last?.thoroughfare else {
                    print("시/구 정보 불러오는데 실패하였습니다.")
                    return
                }
                self.locationAddress = "\(city) \(district)"
            }
        })
    }
    
    func formattingCurrentWeatherUrl(lat: Double, lon: Double, api: String) -> String {
        let url: String = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(api)"
        return url
    }
    
    func formattingForecastUrl(lat: Double, lon: Double, api: String) -> String {
        let url: String = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(api)"
        return url
    }
    
    func currentWeatherDataDecoding() {
        guard let currentWeatherUrl = URL(string: formattingCurrentWeatherUrl(lat: latitude, lon: longitude, api: apiKey)) else {
            print("해당 URL 주소가 없습니다.")
            return
        }
        
        guard let jsonData = try! String(contentsOf: currentWeatherUrl).data(using: .utf8) else {
            print("JSON 데이터가 없습니다.")
            return
        }
        
        let result = try! JSONDecoder().decode(CurrentWeather.self, from: jsonData)
    }
    
    func forecastListDataDecoding() {
        guard let forecastListUrl = URL(string: formattingForecastUrl(lat: latitude, lon: longitude, api: apiKey)) else {
            print("해당 URL 주소가 없습니다.")
            return
        }
        
        guard let jsonData = try! String(contentsOf: forecastListUrl).data(using: .utf8) else {
            print("JSON 데이터가 없습니다.")
            return
        }
        
        let result = try! JSONDecoder().decode(ForecastList.self, from: jsonData)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
    
