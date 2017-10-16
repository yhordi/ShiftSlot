class OrganizationsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end
end
