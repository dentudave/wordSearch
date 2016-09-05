require 'rubygems'
require 'nokogiri'
require 'open-uri'

class DictionaryCheck

	def is_word(text)
		request_response = check_dictionary(text)

		return response_indicates_word(request_response)
	end

	def response_indicates_word(response)
		!response.at_css('title').text.empty?
	end

	def check_dictionary(text)
		begin
			doc = Nokogiri::HTML(open('http://www.dictionary.com/browse/' + text + '?s=t'))
			return doc
		rescue OpenURI::HTTPError => e
			if e.message == '404 Not Found'
				return Nokogiri::HTML("<html><head><title/></head></html>")
			else
				raise e
			end
		end
	end
end
