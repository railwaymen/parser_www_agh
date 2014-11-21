class DataSourcesController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @data_sources = DataSource.all
    respond_with @data_sources
  end
end
