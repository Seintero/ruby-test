# frozen_string_literal: true

class AdminController < ApplicationController
  layout 'admin/application'
  before_action :authenticate_administrator!
end
