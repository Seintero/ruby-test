class OrganizersController < ApplicationController
  def index
    @organizers = Organizer.paginate(:page => params[:page], :per_page => 9)
  end

  def show
    @organizer = Organizer.find(params[:id])
  end
end
