class ApplicationController < ActionController::Base
  
  private
  
  def get_child
    # Use where instead of find_by so a bad id gracefully fails instead of triggering an exception
    @child = params[:for] && Child.where(user_facing_id: params[:for]).first
  end

end
