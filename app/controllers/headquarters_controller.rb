class HeadquartersController < ApplicationController
  add_breadcrumb "Headquarters", [:headquarters]

  def index
    @headquarters = Headquarter.all
  end
end