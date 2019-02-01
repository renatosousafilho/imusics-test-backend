class HomeController < ApplicationController
  def index
    if user_signed_in?
      ActionCable.server.broadcast "messages_channel", user: render_current_user
    end
  end

  def render_current_user
    ApplicationController.renderer.render(template: 'api/v1/users/me', locals: { current_resource_owner: current_user })
  end
end
