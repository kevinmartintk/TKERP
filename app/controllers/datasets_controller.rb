class DatasetsController < ActionController::Base

  def clients
    @clients = Client.search_name(params[:query])
  end

end