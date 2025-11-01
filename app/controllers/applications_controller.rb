class ApplicationsController < ApplicationController
  
  # GET /applications
   def index
       apps = Application.pluck(:name, :token, :chats_count)
       render json: apps.map { |name, token, chats_count| { name: name, token: token, chats_count: chats_count } }
   end

  # GET /applications/{token}
  def show
      app = Application.find_by!(token: params[:token])
      render json: { name: app.name, chats_count: app.chats_count, token: app.token }
  end

  # POST /applications
  def create
    token = SecureRandom.hex(16)
    PersistApplicationJob.perform_later(params[:name], token)
    render json: { token: token, name: params[:name] , chats_count: 0}, status: :created
  end

  # PUT /applications/{token}
  def update
     app = Application.find_by!(token: params[:token])
     app.update!(name: params[:name])
     render json: { name: app.name, token: app.token , chats_count: app.chats_count}
  end

end

