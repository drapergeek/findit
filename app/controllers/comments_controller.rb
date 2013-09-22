class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @comment.ticket, :notice => "Successfully added comment."
    else
      if @comment.ticket_id
        @ticket = Ticket.find(@comment.ticket_id)
        @comments = @ticket.comments.order(:created_at)
        render :template=>"/tickets/show"
      else
        logger.info "NO TICKET"
        render :new
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      redirect_to @comment, :notice  => "Successfully updated comment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_url, :notice => "Successfully destroyed comment."
  end

  private

  def comment_params
    params.require(:comment).permit(:subject, :body, :ticket_id, :reply, :ticket_status)
  end
end
