class ChatController < ApplicationController
	
	def index
		@users = []
		@chats = Chat.where(["sender_id = ? or reciever_id = ?", current_user.id, current_user.id])
		@chats.each do |chat|
			if chat.sender_id == current_user.id
				@users << User.find(chat.reciever_id)
			else chat.reciever_id == current_user.id
	      @users << User.find(chat.sender_id)
			end
  	@users = @users.uniq
		end
	end

	def show
		@chats = Chat.where(["sender_id IN (?) and reciever_id IN (?)",[current_user.id,params[:id].to_i],[current_user.id,params[:id].to_i]]).order(:id)
	end

	def create
		@chat =Chat.new(chat_params)
		if @chat.save
			redirect_to create_chats_path
			Turbo::StreamsChannel.broadcast_append_to(
	      "new_chat",
	      target: "message_user#{@chat.sender_id}_#{params[:id]}",
	      partial: "chat/chat_message",
	      locals: { chat: @chat }
	    	)
    	Turbo::StreamsChannel.broadcast_append_to(
	      "new_chat",
	      target: "message#{params[:id]}#{@chat.sender_id}",
	      partial: "chat/reciever_chat",
	      locals: { chat: @chat }
	    	)
		end
	end

	def new_chat
		@chat = Chat.new
	end

	def create_chat
		@user = User.find_by(upi: params[:chat][:upi])
		@chat = Chat.new(sender_id:params[:chat][:sender_id].to_i,reciever_id: @user.id,message: params[:chat][:message]).save
		redirect_to chats_path
	end

	private
	
	def chat_params
		params.permit(:sender_id, :reciever_id, :message)
	end

end
