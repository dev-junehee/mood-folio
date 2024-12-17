# 🎞️ 무드폴리오 (Mood Polio) - 이미지 스크랩 플랫폼

<br />

<div align="center">
  <img width=180" src="https://github.com/user-attachments/assets/a6b417d5-c83d-45bd-8744-7d3b61e51768" />
  <br /><br />
  <img src="https://img.shields.io/badge/Swift-v5.1-F05138?logo=swift" />
  <img src="https://img.shields.io/badge/Xcode-v15.4-147EFB?logo=Xcode" />
  <img src="https://img.shields.io/badge/iOS-15.0+-000000?logo=apple" />

</div>

<br /><br />

## 프로젝트 소개 (Description)
> **개발 기간** : 2024. 07. 22 ~ 2024. 07. 29 (약 7일)<br />
> **개발 인원** : 1명 (개발)<br />
> **최소 버전** : iOS 15.0+<br />
> **지원 모드** : 세로 모드, 라이트 모드

<br />

<div align="center">
  <img width="19%" src="https://github.com/user-attachments/assets/03e0e4fc-0247-4f95-b593-0f817981e69a" />
  <img width="19%" src="https://github.com/user-attachments/assets/0ec6ee88-9172-4ff6-801c-9c53aa28000a" />
  <img width="19%" src="https://github.com/user-attachments/assets/d4001315-0345-4fd2-b321-f453ee391cc8" />
  <img width="19%" src="https://github.com/user-attachments/assets/db0f25d7-66d3-45ca-9702-38eb058a52d5" />
  <img width="19%" src="https://github.com/user-attachments/assets/2d9c6a34-806a-42ba-9f4c-bf39c9434d41" />
</div>

<br /><br />

## 사용 기술 및 개발 환경 (Tech Stack & Environment)
- **Language & Tool** : Swift 5.1, Xcode 15.4
- **iOS** : UIKit, Network, FileManager
- **Library** : Kingfisher, SnapKit, TextFieldEffects, Toast
- **Architecture** : MVVM
- **Design Pattern** : Input-Output, Observer, Repository, Singleton
- **Network** : Alamofire
- **Reactive** : RxSwift, RxCocoa
- **Local DB** : Realm
- **Management** : Git, GitHub

<br />

## 개발 방식 및 브랜치 전략 (Development & Branch Strategy)
### Issue, Pull Request(PR) 템플릿 활용한 프로젝트 관리
- 개발 시작 전 새로운 Issue 생성 후, Issue와 브랜치를 연결하고 이슈 번호를 브랜치명에 활용하여 일관된 작업 내용 기록
- Issue와 PR 생성 시 레이블을 표기하여 작업 종류와 진행사항을 한 눈에 알 수 있도록 처리
- PR 생성 시 템플릿에 맞게 작업 내용과 스크린샷을 상세히 기록하여 추후에도 프로젝트 진행 현황을 알 수 있도록 문서화

### 간소화된 Git Flow 도입
- **`main`**
  - 실제 서비스 배포용 브랜치
  - 큰 기능 단위 개발 작업이 완료된 후 병합 (Version Realese)
- **`dev`**
  - 개발 및 QA 작업용 브랜치 (Main 브랜치에서 분기)
  - 각 기능 단위 브랜치 작업이 완료된 후 병합
- **`feat`** , **`design`**, **`fix`**, **`refactor`**...
  - 작은 기능 단위 브랜치 (dev 브랜치에서 분기)
  - Issue, PR, Commit 컨벤션과 동일한 Prefix 사용하여 일관된 작업 구분
- 각 브랜치별 작업 내용 확인을 위해 브랜치명 컨벤션 도입
  - prefix/이슈번호-작업설명
  - `design/1-home-ui`

<br />

## 주요 기능 (Main Feature)
### 이미지 검색 & 상세 정보 
> 주제별 이미지 조회, 이미지 정렬
- Unsplash Open API 기반의 이미지 검색 & 상세 정보 조회
- 이미지 검색 결과에 대한 정렬 옵션 제공 (관련순/최신순)

### 이미지 스크랩(저장)
- 사용자가 스크랩한 이미지를 로컬 디바이스에 저장
- 스크랩한 이미지를 모아볼 수 있는 목록 기능 제공

### 사용자 설정
- 프로필 설정 및 수정 (프로필 아바타, 닉네임)
- MBTI 설정
- 닉네임 유효성 검사

<br />

## 주요 기술 구현 내용 (Implementation Details)
### Observer 패턴을 적용한 MVVM 아키텍쳐 설계
- 데이터를 관찰하여 값이 변하는지 여부에 따른 데이터 바인딩 처리
- Observable 제네릭 클래스 구현하여 핸들링할 값과 클로저 선언
- 초기화 시점에 데이터를 받아 값에 할당하고, 값이 변할 때 마다 클로저를 호출하여 외부에서 변경된 값을 반영

