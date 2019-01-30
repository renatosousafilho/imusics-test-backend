class HomeController < ApplicationController
  def index
    ActionCable.server.broadcast "messages_channel", user: render_current_user
  end

  def render_current_user
    ApplicationController.renderer.render(template: 'api/v1/users/me', locals: { current_resource_owner: current_user })
  end
end
