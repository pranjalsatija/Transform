//
//  SentimentAnalysis.swift
//  Transform
//
//  Created by Pranjal Satija on 11/6/17.
//  Copyright © 2017 Pranjal Satija. All rights reserved.
//

import CoreML

public enum Sentiment: String {
    case negative = "Neg"
    case positive = "Pos"
    case neutral
}

public struct SentimentAnalysisResult {
    let negativeProbability: Double
    let positiveProbability: Double
    let overallSentiment: Sentiment
}

private let sentimentPolarityModel = SentimentPolarity()

extension Array where Element: StringProtocol {
    public func analyzeSentiment() throws -> SentimentAnalysisResult {
        let filtered = self.removing([.conjunction])
        var wordCounts = [String : Double]()

        for word in filtered {
            if let count = wordCounts[word] {
                wordCounts[word] = count + 1
            } else {
                wordCounts[word] = 1
            }
        }

        let prediction = try sentimentPolarityModel.prediction(input: wordCounts)
        let negativeProbability = prediction.classProbability[Sentiment.negative.rawValue] ?? 0
        let positiveProbability = prediction.classProbability[Sentiment.positive.rawValue] ?? 0
        let overallSentiment = Sentiment(rawValue: prediction.classLabel) ?? .neutral

        return SentimentAnalysisResult(
            negativeProbability: negativeProbability,
            positiveProbability: positiveProbability,
            overallSentiment: overallSentiment
        )
    }
}

extension String {
    public func analyzeSentiment() throws -> SentimentAnalysisResult {
        return try self.toArray().analyzeSentiment()
    }
}
