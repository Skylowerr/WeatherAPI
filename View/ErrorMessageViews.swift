//
//  ErrorMessageViews.swift
//  WeatherAppAPI
//
//  Created by Emirhan Gökçe on 16.10.2025.
//

import SwiftUI

struct ErrorMessageViews: View {
    private let friendlyMessages : [String] = [
        "Something went wrong. Please try again",
        "We couldn't fetch the weather. Maybe the clouds are blocking the signal?",
        "A minor hiccup occurred. Try again in a bit.",
        "Looks like the connection took a coffee break. Please retry.",
        "The weather service is currently unavailable. Try again later."
    ]
    
    
    //Listemiz boşsa something went wrong yazdıracak ama boş olmadığı için sıkıntı yok.
    var message: String{
        friendlyMessages.randomElement() ?? "Something went wrong"
    }
    
    var body: some View {
        VStack(spacing:16){
            Image(systemName: "cloud.drizzle.fill")
                .font(.largeTitle)
            
            Text("Weather Unavailable")
                .font(.headline)
            
            Text(message)
                .font(.subheadline)
                .bold()
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(colors: [.blue,.teal], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(.rect(cornerRadius:20))
        .shadow(radius: 10)
        .padding()
        .foregroundStyle(.white.opacity(0.9))
    }
}

#Preview {
    ErrorMessageViews()
}
