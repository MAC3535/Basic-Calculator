import UIKit

class ViewController: UIViewController {
    
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    var firstNumber = 0.00
    var thirdNumber = 0.00
    var answer = 0.00
    var selectedOperation: Operation?
    var equalButtonPressed = false
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = label.font.withSize(65)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpNumberPad()
    }
    
    func setUpNumberPad() {
        let squareHeight = view.frame.size.height / 8
        let squareWidth = view.frame.size.width / 8
        
        //set up label
        label.frame = CGRect(x: 0, y: 100 , width: view.frame.size.width, height: squareHeight*2)
    
        view.addSubview(label)
        
        // set up array of opperations
        let opperations = ["=","+","-","x","÷"]
        
        //set up single buttons
        let zeroButton = UIButton(frame: CGRect(x: 0, y: view.frame.size.height - squareHeight, width: squareWidth*4, height: squareHeight))
        zeroButton.setTitle("0", for: .normal)
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        zeroButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        view.addSubview(zeroButton)
        
        let decimalPoint = UIButton(frame: CGRect(x: zeroButton.frame.size.width, y: view.frame.size.height - squareHeight, width: squareWidth*2, height: squareHeight))
        decimalPoint.setTitle(".", for: .normal)
        decimalPoint.setTitleColor(.black, for: .normal)
        decimalPoint.backgroundColor = .white
        decimalPoint.addTarget(self, action: #selector(decimalButtonPressed), for: .touchUpInside)
        
        view.addSubview(decimalPoint)
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: view.frame.size.height - squareHeight*5, width: squareWidth*2, height: squareHeight))
        clearButton.setTitle("C", for: .normal)
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .white
        clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
        
        view.addSubview(clearButton)
        
        let negativeButton = UIButton(frame: CGRect(x: clearButton.frame.size.width, y: view.frame.size.height - squareHeight*5, width: squareWidth*2, height: squareHeight))
        negativeButton.setTitle("+/-", for: .normal)
        negativeButton.setTitleColor(.black, for: .normal)
        negativeButton.backgroundColor = .white
        negativeButton.addTarget(self, action: #selector(negativeButtonPressed), for: .touchUpInside)
        
        view.addSubview(negativeButton)
        
        let percentButton = UIButton(frame: CGRect(x: clearButton.frame.size.width + (squareWidth*2), y: view.frame.size.height - squareHeight*5, width: squareWidth*2, height: squareHeight))
        percentButton.setTitle("%", for: .normal)
        percentButton.setTitleColor(.black, for: .normal)
        percentButton.backgroundColor = .white
        percentButton.addTarget(self, action: #selector(percentButtonPressed), for: .touchUpInside)
        
        view.addSubview(percentButton)
        
        // set up buttons 1-9
        for i in 0..<3 {
            let firstButtonRow = UIButton(frame: CGRect(x: CGFloat(i)*(squareWidth*2), y: view.frame.size.height - squareHeight*2, width: squareWidth*2, height: squareHeight))
            firstButtonRow.setTitle("\(i+1)", for: .normal)
            firstButtonRow.setTitleColor(.black, for: .normal)
            firstButtonRow.backgroundColor = .white
            firstButtonRow.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            view.addSubview(firstButtonRow)
            
        }
        
        for i in 0..<3 {
            let secondButtonRow = UIButton(frame: CGRect(x: CGFloat(i)*(squareWidth*2), y: view.frame.size.height - squareHeight*3, width: squareWidth*2, height: squareHeight))
            secondButtonRow.setTitle("\(i+4)", for: .normal)
            secondButtonRow.setTitleColor(.black, for: .normal)
            secondButtonRow.backgroundColor = .white
            secondButtonRow.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            view.addSubview(secondButtonRow)
        
        }
        
        for i in 0..<3 {
            let thirdButtonRow = UIButton(frame: CGRect(x: CGFloat(i)*(squareWidth*2), y: view.frame.size.height - squareHeight*4, width: squareWidth*2, height: squareHeight))
            thirdButtonRow.setTitle("\(i+7)", for: .normal)
            thirdButtonRow.setTitleColor(.black, for: .normal)
            thirdButtonRow.backgroundColor = .white
            thirdButtonRow.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            view.addSubview(thirdButtonRow)
        }
        
        // set up operation buttons
        for i in 0..<5 {
            let operationButton = UIButton(frame: CGRect(x: view.frame.size.width - squareWidth*2, y: view.frame.size.height - CGFloat(i+1)*(squareHeight), width: squareWidth*2, height: squareHeight))
            operationButton.setTitle("\(opperations[i])", for: .normal)
            operationButton.setTitleColor(.white, for: .normal)
            operationButton.backgroundColor = .systemGreen
            operationButton.tag = i+1
            operationButton.addTarget(self, action: #selector(operationPressed), for: .touchUpInside)
            
            view.addSubview(operationButton)
        }
        
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
     
        guard let title = sender.currentTitle else {print("Trouble with sender"); return}
        
        guard let labelText = label.text else {return}
        
        if equalButtonPressed == false {
            if labelText == "0" {
                label.text = title
            }
            else if labelText.count < 9 {
                label.text?.append(title)
            }
        }
     
    }
    
    @objc func clearButtonPressed(_ sender: UIButton) {
        if label.text != "0" {
            label.text = "0"
        }
        selectedOperation = nil
        firstNumber = 0
        thirdNumber = 0
        answer = 0
        equalButtonPressed = false
    }
    
    @objc func decimalButtonPressed(_ sender: UIButton) {
        if answer == 0.00 {
            if label.text!.contains(".") == false {
                label.text!.append(".")
            }
        }
    }
    
    @objc func negativeButtonPressed(_ sender: UIButton) {
        if label.text!.starts(with: "-") == false {
            label.text = "-\(label.text!)"
        }
        else {
            label.text!.removeFirst()
        }
    }
    
    @objc func percentButtonPressed(_ sender: UIButton) {
        if answer == 0.00 {
            if let number = label.text {
                if let finalNumber = Double(number) {
                    let finalAnswer = finalNumber/100
                    label.text = "\(finalAnswer)"
                }
            }
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = label.text, firstNumber == 0 {
            if let number = Double(text) {
                firstNumber = number
                label.text = "0"
            }
        }
        
        if tag == 1 {
            if let operation = selectedOperation {
                var secondNumber = 0.00
                
                if let text = label.text {
                    if let number = Double(text) {
                        secondNumber = number
                    }
                }
                switch operation {
                case .add:
                    answer = firstNumber + secondNumber
                    label.text = "\(answer)"
                    thirdNumber = answer
                case .subtract:
                    answer = firstNumber - secondNumber
                    label.text = "\(answer)"
                    thirdNumber = answer
                case .multiply:
                    answer = firstNumber * secondNumber
                    label.text = "\(answer)"
                    thirdNumber = answer
                case .divide:
                    answer = firstNumber / secondNumber
                    label.text = "\(answer)"
                    thirdNumber = answer
                }
                equalButtonPressed = true
                print(firstNumber, secondNumber)
            }
        }
        else if tag == 2 {
            selectedOperation = Operation.add
            if equalButtonPressed == true {
                label.text = "0"
                answer = 0.00
                firstNumber = thirdNumber
                equalButtonPressed = false
                
            }
        }
        else if tag == 3 {
            selectedOperation = Operation.subtract
            if equalButtonPressed == true {
                label.text = "0"
                answer = 0.00
                firstNumber = thirdNumber
                equalButtonPressed = false
            }
        }
        else if tag == 4 {
            selectedOperation = Operation.multiply
            if equalButtonPressed == true {
                label.text = "0"
                answer = 0.00
                firstNumber = thirdNumber
                equalButtonPressed = false
            }
        }
        else if tag == 5 {
            selectedOperation = Operation.divide
            if equalButtonPressed == true {
                label.text = "0"
                answer = 0.00
                firstNumber = thirdNumber
                equalButtonPressed = false
            }
        }
    }

}

