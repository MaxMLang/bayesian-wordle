# Wordle Solver Using Bayesian Statistics
<div align="center">
  <a href="[https://www.mun.ca/biology/scarr/FISH_chromosome_painting.html](https://miro.medium.com/v2/resize:fit:839/1*uivjxg-_jmSpFqxwWH80DA.png
)">
    <img src="https://miro.medium.com/v2/resize:fit:839/1*uivjxg-_jmSpFqxwWH80DA.png
" alt="" width="300" height="300">
  </a>
</div>

This repository contains a Wordle solver implemented in R that utilizes Bayesian statistics to efficiently guess the correct word in the popular word puzzle game, Wordle. By leveraging the principles of Bayesian updating, this solver iteratively refines its guesses based on feedback from previous attempts, demonstrating a practical application of statistical methods in everyday puzzles.

## Overview

The solver begins with a prior probability distribution based on letter frequencies within a predefined list of valid 5-letter Wordle words. After each guess, the solver updates the probabilities of each word being the correct answer based on the feedback received from the game (correct letters in the right/wrong position and incorrect letters). This process iteratively continues until the correct word is identified.

## Features

- **Letter Frequency Calculation**: Computes the frequency of each letter across all valid Wordle words to establish a prior probability distribution.
- **Bayesian Updating**: Updates the probability of each word being the correct answer based on the feedback received for each guess.
- **Feedback Simulation**: Simulates the feedback provided by Wordle for each guess in comparison to the true word.
- **Optimal Guess Selection**: Selects the best next guess based on the updated probabilities, aiming to find the correct word with the fewest attempts.

## How to Use

1. **Setup**: Ensure you have R installed on your machine.
2. **Valid Word List**: Place a text file named `valid-wordle-words.txt` in the project directory. This file should contain a list of all valid 5-letter Wordle words, one word per line.
3. **Run the Solver**: Execute the main script. The script will choose an initial guess, update probabilities based on simulated feedback, and continue making guesses until the correct word is found.

## Files in This Repository

- **`wordle_solver.R`**: The main R script containing the implementation of the Bayesian Wordle solver.
- **`valid-wordle-words.txt`**: A sample text file (not included in this repo) that needs to be added by users, containing the list of valid 5-letter words acceptable in Wordle.

## Dependencies

This project requires R to run. No external R packages are needed as the code utilizes base R functions.

## How It Works

The solver's algorithm can be broken down into the following steps:

1. **Calculate Letter Frequencies**: Determine the frequency of each letter in the list of valid words to establish a prior probability distribution.
2. **Simulate Guesses**: For each guess, simulate the feedback that would be received if it were the correct answer.
3. **Bayesian Update**: After receiving feedback, update the probabilities for each word, reflecting how likely each one is the correct answer based on the information gained.
4. **Select the Best Guess**: Choose the word with the highest updated probability as the next guess.
5. **Repeat**: Continue the process until the correct word is identified.

## Contributions

Contributions are welcome! If you have improvements or bug fixes, please feel free to fork this repository and submit a pull request.

## License

This project is open-source and available under the MIT License.

## Disclaimer

This project is for educational purposes and to demonstrate the application of Bayesian statistics. It is not intended to automate gameplay on the actual Wordle game website.
