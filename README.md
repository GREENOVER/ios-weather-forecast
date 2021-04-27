# iOS Weather Forecast Application Project
### 날씨정보를 알려주는 기능을 구현한 프로젝트
[Ground Rule](https://github.com/GREENOVER/ios-weather-forecast/blob/main/GroundRule.md)
***
#### What I learned✍️
- UITableView
- JSON
- Decode
- UnitTemperature
- Array
- CLLocationManagerDelegate
- Locale
- API
- latitude & longitude
- XCTest
- UITest

#### What have I done🧑🏻‍💻
- 테이블뷰를 통한 날씨정보 화면을 구현하였다.
- 날씨정보에 대해 JSON 데이터로 받아 디코딩을 통해 가공하여 구현하였다.
- UnitTemperature 내장 메서드를 이용해 온도의 최저/최고/평균을 계산하고 변환해주었다.
- 날씨 아이콘을 모델의 배열 타입으로 받아 보여주었다.
- 현재 위치 정보에 대한 허용을 묻고 다양하게 처리해주는 기능을 구현하였다.
- 로케이션 매니저를 통해 위치에 따른 처리를 해주었다.
- Locale을 통해 해당 지역화를 한국으로 설정해주었다.
- 날씨정보에 대한 데이터를 API를 이용하여 받아오고 구현하였다.
- 위경도에 대해 학습하고 파라미터로 받아 위치에 대한 날씨를 구현하였다.
- 날씨정보 JSON 데이터에 대한 디코딩 테스트를 구현하고 테스팅을 하였다.
- 테스트를 할때에는 메서드명 앞에 test를 붙여 명시해주어야한다.
- 테스트 클래스는 XCTestCase를 상속받는다.
- UI 테스트에 대한 기본 setUpWithError / tearDownWithError 등 메서드를 학습하였다.

#### Trouble Shooting👨‍🔧
- 문제점 (1)
  - 앱 실행 시 위치정보 허용을 묻는 얼럿이 늦게 노출될때가 있어 날씨정보 연동이 되지 않는 문제
- 원인
  - 현재 VC에서 하는일은 화면 렌더링 / 위치정보 가져오기 / 위치정보로 날씨정보 저장소에서 가져오기 / 날씨정보 디코딩 이렇게 크게 4가지인데 스레드가 비동기적으로 동작함으로 위치정보 허용을 묻기전에 화면이 렌더링되고 디코딩하는 기능을 하게됨으로 간혹 발생하게 되었다.
- 해결방안
  - 각 위의 VC의 기능들에 대해 스레드가 동기적으로 처리될 수 있도록 GCD를 이용하여 일의 순서를 주어 처리를 하게되면 발생하지 않는다.
- 문제점 (2)
  - Unit 테스트를 구현하고 진행 시 네트워크가 동작하지 않을때는 테스트를 할 수 없는 문제
- 원인
  - 유닛 테스트 구현 코드에서 아래와 같이 실제 API를 호출한 값으로 디코딩 테스트를 진행하고있어 네트워크가 비정상적이라면 테스트조차 실패하게 된다. 디코딩 실패 시 네트워크 문제인지 디코딩 로직의 문제인지 알 수 없다.
  ```swift
  func testCurrentWeatherDataDecoding() throws {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.68382&lon=126.742401&appid=02337d7f6423f1596383c1797c318936") else {
            print("해당 URL 주소가 없습니다.")
            return
        }
        
        guard let jsonData = try String(contentsOf: url).data(using: .utf8) else {
            print("JSON 데이터가 없습니다.")
            return
        }
        
        let result = try JSONDecoder().decode(CurrentWeather.self, from: jsonData)
        
        print("현재 날씨예보 아이콘: " + "\(result.icon)")
        print("현재 날씨예보 평균온도: " + "\(result.temperature.celsiusAverage)")
        print("현재 날씨예보 최저온도: " + "\(result.temperature.celsiusMinimum)")
        print("현재 날씨예보 최고온도: " + "\(result.temperature.celsiusMaximum)")
  }
  ```
- 해결방안
  - 유닛테스트에서 JSON데이터를 네트워크로 불러오는것이 아닌 MOCK 데이터를 만들어 테스트를 하는것이 더 안전하다.

- 문제점 (3)
  - 테이블 뷰에 배경 이미지를 입혀주고 그 위 셀을 구현하였을때 배경이 묻히는 문제
- 원인
  - 아래와 같이 뷰 구조 디버깅을 살펴보면 테이블 뷰에 배경이미지 위에 셀들의 각 UIView가 담겨있다. 이부분의 배경이 하얗기에 아래 배경이 보이지 않게 되는것이다.
  <img width="610" alt="스크린샷 2021-04-27 오후 2 32 37" src="https://user-images.githubusercontent.com/72292617/116190461-ab281b80-a765-11eb-92a9-6242fe2e1454.png">
- 해결방안
  - 해당 테이블 뷰 셀과 UIView의 투명도를 설정해주어 뒷 배경 이미지가 보이도록 할 수 있다.
  해당 뷰를 감싼 CALayer의 주소값으로 LLDB 디버깅을 통해 확인한다.
  <img width="686" alt="스크린샷 2021-04-27 오후 2 54 12" src="https://user-images.githubusercontent.com/72292617/116192166-6e115880-a768-11eb-8dc3-cf67bfb0f0ac.png">   

  레이어의 투명도를 주기 위해 opacity 설정을 통해 0(투명)을 줄 수 있다. UIView의 투명도를 주기 위해서는 alpha 프로퍼티로 주어야한다. 
  
  

#### Thinking Point🤔
- 고민점 (1)
  - "아래와 같은 데이터를 WeatherIcon이라고 명명하신 이유가 있을까요?"
  ```
  {
    "id": 800,
    "main": "Clear",
    "description": "clear sky",
    "icon": "01n"
  }
  ```
- 원인 및 대책
  - 해당 모델 타입은 정보에서 날씨의 아이콘만 가져와 사용하기 Weather보다 WeatherIcon이 더 적합한 네이밍이라고 보인다. Weather라고 네이밍을 할 경우 현재 아이콘에
해당하는 프로퍼티 변수명을 name으로 지었는데 Weather name이 아이콘이라고 생각하기엔 조금 가독성이 떨어진다.

- 고민점 (2)
  - "연산프로퍼티로 가공되어 외부에 노출된다면 가공되기전 데이터 값은 private이면 좋지 않을까요?"
  ```swift
  let average: Double
  let minimum: Double
  let maximum: Double
  ```
- 원인 및 대책
  - 연산프로퍼티를 통한 값을 사용한다면 기존 데이터는 사용될 일이 없어 안전하게 해당 구조체에서만 접근되도록 하는것이 적합하다.
  ```swift
  private let average: Double
  private let minimum: Double
  private let maximum: Double
    
  var celsiusAverage: Double {
      return UnitTemperature.celsius.converter.value(fromBaseUnitValue: self.average)
  }
  var celsiusMinimum: Double {
      return UnitTemperature.celsius.converter.value(fromBaseUnitValue: self.minimum)
  }
  var celsiusMaximum: Double {
      return UnitTemperature.celsius.converter.value(fromBaseUnitValue: self.maximum)
  }
  ```
- 고민점 (3)
  - "테스트를 진행할때 실패하는 테스트케이스의 작성이 왜 중요할까?"
- 원인 및 대책
  - TDD(Test Driven Develop)을 참고하였을때 테스트케이스를 먼저 작성하는 테스트 코드를 구현하고 이 후 구현을한다. 성공하는 테스트만 작성하게되면 이후 파생되는 다양한 변수에서 문제점을 발견할 수 없게되어 이후 유지보수를 두려워하게된다. 성공과 실패의 케이스를 모두 고려하여 테스트를 작성한 후 코드를 구현하는것이 바람직하다.

- 고민점 (4)
  - "지역별 온도의 표현단위가 다른것을 어떻게 표현해보면 좋을까요?"
- 원인 및 대책
  - 계산식을 통해 변환하거나 애플에서 제공하는 클래스 메서드를 사용하는 변환 방법이 있다. 이에 해당 프로젝트에서는 아래와 같이 메서드를 이용해보았다.
  ```swift
  var celsiusAverage: Double {
      return UnitTemperature.celsius.converter.value(fromBaseUnitValue: self.average)
  }
  var celsiusMinimum: Double {
      return UnitTemperature.celsius.converter.value(fromBaseUnitValue: self.minimum)
  }
  var celsiusMaximum: Double {
      return UnitTemperature.celsius.converter.value(fromBaseUnitValue: self.maximum)
  }
  ```
  UnitTemperature의 기본 온도 표현 단위는 켈빈(절대온도)이다. 이 온도를 가지고 converter 메서드를 활용하여 celcious(섭씨)로 바꿔준다.
  converter 메서드를 뜯어보면 아래와 같이 UnitConverter 클래스의 기능을 복사한다.
  ```swift
  @NSCopying var converter: UnitConverter { get }
  ```
  @NSCopying을 통해 converter 개체가 해당 기능을 복사하여 제공되도록 해준다.





