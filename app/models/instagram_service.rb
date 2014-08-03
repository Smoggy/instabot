
class InstagramService

	INSTAGRAM_AUTH_URL = "https://api.instagram.com/oauth/authorize/"
	CALLBACK_URL = "http://127.0.0.1:3000/oauth/callback"


	def self.get_auth_url
		INSTAGRAM_AUTH_URL + "?client_id="+CLIENT_ID+"&redirect_uri="+CALLBACK_URL+"&response_type=code&scope=likes"
	end

end