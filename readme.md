# Wordsearch

This program was built to solve a wordsearch that only had lengths for the hints
for words.  That wordsearch is provided as an example in
[puzzle.txt](./puzzle.txt).  Collections of letters that make up a valid word
are stored in an output file called [knownWords.txt](./knownWords.txt).


## How it works...
The puzzle is treated like a matrix, the program reads all of the puzzle
and then rows are examined one at a time, groups of characters are examined
to determine if they contain a word.  Once each row has been processed, the
puzzle is rotated like a matrix so the columns are now rows and are processed
the same way that the rows were.

Diagonals cannot be retrieved through matrix rotations in the same way that
the columns and rows were.  The matrix is sliced diagonally first, and each of
the slices are then considered to be 'lines', which are then examined for words
like the rows and columns were.

## How to run
Make sure ruby is installed (install it if it is not)

$ ruby -v

Clone the [repo](https://github.com/dentudave/wordSearch) from github

$ git clone https://github.com/dentudave/wordSearch.git

Enter the wordSearch directory

$ cd wordSearch

Run the program

$ ruby main.rb
