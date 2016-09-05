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
		unless i + word_length >= line.length
			possible_word = line.slice(i, word_length)
			words.push(possible_word)
			words.push(possible_word.reverse)
		end
	end
	return words
end

def check_top_to_bottom(file_contents, word_length)
	contents_copy = Array.new(file_contents)

	for i in 0...contents_copy.length
		contents_copy[i] = contents_copy[i].split('')

	end
	rotatedArray = file_contents.transpose

	words = Array.new
	for i in 0...rotatedArray.size
		words += check_left_to_right(rotatedArray, hint_lengths[0])
	end
	return words

end

# def check_top_to_bottom(file_contents, word_length)
# 	#rotatedArray = file_contents.transpose
# 	words = Array.new
# 	puts file_contents[0].length
# 	for i in 0...file_contents[0].length
# 		for j in 0...file_contents.length
# 			unless j + word_length >= file_contents.length
# 				word = ''
# 				for k in 0...word_length
# 					word += file_contents[k]
# 					#puts word
# 				end
# 				puts word
# 			end
# 		end

# 	end


# end

def main
	file_contents = IO.readlines('puzzle.txt')

	hint_lengths = [ 4, 5, 8, 10 ]

	dictionary = DictionaryCheck.new

	words = Array.new
	# for i in 0...file_contents.size
	# 	words += check_left_to_right(file_contents[i], hint_lengths[0])
	# end

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