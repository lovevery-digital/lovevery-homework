class RegistryController < ApplicationController

  def search
    @child = Child.new
  end
  
  # Long term plans:
  # - Make the search ajax so failures update in place and it redirects on sucess
  # - Don't lose form data on failure so people can edit and check for mistakes
  def find
    # Note: This is a fallback in case someone bipasses the form or uses a browser that doesn't support making fields required
    if params[:child][:parent_name].blank? ||
       params[:child][:full_name].blank? ||
       params[:child][:birthdate].blank?
       redirect_to registry_search_path, alert: "All fields are required to search"
      return
    end
    
    @child = Child.where(child_params).first
    redirect_path = params[:redirect_path] || root_path

    if @child.present?
      redirect_path += redirect_path.include?("?") ? "&" : "?"
      redirect_path += "for=#{@child.user_facing_id}"
      redirect_to redirect_path
    else
      redirect_to registry_search_path(redirect_path: redirect_path), alert: "No children were found."
    end
  end
  
  def child_params
    params.require(:child).permit(:parent_name, :full_name, :birthdate)
  end

end
