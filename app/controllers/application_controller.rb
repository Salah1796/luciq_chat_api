class ApplicationController < ActionController::API

  def render_response(data: {}, success: true, message: nil, status: :ok)
    render json: {
      success: success,
      message: message,
      data: data,
      status: Rack::Utils.status_code(status)
    }, status: status
  end
 
  def render_success(data: {}, message: nil, status: :ok)
    render_response(data: data, success: true, message: message, status: status)
  end

 def render_error(message: nil, status: :unprocessable_entity)
   render_response(success: false, message: message, status: status)
 end
end
