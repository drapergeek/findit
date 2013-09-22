class TicketsController < ApplicationController
  def index
    @tickets = Ticket.unresolved
  end

  def show
    @ticket = Ticket.find(params[:id])
    @comments = @ticket.comments.order(:created_at)
    @comment = Comment.new(:ticket => @ticket, :user => current_user)
  end

  def take
    @ticket = Ticket.find_by_id(params[:ticket])
    @ticket.worker = current_user
    @ticket.status = 'Open'
    if @ticket.save
      redirect_to @ticket, :notice => "Successfully took Ticket."
    else
      render :action => 'edit'
    end
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to @ticket
    else
      render 'new'
    end
  end

  def show_by_area
    @tickets_by_area = Ticket.unresolved.group_by(&:area)
  end

  def show_by_project
    @tickets_by_project = Ticket.unresolved.group_by(&:project)
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(ticket_params)
      redirect_to @ticket, :notice  => "Successfully updated ticket."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    logger.info "Ticket was tried to be deleted\n #{@ticket}"
    logger.info "Current User is #{current_user}"
    if @ticket.destroy
      redirect_to tickets_url, :notice => "Successfully destroyed ticket."
    else
      redirect_to tickets_url, :notice => "You can not delete Tickets"
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(permitted_params)
  end

  def permitted_params
    [:title, :description, :status, :submitter_id]
  end
end
