import SwiftUI

struct CategoryButtonsView: View {
    // Color constant for easy customization
    private let buttonColor = Color.orange
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                CategoryButton(title: "Thrift", color: buttonColor) {
                    // Destination action - currently blank
                }
                
                CategoryButton(title: "Buy/Sell", color: buttonColor) {
                    // Destination action - currently blank
                }
                
                CategoryButton(title: "Vintage", color: buttonColor) {
                    // Destination action - currently blank
                }
                
                CategoryButton(title: "Consignment", color: buttonColor) {
                    // Destination action - currently blank
                }
                
                CategoryButton(title: "Designer Resale", color: buttonColor) {
                    // Destination action - currently blank
                }
                
                CategoryButton(title: "...More", color: buttonColor) {
                    // Destination action - currently blank
                }
            }
            .padding(.horizontal, 5)
        }
        .scrollClipDisabled()
    }
}

struct CategoryButton: View { 
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(color)
                .cornerRadius(25)
        }
    }
}

// MARK: - Preview
struct CategoryButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButtonsView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
