class OauthController < ApplicationController
  def connect
  	#redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL, :scope => 'likes')
  	redirect_to InstagramService.get_auth_url
  end

  def callback
    response = InstagramService.get_access_token params[:code]
  	#response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)

  	session[:access_token] = response["access_token"]      
  	redirect_to main_index_path
  end
end
