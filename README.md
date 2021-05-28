# ReactorKit + Moya Demo

- Autolayout programmatically by SnapKit
- Networking by Moya
- Reactive and Unidirectional framework by Reactorkit

## ReactorKit
Framework for Reactive and Unidirectional framework     
Reactorkit: 상태관리 ,  Rx장점, Massive View controller 피하기     
‘단방향’ 데이터 흐름을 가진 ‘반응형’ 앱을 위한 프레임워크    
1. ViewController - Reactor 
2. 모든 Rx 기능을 사용 가능 
3. 중간 상태를 reduce() 함수로 관리, 데이터 흐름이 간결해짐 
4. 테스트 가능 

### 배경  
기존의 Rx + MVVM 상태관리가 아쉬움   
복잡한 상태를 가지는 화면에서는 Ouptut이 이전에 나온 Output들에 의존성을 가지는 경우가 많아짐…     

Cyclic Data Dependcies 문제
다음 작업을 위해 이전 작업의 결과가 필요 = 다음 요청에 이전 요청 결과의 nextURL 필요 = 이전 결과에 의존적    
ex. 아래로 스크롤하여 다음 페이지 로드     
이를 Rx에서 BehaviorSubject 사용, 남발…     

### Reactive
시간의 흐름, 사용자의 동작, 네트워크 요청의 결과까지 전부 스트림화    
파이프라인으로 흘려보냄      

사용자가 요청할 때 특정 스트림을 내보냄: 반응형   
Input, Output이 명확하고 결과는 늘 같음: 함수형     
operator사용해서 파이프라인으로 1.2.3…으로 선언: 선언형       

### Unidirectional    
View 가 Action을 발생시키면 Reactor에서 그 Action에 반응하여 State를 반환하고 View는 이에 따라 렌더링     
상태를 한 곳에서 관리하기      
입력 스트림을 하나로 결합하고 출력 스트림을 하나로 결합해서 모든 상태를 한 곳에서 관리해서 엉켜있는 I/O 탈출     

### 테스트할 요소는 2가지로 압축
1. currentState + Action은 우리가 의도한 newState를 만들어내는가      
2. Action에서 우리가 의도한 SideEffect를 발생시키고 있는가       

### 그럼에도…
하나의 상태 요소 변경에 전체 상태를 다시 렌더링하게 됨     
-> distinctUntilChanged()로 연산자로 해결할 수도 있음     

**View**: 사용자 입력을 받아 Reactor로 전달 + Reactor로부터 받은 상태를 렌더링 ViewController, Cell 등등 
  
```
protocol View {
	associatedtype Reactor

	var disposeBag: DisposeBag 

	// self.reactor가 바뀌면 호출됨
	func bind(reactor: Reactor) /// Action Binding + State Binding 
```

**Reactor**: 비즈니스 로직 담당. View에서 전달받은 Action에 따라 로직 수행, 상태를 관리하고 상태가 변경되면 View에 전달
대부분의 View-Reactor 1:1 대응 관계 
모든 바인딩은 RxSwift 

```
protocol Reactor {
	associatedtype Action /// 추상화된 사용자 입력 
 	associatedtype Mutation /// State를 변경하는 명령/작업단위, View에 노출되지 않음
	associatedtype State  /// 추상화된 뷰 상태 

	var initialState: State

	func mutate() /// (Action) -> Observable<Mutation>
	func reduce() /// (State 이전 상태, Mutation상태 변화시키는 동작) -> State 다음 상태
}
```

(출처: https://www.youtube.com/watch?v=ASwBnMJNUK4 ReactorKit으로 단방향 반응형 앱 만들기 - 전수열,    
https://medium.com/myrealtrip-product/단방향-데이터-플로우-unidirectial-data-flow-udf-ios-앱-아키텍처로-복잡한-상태-관리하기-196a6c4f3b66)

## Moya

URLSession, Alamofire를 한 번 더 감싸서 추상화한 통신 API      

**Provider** : 모든 네트워크 서비스와 상호작용할 때 만들고 사용하는 객체     
**Target** : TargetType 프로토콜 채택  -> TargetType  = baseURL + path + method + sampleData + task + headers (+ validationType)   

