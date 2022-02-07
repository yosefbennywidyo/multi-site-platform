class SessionsController < ApplicationController
  def new
  end

  def create
    puts "session_params.inspect: #{session_params.inspect}"
    @client = Client.find_by(email: session_params[:email])

    if @client && @client.authenticate(session_params[:password])
      session[:current_client_id] = @client.id
      redirect_to root_url, notice: "Logged in!"
    else
      redirect_to login_path, notice: "Invalid email or password"
    end

    puts "SessionsController session.inspect: #{session.inspect}"
    puts "SessionsController session[:current_client_id]: #{session[:current_client_id]}"
  end
  
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to session_url(@session), notice: "Detail of current client was successfully updated." }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session[:current_client_id] = nil

    redirect_to root_url, notice: "Logged out!"
  end
  
  private
    # Only allow a list of trusted parameters through.
    def session_params
      params.permit(:email, :password, :authenticity_token, :commit)
    end
end
