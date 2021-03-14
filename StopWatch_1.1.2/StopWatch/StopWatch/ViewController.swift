//
//  ViewController.swift
//  StopWatch
//
//  Created by 정수현 on 2020/11/29.
//

import UIKit
import Lottie


@available(iOS 13.0, *)
class ViewController: UIViewController {
    
    //******************************************
    // MARK: - Variables
    //******************************************
    
    var stopWatch: Stopwatch = Stopwatch()
    var timerCounting: Bool = false
    var buttonClicked: Int = 0
    
    let animationView = AnimationView()
    let darkModeButton = UIButton()
    var darkModeState: Bool = false
    
    /// StackView
    let verticalStackView = UIStackView()
    let lapNumberStackView = UIStackView()
    let horizontalStackView = UIStackView()
    
    /// textlabel
    private let timeTextLabel: UILabel = {
        let timeLable = UILabel()
        timeLable.text = "00:00:0"
        timeLable.textColor = .label
        timeLable.font = UIFont.boldSystemFont(ofSize: 65)
        return timeLable
    }()

    /// button
    private let startButton = UIButton()
    private let lapButton = UIButton()
    private let resetButton = UIButton()
    
    /// lapLabel
    private let lapLabel1 = UILabel()
    private let lapLabel2 = UILabel()
    private let lapLabel3 = UILabel()
    private let lapLabel4 = UILabel()
    private let lapLabel5 = UILabel()

    /// horizonLIne
    private let horizonLine1 = UIView()
    private let horizonLine2 = UIView()
    private let horizonLine3 = UIView()
    private let horizonLine4 = UIView()
    private let horizonLine5 = UIView()
    
    
    //********************************************
    // MARK: - LifeCycle
    //********************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 다크모드 해제
        self.overrideUserInterfaceStyle = .light
     
