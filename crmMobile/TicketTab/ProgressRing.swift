import SwiftUI

struct ProgressRing: View {
    let status: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(getRingColor(for: status))
            // Adjust the emoji size with a smaller system font
            Text(getStatusSymbol(for: status))
                .font(.system(size: 12)) // Smaller font size for emoji
                .foregroundColor(getSymbolColor(for: status))
        }
    }
    
    // Function to determine the color of the ring based on status
    private func getRingColor(for status: String) -> Color {
        switch status {
        case "DONE":
            return Color.green
        case "ACTIV":
            return Color.blue
        case "LATE":
            return Color.red
        case "PEND":
            return Color.orange
        case "OPEN":
            return Color.yellow
        case "INIT":
            return Color.gray
        default:
            return Color.gray // Default color
        }
    }
    
    // Function to get the symbol based on status
    private func getStatusSymbol(for status: String) -> String {
        switch status {
        case "DONE":
            return "✅" // Checkmark for done
        case "ACTIV":
            return "🔧" // Wrench for active
        case "LATE":
            return "⏳" // Hourglass for late
        case "PEND":
            return "🕑" // Clock for pending
        case "OPEN":
            return "🆕" // New for open
        case "INIT":
            return "⚙️" // Cog for initiated
        default:
            return "⚙️" // Default symbol
        }
    }
    
    // Function to determine the color of the symbol based on status
    private func getSymbolColor(for status: String) -> Color {
        switch status {
        case "DONE":
            return Color.green
        case "ACTIV", "OPEN":
            return Color.blue
        case "LATE":
            return Color.red
        case "PEND":
            return Color.orange
        case "INIT":
            return Color.gray
        default:
            return Color.gray // Default color
        }
    }
}

#Preview {
    ProgressRing(status: "INIT")
}

