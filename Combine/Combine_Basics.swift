import Foundation
import Combine

/*
 Combine is a declarative Swift API for processing values over time.
 Key concepts:
 - Publisher: Emits values
 - Subscriber: Receives values
 - Operator: Transforms values
*/

print("--- Combine Basics ---")

// 1. A simple Just publisher
let justPublisher = Just("Hello Combine!")
let subscription1 = justPublisher.sink { value in
    print("Received value: \(value)")
}

// 2. PassthroughSubject (Manual trigger)
let subject = PassthroughSubject<String, Never>()

let subscription2 = subject
    .map { $0.uppercased() } // Operator
    .sink { value in
        print("Subject received: \(value)")
    }

subject.send("apple")
subject.send("banana")

// 3. Timer Publisher
var cancellables = Set<AnyCancellable>()

let timerPublisher = Timer.publish(every: 0.5, on: .main, in: .common)
    .autoconnect()
    .prefix(3) // Only take 3 values
    .sink { time in
        print("Timer tick: \(time)")
    }

timerPublisher.store(in: &cancellables)

// 4. Combining multiple publishers
let pub1 = PassthroughSubject<Int, Never>()
let pub2 = PassthroughSubject<Int, Never>()

pub1.combineLatest(pub2)
    .sink { v1, v2 in
        print("Combined: \(v1) + \(v2) = \(v1 + v2)")
    }
    .store(in: &cancellables)

pub1.send(1)
pub2.send(10)
pub1.send(5)

// Keep the script alive for async publishers
RunLoop.main.run(until: Date(timeIntervalSinceNow: 2))
