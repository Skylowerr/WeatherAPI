//
//  WeatherViewModel.swift
//  WeatherAppAPI
//
//  Created by Emirhan Gökçe on 14.10.2025.
//

import SwiftUI

@Observable
class WeatherViewModel: ObservableObject {
    var city : String = ""
    var weather : WeatherResponse?
    var isLoading : Bool = false
    var errorMessage : String?
    
    private let apikey = AppConfig.apiKey
    
    
    //MARK: Sadece JSON verisini Swift modeline çeviriyor
    private func fetchWeatherData(for city: String) async throws -> WeatherResponse {
        //BUILD URL
        //MARK: APPLE'IN güvenlik nedenlerinden dolayı http yerine https koymamız gerekiyor
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apikey)&q=\(city)&aqi=no" //TODO: BURADA HATA ÇIKABİLİR
        //http://api.weatherapi.com/v1/current.json?key=APIKEY&q=CITY&aqi=no PARÇALAYARAK YUKARI YAPIŞTIRIYORUZ

        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }

        let (data,response) = try await URLSession.shared.data(from: url)
        print(String(data: data, encoding: .utf8)!) //Kontrol amaçlı. data ikili (binary) formda geldiği için, onu UTF-8 ile stringe çevirip ekrana yazdırıyoruz.

        //VALIDATE RESPONSE
        guard let httpResponse = response as? HTTPURLResponse else{ // as? ne demek
            throw WeatherError.unknown
        }
        
        guard httpResponse.statusCode == 200 else {
            throw WeatherError.requestFailed(statusCode: httpResponse.statusCode)
        }
        
        //Neden do catch yapısını kullanıyoruz
        do{
            //JSONDecoder() → Apple’ın JSON verisini Swift modeline çeviren sınıfı. Bu satır asıl JSON verisini Swift modeline çevirir.
            //O zaman JSONDecoder() bu veriyi otomatik olarak WeatherResponse tipine dönüştürür
            //Artık result.location.name veya result.current.temp_c gibi verilere ulaşabiliriz.
            ////“JSONDecoder kullan, data içindeki JSON’u al ve onu WeatherResponse tipinde bir Swift objesine dönüştür.”
            return try JSONDecoder().decode(WeatherResponse.self, from: data)
            
        } catch{
            throw WeatherError.decodingFailed
        }
    }
    
    //MARK: Hava durumu verisini internetten indiriyor, UI’yı güncelliyor ve hataları yönetiyor. O yüzden @MainActor koyuyoruz
    //@MainActor, Swift’te “bu fonksiyonun yalnızca ana thread’de (Main Thread) çalıştırılmasını” söyler.
    @MainActor //“Bu fonksiyonun içinde UI ile ilgili değişiklikler yapacağım, o yüzden ana thread’de çalıştır.”
    //mesela weather ve errorMessage güncelleniyor. O yüzden bunu koyman lazım
    func fetch() async{
        do{
            
            weather = try await fetchWeatherData(for: city) //Başarılı olursa weather değişkeni yeni veriyle güncellenir.
            errorMessage = "Successfully fetched weather for \(city.capitalized)."
        } catch{ //Hata dönerse benim tanımladığım hata devreye girecek
            if let weatherError = error as? WeatherError{
                errorMessage = weatherError.localizedDescription
            }else{ //Diğer bilinmeyen hata türleri ise buradan dönecek
                errorMessage = "An unknown error occurred. \(error.localizedDescription)"
            }
            //Reset weather -> doğru bir yer girip sonrasında yanlış girersek, önceki doğru hava durumunu göstermesin diye resetliyoruz
            weather = nil
            

        }
    }
    
}


