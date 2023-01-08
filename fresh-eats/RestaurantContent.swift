//
//  RestaurantContent.swift
//  fresh-eats
//
//  Created by Kevin Truong on 2022-08-31.
//

import SwiftUI
//import FASwiftUI

extension UIView {
    var globalFrame: CGRect? {
        let rootView = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController?.view
        return self.superview?.convert(self.frame, to: rootView)
    }
}

struct Restaurant: Hashable {
    let storeName, imageName, menu1, menu2, menu3: String
}

struct RestaurantContent: View {
   
    init() {
        UINavigationBar.appearance().barTintColor = .systemBackground
    }
    
    let topRestaurants: [Restaurant] = [
        .init(storeName: "Saigon Treasure", imageName: "saigontreasure", menu1: "$12 - Large Pho", menu2: "$10 - Med Pho", menu3: "$8 - Small Pho"),
        .init(storeName: "Pizza Garden", imageName: "pizzagarden", menu1: "$15 - 15inch", menu2: "$10 - 10inch", menu3: "$8 - 8inch"),
        .init(storeName: "Protein Bowlz", imageName: "proteinbowlz", menu1: "$15 - Steak", menu2: "$10 - Chicken", menu3: "$8 - Tofu"),
        .init(storeName: "Ramen House", imageName: "ramenhouse", menu1: "$15 - Tonkatsu", menu2: "$10 - Shoyu", menu3: "$8 - Miso")
    ]
    
    let pizzaRestaurants: [Restaurant] = [
        .init(storeName: "Pizza Garden", imageName: "pizzagarden", menu1: "$15 - 15inch", menu2: "$10 - 10inch", menu3: "$8 - 8inch"),
        .init(storeName: "Pizza Hut", imageName: "pizzahut", menu1: "$15 - 15inch", menu2: "$10 - 10inch", menu3: "$8 - 8inch"),
        .init(storeName: "UNA", imageName: "una", menu1: "$15 - 15inch", menu2: "$10 - 10inch", menu3: "$8 - 8inch"),
        .init(storeName: "Dominos", imageName: "dominos", menu1: "$15 - 15inch", menu2: "$10 - 10inch", menu3: "$8 - 8inch")
    ]
    
    let healthyRestaurants: [Restaurant] = [
        .init(storeName: "Green Garden", imageName: "greengarden", menu1: "$15 - Salad", menu2: "$10 - Soup", menu3: "$2 - Drink"),
        .init(storeName: "Toaster", imageName: "toaster", menu1: "$15 - Sandwich", menu2: "$10 - Bread", menu3: "$8 - Spread"),
        .init(storeName: "Protein Bowlz", imageName: "proteinbowlz", menu1: "$15 - Steak", menu2: "$10 - Chicken", menu3: "$8 - Tofu"),
        .init(storeName: "Greek Salad", imageName: "greeksalad", menu1: "$15 - Salad1", menu2: "$10 - Salad2", menu3: "$8 - BreadSticks")
    ]
    
    let asianRestaurants: [Restaurant] = [
        .init(storeName: "Saigon Treasure", imageName: "saigontreasure", menu1: "$12 - Large Pho", menu2: "$10 - Med Pho", menu3: "$8 - Small Pho"),
        .init(storeName: "Ginger Chicken", imageName: "gingerchicken", menu1: "$12 - Chicken", menu2: "$10 - Noodle", menu3: "$8 - Crepe"),
        .init(storeName: "Dumpling Hero", imageName: "dumplinghero", menu1: "$15 - 15 piece", menu2: "$10 - 10 piece", menu3: "$8 - 8 piece"),
        .init(storeName: "Ramen House", imageName: "ramenhouse", menu1: "$15 - Tonkatsu", menu2: "$10 - Shoyu", menu3: "$8 - Miso")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                RestaurantsCarousel(categoryName: "Top Restaurants of 2022", restaurants: topRestaurants)
                RestaurantsCarousel(categoryName: "Pizza", restaurants: pizzaRestaurants)
                RestaurantsCarousel(categoryName: "Healthy Choices", restaurants: healthyRestaurants)
                RestaurantsCarousel(categoryName: "Asian", restaurants: asianRestaurants)
            }
            .navigationBarTitle("freshEats", displayMode: .large)
            
        }
    }
}

struct RestaurantsCarousel: View {
    
    let categoryName: String
    let restaurants: [Restaurant]
    
    func getScale(proxy: GeometryProxy) -> CGFloat {
//        guard let rootView = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController?.view else { return 1}
        let midPoint: CGFloat = 125
        
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 125
        
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
        
        return scale
    }
    
    var body: some View {
        HStack {
            Text(categoryName)
                .font(.system(size: 14, weight: .heavy))
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(2)
            Spacer()
        }.padding(.horizontal)
        .padding(.top)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(restaurants, id: \.self) { num in
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        NavigationLink(
                            destination: RestaurantDetailsView(restaurant: num),
                            label: {
                                // creates a vertical stack of objects ex) image, title, stars
                                VStack(spacing: 8) {
                                    Image(num.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 180)
                                        .clipped()
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color(white: 0.4))
                                        )
                                        .shadow(radius: 3)
                                    Text(num.storeName)
                                        .font(.system(size: 16, weight: .semibold))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                    HStack(spacing: 0) {
                                        ForEach(0..<5) { num in
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.orange)
                                                .font(.system(size: 14))
                                        }
                                    }.padding(.top, -4)
//                                    FAText(iconName: "foursquare", size: 20)
                                }
                            })
                        
                            .scaleEffect(.init(width: scale, height: scale))
//                            .animation(.spring(), value: 1)
                            .animation(.easeOut, value: 1)
                            
                            .padding(.vertical)
                    }
                    .frame(width: 125, height: 400)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 32)
                }
                Spacer()
                    .frame(width: 16)
            }
        }
    }
}
// contents inside restaurant view
struct RestaurantDetailsView: View {
    
    let restaurant: Restaurant
    
    var body: some View {
        Image(restaurant.imageName)
            .resizable()
//            .scaledToFill()
            .frame(width: 450, height: 500, alignment: .center)
            .navigationTitle(restaurant.storeName)
            .padding(10)
        Text(restaurant.menu1)
            .font(.system(size: 20, weight: .semibold))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
        Text(restaurant.menu2)
            .font(.system(size: 20, weight: .semibold))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
        Text(restaurant.menu3)
            .font(.system(size: 20, weight: .semibold))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
        Text("Order Now!")
            .font(.system(size: 30, weight: .semibold))
            .multilineTextAlignment(.center)
            .foregroundColor(.red)
    }
}

struct RestaurantContent_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantContent()
    }
}
