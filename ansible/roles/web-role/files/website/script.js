let userScore = 0;
let botScore = 0;

function play(userChoice) {
    const choices = ["stone", "paper", "scissor"];
    const botChoice = choices[Math.floor(Math.random() * 3)];

    let result = "";

    if (userChoice === botChoice) {
        result = "🤝 It's a Draw!";
    } 
    else if (
        (userChoice === "stone" && botChoice === "scissor") ||
        (userChoice === "paper" && botChoice === "stone") ||
        (userChoice === "scissor" && botChoice === "paper")
    ) {
        result = "🎉 You Win!";
        userScore++;
    } 
    else {
        result = "😢 Bot Wins!";
        botScore++;
    }

    document.getElementById("round-result").innerText = result;
    document.getElementById("choices").innerText =
        "You: " + userChoice + " | Bot: " + botChoice;

    document.getElementById("user-score").innerText = userScore;
    document.getElementById("bot-score").innerText = botScore;
}