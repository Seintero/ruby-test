# frozen_string_literal: true

class OrganizersController < ApplicationController
  def index
    @organizers = Organizer.paginate(page: params[:page], per_page: 8)
  end

  def show
    @organizer = Organizer.includes(:events).find(params[:id])
  end
end
