class BadgesController < ApplicationController
  before_action :authenticate_user!

  expose :badges, ->{ Badge.with_attached_image.where(user: current_user) }
end
