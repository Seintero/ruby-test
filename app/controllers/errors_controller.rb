# frozen_string_literal: true

# Errors render statuses
class ErrorsController < ApplicationController
  def not_found
    render(status: 404)
  end

  def internal_server_error
    render(status: 500)
  end

  def forbidden_error
    render(status: 403)
  end
end