### 네트워크 연결 상태를 감지하여 네트워크 상태 변화를 추적
- Singleton 패턴으로 NetworkMonitorManager 클래스 구현하고 NWPathMonitor 인스턴스를 통해 네트워크 모니터링
- 앱의 라이프사이클에 따라 네트워크 모니터링 실행/중단 처리
    - didFinishLaunchingWithOptions 시점에 네트워크 모니터링 시작 메서드 실행
    - 앱이 Background로 진입할 때 모니터링 중단 메서드 실행
    - 앱이 다시 Foreground로 진입할 때 모니터링 시작 메서드 실행
- 모든 화면이 상속 받는 BaseViewController의 ViewDidLoad 시점에서 네트워크 모니터링 결과 핸들링
- 네트워크가 연결되지 않았을 경우 Alert를 띄우고 설정 화면으로 연결하여 네트워크를 연결하도록 유도

### 네트워크 통신 & Toast를 활용한 에러 핸들링
- TargetType 프로토콜을 직접 구현하고, TargetType 프로토콜을 채택한 Router를 만들어 네트워크 요청에 필요한 속성 정의
- Singleton 패턴을 활용한 NetworkManager 클래스 구현
- 제네릭과 Result Type을 활용해 추상화된 네트워크 요청 함수 구현
- Alamofire.request 메서드를 통해 네트워크 호출 및 응답 처리
- Toast 메세지를 활용한 에러 핸들링

### Realm 데이터베이스 & FileManager를 활용한 사진 저장 기능 구현
- 앱에서 사용할 LikePhoto 모델 정의
- @Persisted 프로퍼티 래퍼를 활용해 LikePhoto 테이블에서 사용할 프로터피 정의하고, primaryKey 설정
- Repository 패턴을 활용해 사진 저장, 불러오기, 삭제 메서드 구현하고 각 ViewModel에서 인스턴스 생성하여 메서드 실행
- Singleton 패턴으로 DocumentFileManager 클래스 구현하여 도큐멘트 경로 확인/디렉토리 생성 등의 메서드 구현
- FileManager를 통해 사진 저장 전 앱 이름으로 도큐멘트 생성하여 해당 도큐멘트 내부에 사진 저장하여 기능 확장과 유지보수 고려
- 사진 로드 시 #available을 활용해 iOS 16.0 이상 버전과 이하 버전에 따라 분기 처리

### UICollectionViewDiffableDataSource를 활용한 사진 검색 기능 구현
- UICollectionViewDiffableDataSource를 사용해 컬렉션 뷰를 구현하고 데이터 관리
- 컬렉션 뷰에서 사용할 Section을 열거형으로 정의하고 UICollectionViewDiffableDataSource에 사용할 데이터 타입과 함께 바인딩
- CellRegistration으로 커스텀 셀 등록, 클로저를 통해 셀의 UI 업데이트 처리
- NSDiffableDataSourceSnapshot으로 스냅샷 인스턴스를 생성하고 섹션과 데이터를 바인딩
- dataSource.applySnapshotUsingReloadData 메서드로 스냅샷을 호출하여 컬렉션 뷰 업데이트

<br />

### Reusable 프로토콜 구현
- AnyObject를 상속 받는 Reusable 프로토콜 구현
- UIView extension을 활용해 Reuseable을 채택하여 id값 반환하도록 처리
- UIView를 상속받는 클래스는 클래스명을 id로 반환

<br />

### View 객체를 확장하여 공통적으로 활용 가능한 메서드 구현
- BarButton 설정, Alert/ActionSheet 처리, popViewControlle 등 모든 ViewController에서 사용 가능한 기능에 대한 메서드 구현
- 다양한 뷰 객체 Extension을 활용해 기본적인 UI 초기 세팅 함수 정의하여 활용

<br />

### PropertyWrapper를 사용해 간편한 UserDefaults 관리
- UserDefaults로 관리할 속성을 열거형을 활용해 정의
- PropertyWrapper를 사용하여 UserDefaultsWrapper를 구현, 키와 기본값 관리
- UserDefaults 핸들링을 위한 구조체를 구현하고 각 속성을 타입 프로퍼티로 정의하여 간편한 접근 처리

<br />
                                                                                                        
### Base 코드, 공통 컴포넌트, 리소스 관리
- 여러 View에서 공통적으로 활용하는 Base 코드 정의, 필요한 메서드를 오버라이딩하여 사용
- 반복적으로 사용되는 UI를 재사용과 커스텀이 가능하도록 컴포넌트화하여 활용
- 열거형과 타입 프로퍼티를 통해 앱에서 사용하는 문자열, 폰트, 이미지 등의 리소스 코드를 데이터로 인식하여 관리

<br />

### 성능 최적화 & 메모리 누수 방지   
- final, private 키워드를 사용하여 서브클래싱과 오버라이딩을 방지,  파일 외부에서 접근하지 않는 프로퍼티에 대해 접근 제한 처리
- Static Dispatch로 동작하도록 처리함으로써 컴파일 최적화
- 클로저 내부에서 외부 데이터를 참조할 때 [weak self] 처리하여 강한 순환 참조 문제 해결
