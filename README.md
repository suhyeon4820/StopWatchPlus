# StopWatchPlus

>랩타임 측정이 가능하고 화면에서 다크모드 전환이 가능한 스탑워치



## App 소개

<img src = "Image\AppIcon.png" width = "200" style = "float: left"> 











- 개발 내용  : 스탑워치의 기본 기능 및 다크모드 화면에 구현

- Timer()를 사용해 스탑워치 Play(재생), Pause, Lap 기능 구현
- 다크모드 전환 토글을 애니메이션 효과를 주는 Lottie 라이브러리 사용

- 개발 환경
  - 사용 Library : Lottie 
  - Design Architecture : MVC Pattern

- 개발 기간 : 4일 (제작 2일, 배포준비 2일)



## 주요 기능

>스탑워치의 기본 기능 및 다크모드 화면에 구현

- 스탑워치 기본 기능 
  - Start Button : 타이머가 1초씩 증가하며 사용자는 시간, 분 , 초 단위를 정확하게 측정 가능
  - Pause Button : 타이머의 시간을 일시정지 하는 기능으로 Start Button을 누르면 일시정지된 시간부터 다시 카운트됨
  - Lap Button : 타이머에 지장을 주지 않고 시간을 연속적으로 체크하는 기능
  - Reset Button : 스탑워치를 초기 상태로 전환해주는 기능

|                         Start Button                         |                         Pause Button                         |                          Lap Button                          |                         Reset Button                         |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| <img src="Image/Gif/StartButton.gif" width = "400" style="zoom:50%;" /> | <img src="Image/Gif/PauseButton.gif" width = "400" style="zoom:50%;" /> | <img src="Image/Gif/LapButton.gif" width = "400" style="zoom:50%;" /> | <img src="Image/Gif/ResetButton.gif" width = "400" style="zoom:50%;" /> |

- 다크모드 화면 구현
  - 화면 오른쪽 상단에 있는 토글을 이용해 다크모드 전한을 할 수 있어 편리하고 빠르게 전환할 수 있음
  - 다크모드 전환시 색상이 변하는 토글을 적용해 직관적인 디자인을 구현
    - Light Mode에서 토글은 검은색이지만 Dark Mode로 전환되면 흰색으로 바뀜

|                   Ligth Mode                    |                   Dark Mode                    |                      Dark Mode Convert                      |
| :---------------------------------------------: | :--------------------------------------------: | :---------------------------------------------------------: |
| <img src = "Image\lightMode.png" width = "200"> | <img src = "Image\darkMode.png" width = "200"> | <img src="Image/Gif/transferDarkMode.gif" width = "200"  /> |





