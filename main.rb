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

def main
	file_contents = IO.readlines('puzzle.txt')

	for i in 0...file_contents.length
		puts file_contents[i]
		file_contents[i] = file_contents[i].strip!
	end


	hint_lengths = [ 4, 5, 8, 10 ]

	dictionary = DictionaryCheck.new

	words = Array.new
	#go through the wordSearch left to right, finding words
	# for i in 0...file_contents.size
	# 	words += check_left_to_right(file_contents[i], hint_lengths[0])
	# end
	# puts file_contents

	words += check_top_to_bottom(file_contents, hint_lengths[0])

	puts words
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