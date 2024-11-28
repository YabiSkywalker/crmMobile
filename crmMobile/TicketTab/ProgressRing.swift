import SwiftUI

struct ProgressRing: View {
    let status: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6)
                .foregroundColor(getRingColor(for: status))
            // Adjust the emoji size with a smaller system font
            //Text(getStatusSymbol(for: status))
              //  .font(.system(size: 12)) // Smaller font size for emoji
              //  .foregroundColor(getSymbolColor(for: status))
        }
    }
    
    // Function to determine the color of the ring based on status
    private func getRingColor(for status: String) -> Color {
        switch status {
        case "DONE":
            return Color.green // Represents successful completion
        case "ACTIV":
            return Color.blue // Indicates active work
        case "LATE":
            return Color.red // Highlights overdue status
        case "PEND":
            return Color.orange // Signals pending action
        case "OPEN":
            return Color.yellow // Denotes open but not started
        case "INIT":
            return Color.gray // Default state for initialized tickets
        case "CNCL":
            return Color.purple // Represents canceled tickets
        case "INV":
            return Color.cyan // Indicates invoiced state
        case "PAID":
            return Color.teal // Represents a paid invoice
        default:
            return Color.gray // Fallback color
        }
    }
    
    /* Function to get the symbol based on status
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
    */
    // Function to determine the color of the symbol based on status
    private func getSymbolColor(for status: String) -> Color {
        switch status {
        case "DONE":
            return Color.green // Indicates successful completion
        case "ACTIV", "OPEN":
            return Color.blue // Active or open work
        case "LATE":
            return Color.red // Represents overdue status
        case "PEND":
            return Color.orange // Pending action
        case "INIT":
            return Color.gray // Neutral for initialization
        case "CNCL":
            return Color.purple // Distinct for canceled tickets
        case "INV":
            return Color.cyan // Professional, for invoiced state
        case "PAID":
            return Color.teal // Balanced and completed payment
        default:
            return Color.gray // Default fallback
        }
    }
}

#Preview {
    ProgressRing(status: "ACTIV")
}

