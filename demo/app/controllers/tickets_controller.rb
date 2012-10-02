class TicketsController < ApplicationController
  helper_method :sort_query, :sort_column, :sort_direction

  # GET /tickets/search
  # GET /tickets/search.json
  def search
    # search_condition = "%" + sort_query + "%"
    # @tickets = Ticket.find(:all, :conditions => ['name LIKE ? OR category LIKE ? OR place LIKE ?', search_condition, search_condition, search_condition], :order => (sort_column + ' ' + sort_direction))

    @search = params[:search]
    @query_string = ""

    if(@search[:name] == "")
      query_name = "%"
    else
      query_name = "%" + @search[:name] + "%"
      @query_string = @query_string + @search[:name] + " "
    end
    if(@search[:category] == "")
      query_category = "%"
    else
      query_category = "%" + @search[:category] + "%"
      @query_string = @query_string + @search[:category] + " "
    end
    # query_date = "%" + @search[:date] + "%"
    # query_time = "%" + @search[:time] + "%"
    if(@search[:place] == "")
      query_place = "%"
    else
      query_place = "%" + @search[:place] + "%"
      @query_string = @query_string + @search[:place] + " "
    end

    @tickets = Ticket.find(:all, :conditions => ['name LIKE ? AND category LIKE ? AND place LIKE ?', query_name, query_category, query_place])

    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.json
  def new
    @ticket = Ticket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /tickets
  # POST /tickets.json
  def create

    @ticket = Ticket.new(params[:ticket])

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

  private
  def sort_query
    params[:query] || ""
  end

  def sort_column
    # params[:sort] || "name"
    Ticket.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    # params[:direction] || "asc"
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end
