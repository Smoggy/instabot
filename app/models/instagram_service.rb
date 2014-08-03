
class InstagramService

	INSTAGRAM_AUTH_URL = "https://api.instagram.com/oauth/authorize/"
	INSTAGRAM_TOKEN = "https://api.instagram.com/oauth/access_token"
	CALLBACK_URL = "http://127.0.0.1:3000/oauth/callback"
	INSTAGRAM_USER_SEARCH = "https://api.instagram.com/v1/users/search"
	INSTAGRAM_USER_INFO = "https://api.instagram.com/v1/users/"
	INSTAGRAM_SELF_FEED = "https://api.instagram.com/v1/users/self/feed"
	INSTAGRAM_MEDIA_INFO = "https://api.instagram.com/v1/media/"


	def self.get_auth_url
		INSTAGRAM_AUTH_URL + "?client_id="+OTHER_ID+"&redirect_uri="+CALLBACK_URL+"&response_type=code&scope=likes"
	end

	def self.get_access_token code
		response = RestClient.post INSTAGRAM_TOKEN, { 
			client_id: OTHER_ID,
			client_secret: OTHER_SECRET,
			grant_type: 'authorization_code',
			redirect_uri: CALLBACK_URL,
			code: code
		}
		JSON.parse(response)

	rescue => e
		binding.pry
	end

	def self.users_search query, access_token
		response = RestClient.get INSTAGRAM_USER_SEARCH, {
			params: {
				q: query,
				access_token: access_token
			}
		}
		JSON.parse(response)
	end

	def self.user_info user_id, access_token
		response = RestClient.get INSTAGRAM_USER_INFO+user_id+"/", {
			params: {
				access_token: access_token
			}
		}
		JSON.parse(response)
	end

	def self.self_feed access_token
		response = RestClient.get INSTAGRAM_SELF_FEED, {
			params: {
				access_token: access_token
			}
		}
		JSON.parse(response)
	end

	def self.media_info media_id, access_token
		response = RestClient.get INSTAGRAM_MEDIA_INFO + media_id, {
			params: {
				access_token: access_token
			}
		}
		JSON.parse(response)
	end

	def self.set_like media_id, access_token
		response = RestClient.post "https://api.instagram.com/v1/media/#{media_id}/likes", {
			access_token: access_token
		}
		JSON.parse(response)

		rescue => e
			e = JSON.parse(e.http_body)
			return { code: e["meta"]["code"], message: e["meta"]["error_message"] }

	end

	def self.get_media_by_tag tag, access_token, min_tag_id = nil
		response =  unless min_tag_id
		 	RestClient.get "https://api.instagram.com/v1/tags/#{tag}/media/recent", {
				params: {
					access_token: access_token
				}
			}
		else
			RestClient.get "https://api.instagram.com/v1/tags/#{tag}/media/recent", {
				params: {
					access_token: access_token,
					min_tag_id: min_tag_id
				}
			}
		end
		JSON.parse(response)
	end

end