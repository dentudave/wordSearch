require 'rubygems'
require 'nokogiri'

require 'open-uri'
require './DictionaryCheck.rb'

#puts doc

#puts dictionary.is_Word('stud')
#puts dictionary.is_word('asdfasdfasdfasdfa')


def check_left_to_right(line, word_length)
	words = Array.new
	for i in 0...line.length
		unless i + word_length > line.length
			possible_word = line.slice(i, word_length)
			words.push(possible_word)
			words.push(possible_word.reverse)
		end
	end
	return words
end

def check_top_to_bottom(file_contents, word_length)
	words = Array.new
	#copy the text into an array and subarrays
	contents_copy = Array.new(file_contents)
	for i in 0...contents_copy.length
		contents_copy[i] = contents_copy[i].split('')
	end

	#now that it's an array, we can transpose it (rotate it 90 degrees)
	contents_copy = contents_copy.transpose
	#now join all of the subarrays into a string again
	for i in 0...contents_copy.length
		contents_copy[i] = contents_copy[i].join('')
	end
	#since it is rotated, checking left to right is the same as checking top to bottom
	for i in 0...contents_copy.length
		words += check_left_to_right(contents_copy[i], word_length)
	end
	return words
end

def check_top_left_to_bottom_right(file_contents, word_length)
	#treat these lines like a puzzle from left to right
	possible_words = Array.new
	diagonal_lines = get_diagonal_lines(file_contents)
	for i in 0...diagonal_lines.length
		possible_words += check_left_to_right(diagonal_lines[i], word_length)
	end
	return possible_words
end

#get the lines that run left to right diagonally
def get_diagonal_lines(file_contents)
	contents_copy = Array.new(file_contents)
	for i in 0...contents_copy.length
		contents_copy[i] = contents_copy[i].split('')
	end

	diagonal_lines = Array.new
	for i in 0...contents_copy.length
		diagonal_lines.push(take_diagonal_x_slice(contents_copy,i))
		diagonal_lines.push(take_diagonal_y_slice(contents_copy,i))
	end
	#puts diagonal_lines
	return diagonal_lines
end

def take_diagonal_x_slice(arr2d, start_x)
	slice = Array.new
	for x in 0...arr2d[0].length
		unless x + start_x > arr2d[0].length
			slice.push(arr2d[x][start_x + x])
		end
	end

	return slice.join('')
end

def take_diagonal_y_slice(arr2d, start_y)
	slice = Array.new
	for y in 0...arr2d.length
		if y + start_y < arr2d.length && y + start_y < arr2d[0].length
			slice.push(arr2d[start_y + y][y])
		end
	end
	return slice.join('')
end

def check_top_right_to_bottom_left(file_contents, word_length)
	contents_copy = Array.new(file_contents)
	for i in 0...contents_copy.length
		contents_copy[i].reverse!
	end

	possible_words = Array.new
	#since it is reversed, checking top left to bottom right is the same as checking top right to bottom left

	possible_words += check_top_left_to_bottom_right(contents_copy, word_length)

	return possible_words
end

def main
	file_contents = IO.readlines('puzzle.txt')

	for i in 0...file_contents.length
		#puts file_contents[i]
		file_contents[i] = file_contents[i].strip!
	end


	hint_lengths = [ 4, 5, 6, 8, 10 ]


	words = Array.new
	for x in 0...hint_lengths.length
		#go through the wordSearch left to right, finding words
		for i in 0...file_contents.size
			words += check_left_to_right(file_contents[i], hint_lengths[x])
		end
		# puts file_contents

		words += check_top_to_bottom(file_contents, hint_lengths[x])

		words += check_top_left_to_bottom_right(file_contents, hint_lengths[x])
		#puts words

		words += check_top_right_to_bottom_left(file_contents, hint_lengths[x])
		#puts words
	end
	dictionary = DictionaryCheck.new
	for i in 0...words.length
		if dictionary.is_word(words[i])
			puts words[i]
			open('knownWords.txt', 'a') { |f|
				f.puts words[i]
			}
		end
	end
end

main
#get text going left to right
#add it to the array to check
#flip it
#add it to the array to check
#get text going top to bottom
#add it to the array to check
#flip it
#add it to the array to check