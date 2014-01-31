class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json

    def index
      render :index
    end


  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  def incoming
    message = Message.create(:user_id => session[:user_id], :msg => params[:msg])
    render :json => {}
  end

  def outgoing
    render :json => Message.where(["id > ?", params[:last_id]]).order("created_at ASC, id ASC")
  end
  # GET /messages/new
  def new
    @messages = Message.all
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.user_id = session[:user_id]
    respond_to do |format|
      if @message.save
        format.html {  redirect_to new_message_path, notice: 'Message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:user_id, :msg)
    end
end
