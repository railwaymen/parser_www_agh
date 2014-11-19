class DataSourcesController < ApplicationController
  def index
    @data_sources = DataSource.all
  end
end
