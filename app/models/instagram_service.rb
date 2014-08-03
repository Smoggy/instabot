
class InstagramService

	INSTAGRAM_AUTH_URL = "https://api.instagram.com/oauth/authorize/"
	INSTAGRAM_TOKEN = "https://api.instagram.com/oauth/access_token"
	CALLBACK_URL = "http://127.0.0.1:3000/oauth/callback"
	INSTAGRAM_USER_SEARCH = "https://api.instagram.com/v1/users/search"
	INSTAGRAM_USER_INFO = "https://api.instagram.com/v1/users/"
	INSTAGRAM_SELF_FEED = "https://api.instagram.com/v1/users/self/feed"


	def self.get_auth_url
		INSTAGRAM_AUTH_URL + "?client_id="+CLIENT_ID+"&redirect_uri="+CALLBACK_URL+"&response_type=code&scope=likes"
	end

	def self.get_access_token code
		response = RestClient.post INSTAGRAM_TOKEN, { 
			client_id: CLIENT_ID,
			client_secret: CLIENT_SECRET,
			grant_type: 'authorization_code',
			redirect_uri: CALLBACK_URL,
			code: code
		}
		JSON.parse(response)
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

end