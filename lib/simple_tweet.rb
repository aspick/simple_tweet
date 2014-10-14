require "simple_tweet/version"
require 'twitter'

module SimpleTweet
	@@client = nil
	@@app_name = nil

	def self.setup(hash)
		@@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = hash[:consumer_key]
			config.consumer_secret     = hash[:consumer_secret]
			config.access_token        = hash[:access_token]
			config.access_token_secret = hash[:access_secret]
		end
		@@app_name ||= hash[:app_name]
	end

	def self.update(message)
		text = nil
		date_str = DateTime.now.new_offset(9/24r).strftime("%H:%M:%S")
		if @@app_name
			text = "[#{@@app_name}] #{message} #{date_str}"
		else
			text = "#{message} #{date_str}"
		end

		unless @@client
			puts text
		else
			@@client.update(text)
		end
	end
end
