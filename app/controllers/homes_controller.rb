class HomesController < ApplicationController
	skip_before_filter :user_authenticate!
	def index
	end
end
