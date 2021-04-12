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
