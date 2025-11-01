class ApplicationsController < ApplicationController
  
  # GET /applications
   def index
       apps = Application.pluck(:name, :token, :chats_count)
       data = apps.map { |name, token, chats_count| { name: name, token: token, chats_count: chats_count } }
       render_success(data: data, message: "Applications retrieved successfully")
   end

  # GET /applications/{token}
  def show
      app = Application.find_by!(token: params[:token])
      data = { name: app.name, token: app.token , chats_count: app.chats_count}
      render_success(data: data, message: "Application retrieved successfully")
  end

  # POST /applications
  def create
    return render_error(message: "Name is missing", status: :bad_request) if params[:name].blank?
    token = SecureRandom.hex(16)
    PersistApplicationJob.perform_later(params[:name], token)
    data = { name: params[:name], token: token , chats_count: 0}
    render_success(data: data, message: "Application created successfully", status: :created)
  end

  # PUT /applications/{token}
  def update
     app = Application.find_by!(token: params[:token])
     app.update!(name: params[:name])
     data = { name: params[:name], token: app.token , chats_count: app.chats_count}
      render_success(data: data, message: "Application updated successfully")
  end

end

