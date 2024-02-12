valid_words <- read.csv("/Users/max/Desktop/valid-wordle-words.txt", sep = "")
valid_words <- as.character(valid_words$aahed)

# Calculate letter frequencies
letter_frequencies <- table(unlist(strsplit(valid_words, "")))
letter_frequencies <- letter_frequencies / sum(letter_frequencies)

# Score each word based on letter frequencies
word_scores <- sapply(valid_words, function(word) {
  unique_letters <- unique(strsplit(word, "")[[1]])
  sum(letter_frequencies[unique_letters])
})

# Normalize scores to create an initial probability distribution
probabilities <- word_scores / sum(word_scores)



# Assuming `valid_words` is a list of all possible 5-letter words

simulate_guess <- function(true_word, valid_words, guess) {
  feedback <- generate_feedback(guess, true_word)
  feedback
}

find_best_guess <- function(probabilities, valid_words) {
  sorted_indices <- order(probabilities, decreasing = TRUE)
  top_ten_words <- valid_words[sorted_indices[1:10]]
  top_ten_probs <- probabilities[sorted_indices[1:10]]
  list(words = top_ten_words, probabilities = top_ten_probs)
}
generate_feedback <- function(guess, true_word) {
  feedback <- integer(length = nchar(guess)) # Initialize feedback vector
  guess_chars <- strsplit(guess, "")[[1]]
  true_word_chars <- strsplit(true_word, "")[[1]]
  
  # Create a copy of true_word_chars to mark matched letters
  matched_true_word_chars <- true_word_chars
  
  # First pass: Check for correct letters in the correct position
  for (i in seq_along(guess_chars)) {
    if (guess_chars[i] == true_word_chars[i]) {
      feedback[i] <- 2 # Correct position
      matched_true_word_chars[i] <- "*" # Mark as matched
    }
  }
  
  # Second pass: Check for correct letters in the wrong position
  for (i in seq_along(guess_chars)) {
    if (feedback[i] == 0 && guess_chars[i] %in% matched_true_word_chars) {
      feedback[i] <- 1 # Correct letter, wrong position
      # Find and mark the first instance of the letter as matched
      first_match_index <- match(guess_chars[i], matched_true_word_chars)
      matched_true_word_chars[first_match_index] <- "*"
    }
  }
  
  return(feedback)
}


bayesian_update <- function(guess, feedback, valid_words, probabilities) {
  updated_probabilities <- numeric(length(probabilities)) # Correct initialization
  
  for (i in seq_along(valid_words)) {
    word <- valid_words[i]
    word_feedback <- generate_feedback(guess, word)
    
    similarity_score <- sum(feedback == word_feedback)
    updated_probabilities[i] <- probabilities[i] * (1 + similarity_score / length(guess))
  }
  
  updated_probabilities <- updated_probabilities / sum(updated_probabilities)
  
  return(updated_probabilities)
}

true_word <- valid_words[sample(1:length(valid_words),1)]
# Initialize probabilities
probabilities <- rep(1 / length(valid_words), length(valid_words))

# Select the first guess (for simplicity, choose randomly or by highest entropy)
initial_guess <- sample(valid_words, 1)

# Simulate a guess
feedback <- simulate_guess(true_word, valid_words, initial_guess)

# Update probabilities based on feedback
probabilities <- bayesian_update(initial_guess, feedback, valid_words, probabilities)


# Initialize the first guess
current_guess <- sample(valid_words, 1)

# Flag to check if the correct word is found
found_correct_word <- FALSE

# Counter for the number of guesses
guess_count <- 0

# Loop until the correct word is guessed or another break condition is met
while(!found_correct_word) {
  guess_count <- guess_count + 1
  
  # Simulate getting feedback for the current guess
  feedback <- simulate_guess(true_word, valid_words, current_guess)
  
  # Check if the guess is correct (all feedback codes are 2)
  if(all(feedback == 2)) {
    found_correct_word <- TRUE
    cat("Correct word found:", current_guess, "\n")
    break
  }
  
  # Update probabilities based on feedback
  probabilities <- bayesian_update(current_guess, feedback, valid_words, probabilities)
  
  # Find the best next guess based on updated probabilities
  best_guesses <- find_best_guess(probabilities, valid_words)
  
  # Print top three guesses with their probabilities
  cat("Top 10 guesses after", guess_count, "guess(es):\n")
  print(best_guesses$words)
  print(best_guesses$probabilities)
  
  # Wait for user input to continue (conceptual, may not work in all environments)
  cat("Press enter to make the next guess...\n")
  readline(prompt="Next? ")
  
  # Set the next guess (for simplicity, taking the top guess)
  current_guess <- best_guesses$words[1]
}






