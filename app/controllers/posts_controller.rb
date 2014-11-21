class PostsController < ApplicationController
  def create
    data_sources = DataSource.where(id: parser_params[:data_source_ids])
    service = ParsingService.new(data_sources)
    service.call
    @posts = Post.where(data_source_id: data_sources.pluck(:id)).order(posted_at: :desc)
    respond_to do |format|
      format.html { render :index }
      format.xml { render xml: @posts }
      format.json { render json: @posts }
    end
  end

  private

  def parser_params
    params.require(:parser).permit(data_source_ids: [])
  end
end
