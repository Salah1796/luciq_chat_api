class ApplicationsController < ApplicationController
  
  # GET /applications
  def index
    render_success(
      data: ApplicationsService.list,
      message: "Applications retrieved successfully"
    )
  end

  # GET /applications/{token}
  def show
      data = ApplicationsService.find_by_token(params[:token])
      render_success(data: data, message: "Application retrieved successfully")
  end

  # POST /applications
  def create
    if params[:name].blank?
      return render_error(message: "Name is missing", status: :bad_request)
    end

    render_success(
      data: ApplicationsService.create(params[:name]),
      message: "Application created successfully",
      status: :created
    )
  end

  # PUT /applications/{token}
  def update
     data = ApplicationsService.update(params[:token], params[:name])
     render_success(data: data, message: "Application updated successfully")
  end

end

