class MainController < ApplicationController
  def index
  	data = InstagramService.get_media_by_tag "like4like", session[:access_token]

  	min_tag_id = data["pagination"]["min_tag_id"]

  	begin
  		images = data["data"]

  		image_array = images.map {|i| [ i["link"], i["id"]] }

  		image_array.each do |image|
  			sleep 12
  			response = InstagramService.set_like image.last, session[:access_token]
  			if response[:code].eql? 429
  				Rails.logger.info "#{response[:message]}"
  			else
  				Rails.logger.info "#{image.first}, #{image.last}"
  			end
  		end

  		data = InstagramService.get_media_by_tag "like4like", session[:access_token], min_tag_id
  		min_tag_id = data["pagination"]["min_tag_id"]
  	end while min_tag_id

  end

  def new
  end
end
