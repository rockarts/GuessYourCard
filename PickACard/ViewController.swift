//
//  ViewController.swift
//  PickACard
//
//  Created by Steven Rockarts on 2019-01-06.
//  Copyright © 2019 Figure4Software. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {

    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var deck:[Card]?
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var transcriptionOutputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deck = createDeck()
        
        SFSpeechRecognizer.requestAuthorization {
            [unowned self] (authStatus) in
            switch authStatus {
            case .authorized:
                self.startRecording()
            case .denied:
                print("Speech recognition authorization denied")
            case .restricted:
                print("Not available on this device")
            case .notDetermined:
                print("Not determined")
            }
        }
    }
    
    func createDeck() -> [Card] {
        let ranks = [Rank.Ace, Rank.Two, Rank.Three, Rank.Four, Rank.Five, Rank.Six, Rank.Seven, Rank.Eight, Rank.Nine, Rank.Ten, Rank.Jack, Rank.Queen, Rank.King]
        let suits = [Suit.Spades, Suit.Hearts, Suit.Diamonds, Suit.Clubs]
        var deck = [Card]()
        for suit in suits {
            for rank in ranks {
                deck.append(Card(rank: rank, suit: suit))
            }
        }
        return deck
    }
    
    func startRecording() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat, block: {
            buffer, _ in
            self.request.append(buffer)
        })
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            return debugPrint(error)
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        if !myRecognizer.isAvailable {
            return
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request) {
            [unowned self]
            (result, _) in
            if let transcription = result?.bestTranscription {
                self.transcriptionOutputLabel.text = transcription.formattedString
                debugPrint(transcription.formattedString)
                for card in self.deck! {
                    debugPrint("Card description \(card.simpleDescription().lowercased())")
                    if(card.simpleDescription().lowercased() == transcription.formattedString.lowercased()){
                        self.cardImage.image = card.getImage()
                    }
                }
            }
        }
    }
}

