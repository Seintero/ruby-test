class OrganizersController < ApplicationController
  def index
    @organizers = Organizer.paginate(:page => params[:page], :per_page => 8)
  end

  def show
    @organizer = Organizer.find(params[:id])
  end
end