        /// Lottie Animation + GestureRecognizer
        setupDarkModeToagle()
        setUPGestureRecognizer()
        /// button Action
        connectButtonAction()
        /// SetUp Design & Layout
        setUPDesign()
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if darkModeState {
            return .lightContent
        } else {
            return .darkContent
        }
    }
    
    //********************************************
    // MARK: - Lottie Animation + GestureRecognizer
    //********************************************
    
    /// setup darkMode Lottie
    func setupDarkModeToagle() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.animation = Animation.named("darkModeChanger")
        animationView.contentMode = .scaleAspectFit
        
    }
    
    /// connect lottie --- gestureRecognizer
    private func setUPGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeDarkMode(_:)))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        animationView.addGestureRecognizer(gestureRecognizer)
    }
  
    /// changeDarkMode - Lottie Animation
    @objc func changeDarkMode(_ gesture: UITapGestureRecognizer){
        if !darkModeState {
            animationView.animation = Animation.named("darkModeChanger")
            animationView.contentMode = .scaleAspectFit
            animationView.play()
            darkModeState = true
            animationView.animationSpeed = 1.5
            UIView.animate(withDuration: 1.5) {
                self.view.backgroundColor = .black
                self.timeTextLabel.textColor = .white
                self.setNeedsStatusBarAppearanceUpdate() // statusbar 상태 변화 업데이트
                [self.lapLabel1, self.lapLabel2, self.lapLabel3, self.lapLabel4, self.lapLabel5].forEach{ $0.textColor = .red }
            }
        } else {
            animationView.animation = Animation.named("lightModeChanger")
            animationView.contentMode = .scaleAspectFit
            animationView.play()
            darkModeState = false
            animationView.animationSpeed = 1.5
            UIView.animate(withDuration: 1.5) {
                self.view.backgroundColor = .white
                self.timeTextLabel.textColor = .black
                self.setNeedsStatusBarAppearanceUpdate() // statusbar 상태 변화 업데이트
                [self.lapLabel1, self.lapLabel2, self.lapLabel3, self.lapLabel4, self.lapLabel5].forEach{ $0.textColor = .red }
            }
        }
    }
    
  
    //********************************************
    // MARK: - Button Action
    //********************************************
    
    private func connectButtonAction() {
        startButton.addTarget(self, action: #selector(didTapStartButtons), for: .touchUpInside)
        lapButton.addTarget(self, action: #selector(didTapLapButton), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(didTapRestButton), for: .touchUpInside)
    }
    
    // tap StartBubtton
    
    @objc private func didTapStartButtons(_sender: Any) {
        if timerCounting { // start 화면
            timerCounting = false
            stopWatch.timer.invalidate()
            startButton.applyStartButtonDesign()
        } else { // Pause 화면
            timerCounting = true
            stopWatch.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                                   selector: #selector(timeCounter),
                                                   userInfo: nil, repeats: true)
            startButton.applyPauseButtonDesign()
        }
    }
    
    // tap lapButton
    
    @objc private func didTapLapButton(sender: UIButton) {
        if (sender.isSelected) || (timerCounting == false)  {
            buttonClicked += 0
        } else {
            buttonClicked += 1
            if buttonClicked % 5 == 0 {
                buttonClicked = 5
            } else {
                buttonClicked = buttonClicked % 5
            }
        
            switch buttonClicked {
            case 1:
                lapLabel1.text = timeCounter()
                lapLabel1.textColor = .red
            case 2:
                lapLabel2.text = timeCounter()
                lapLabel2.textColor = .red
            case 3:
                lapLabel3.text = timeCounter()
                lapLabel3.textColor = .red
            case 4:
                lapLabel4.text = timeCounter()
                lapLabel4.textColor = .red
            case 5:
                lapLabel5.text = timeCounter()
                lapLabel5.textColor = .red
            default:
                print("Button not Clicked")
            }
            
        } 
    }
    
    // tap ResetButton
    
    @objc private func didTapRestButton(_sender: Any) {
        // 설정 초기화
        timerCounting = false
        stopWatch.timer.invalidate()
        stopWatch.count = 0
        buttonClicked = 0
        
        // Setup 초기화
        self.timeTextLabel.text = "00:00:0"
        [lapLabel1, lapLabel2, lapLabel3, lapLabel4, lapLabel5].forEach { $0.textColor = .red }
        [lapLabel1, lapLabel2, lapLabel3, lapLabel4, lapLabel5].forEach { $0.text = "00:00:0" }
        
    }
    
    @objc private func timeCounter() -> String {
        stopWatch.count += 1 // count 1씩 증가
        
        let miliSecond = Int((stopWatch.count) % 10 )       // count milisecond로 전환
        let second = Int((stopWatch.count/10) % 60)         // count second로 전환
        let minute = Int((stopWatch.count/600) % 60)        // count min으로 전환

    
        let timeLable = String(format: "%02d:%02d:%1d", minute, second, miliSecond)
        self.timeTextLabel.text = timeLable
        return timeLable
    }
    
    
    //********************************************
    // MARK: - SetUp Design & Layout
    //********************************************
    
    private func setUPDesign() {
        startButton.applyStartButtonDesign()
        lapButton.applyLapButtonDesign()
        resetButton.applyResetButtonDesign()
        
        [lapLabel1, lapLabel2, lapLabel3, lapLabel4, lapLabel5].forEach { $0.text = "00:00:0"}
        [lapLabel1, lapLabel2, lapLabel3, lapLabel4, lapLabel5].forEach { $0.textColor = .red }
        [lapLabel1, lapLabel2, lapLabel3, lapLabel4, lapLabel5].forEach { $0.font = .boldSystemFont(ofSize: 25)}
        [horizonLine1, horizonLine2, horizonLine3, horizonLine4, horizonLine5].forEach { $0.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) }
    }
    
    private func setupViews() {
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        verticalStackView.spacing = 10
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        
        [verticalStackView, timeTextLabel, horizontalStackView, lapNumberStackView, startButton, lapButton, resetButton,
         lapLabel1, lapLabel2, lapLabel3, lapLabel4, lapLabel5,
         horizonLine1, horizonLine2, horizonLine3, horizonLine4, horizonLine5 ].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
    }
 
    private func setupHierarchy() {
        view.addSubview(animationView)
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(timeTextLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(startButton)
        horizontalStackView.addArrangedSubview(lapButton)
        verticalStackView.addArrangedSubview(lapLabel1)
        verticalStackView.addArrangedSubview(horizonLine1)
        verticalStackView.addArrangedSubview(lapLabel2)
        verticalStackView.addArrangedSubview(horizonLine2)
        verticalStackView.addArrangedSubview(lapLabel3)
        verticalStackView.addArrangedSubview(horizonLine3)
        verticalStackView.addArrangedSubview(lapLabel4)
        verticalStackView.addArrangedSubview(horizonLine4)
        verticalStackView.addArrangedSubview(lapLabel5)
        verticalStackView.addArrangedSubview(horizonLine5)
        verticalStackView.addArrangedSubview(resetButton)
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            animationView.heightAnchor.constraint(equalToConstant: 60),
            animationView.widthAnchor.constraint(equalToConstant: 100),
            animationView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            verticalStackView.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 1),
            verticalStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            verticalStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width-30)/2),
            lapButton.heightAnchor.constraint(equalToConstant: 50),
            lapButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width-30)/2),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.widthAnchor.constraint(equalToConstant: view.frame.size.width-20),
            
            lapLabel1.heightAnchor.constraint(equalToConstant: 45),
            lapLabel2.heightAnchor.constraint(equalToConstant: 45),
            lapLabel3.heightAnchor.constraint(equalToConstant: 45),
            lapLabel4.heightAnchor.constraint(equalToConstant: 45),
            lapLabel5.heightAnchor.constraint(equalToConstant: 45),
            
            horizonLine1.heightAnchor.constraint(equalToConstant: 1),
            horizonLine2.heightAnchor.constraint(equalToConstant: 1),
            horizonLine3.heightAnchor.constraint(equalToConstant: 1),
            horizonLine4.heightAnchor.constraint(equalToConstant: 1),
            horizonLine5.heightAnchor.constraint(equalToConstant: 1),
            horizonLine1.widthAnchor.constraint(equalToConstant: view.frame.size.width/2),
            horizonLine2.widthAnchor.constraint(equalToConstant: view.frame.size.width/2),
            horizonLine3.widthAnchor.constraint(equalToConstant: view.frame.size.width/2),
            horizonLine4.widthAnchor.constraint(equalToConstant: view.frame.size.width/2),
            horizonLine5.widthAnchor.constraint(equalToConstant: view.frame.size.width/2),
        ])
    }

}




