class ApplicationsController < ApplicationController
  
  # GET /applications
   def index
       apps = Application.all
       render json: apps.map { |a| { name: a.name, token: a.token, chats_count: a.chats_count } }
   end

  # GET /applications/{token}
  def show
      app = Application.find_by!(token: params[:token])
      render json: { name: app.name, chats_count: app.chats_count, token: app.token }
  end

  # POST /applications
  def create
    app = Application.create!(name: params[:name])
    render json: { token: app.token, name: app.name }, status: :created
  end

  # PUT /applications/{token}
  def update
     app = Application.find_by!(token: params[:token])
     app.update!(name: params[:name])
     render json: { name: app.name, token: app.token }
  end

end

