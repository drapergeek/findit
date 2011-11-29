class TicketsController < ApplicationController
  def index
    if params[:user]
      @user = User.find_by_id(params[:user])
      @tickets = Ticket.for_user(@user.id).unresolved
    elsif params[:unassigned]
      @tickets = Ticket.unassigned
    elsif params[:area]
      @area = Area.find_by_id(params[:area])
      @tickets = Ticket.for_area(@area.id)
    elsif params[:project]
      @project = Project.find_by_id(params[:project])
      @tickets = Ticket.for_project(@project.id)
    else
      @tickets = Ticket.all
    end
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
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      redirect_to @ticket, :notice => "Successfully created ticket."
    else
      render :action => 'new'
    end
  end
  
  def show_by_area
    @tickets_by_area = Ticket.all.group_by(&:area)
  end
  
  def show_by_project
    @tickets_by_project = Ticket.all.group_by(&:project)
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      redirect_to @ticket, :notice  => "Successfully updated ticket."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to tickets_url, :notice => "Successfully destroyed ticket."
  end
end
