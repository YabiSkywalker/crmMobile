//
//  SlideToUnlockSlider.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 11/10/24.
//

import SwiftUI

struct SlideToUnlockSlider: View {
    var onSlideComplete: () -> Void
    
    @State private var offsetX: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 40)
                
                Text("Slide to activate")
                    .foregroundColor(.white)
                    .opacity(offsetX < totalWidth - 60 ? 1 : 0)
                    .padding(.leading, 10)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(width: 60, height: 40)
                    .offset(x: offsetX)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let newOffset = max(0, min(gesture.translation.width, totalWidth - 60))
                                offsetX = newOffset
                            }
                            .onEnded { _ in
                                if offsetX >= totalWidth - 60 {
                                    onSlideComplete()
                                }
                                withAnimation {
                                    offsetX = 0 // Reset the slider
                                }
                            }
                    )
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
     //   .frame(height: 40) // Set height, but let width be flexible
        .padding()
    }
}


struct SlideToUnlockSlider_Previews: PreviewProvider {
    static var previews: some View {
        SlideToUnlockSlider {
            print("Slide completed!")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
