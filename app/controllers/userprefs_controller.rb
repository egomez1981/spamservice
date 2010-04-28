class UserprefsController < ApplicationController

  def index
    conditions = []
    conditions += ["username = '@#{params[:domain]}'"] unless params[:domain].blank?
    conditions += ["username = '#{params[:user]}'"] unless params[:user].blank?
    conditions = conditions.join(" OR ")
    
    @userprefs = Userpref.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10, :conditions => conditions, :order => :username

    for i in (0..@userprefs.size - 1)
      @userprefs[i].username = @userprefs[i].username[1..-1] if @userprefs[i].username.first == "@"
      @userprefs[i].value = @userprefs[i].value[1..-1] if @userprefs[i].value.first == "@"
    end

    if @userprefs
      respond_to do |format|
        format.html
        format.xml {render :xml => @userprefs}
      end
    else
      respond_to do |format|
        format.xml {head :error}
      end
      return
    end
  end

  def show
    @userpref = Userpref.find(params[:id])

    respond_to do |format|
      format.html
      format.xml {render :xml => @userpref}
    end
  end

  def create  
    params[:white_list][:preference] = "whitelist_from"
    normalize_params
    userpref = Userpref.new params[:white_list]
    if userpref.valid? && userpref.save
      respond_to do |format|
        format.html
        format.xml {head :ok}
      end
    else
      respond_to do |format|
        format.html
        format.xml {head :error}
      end
    end
  end

  def update

  end

  def destroy
    @userpref = Userpref.find(params[:id])
    @userpref.destroy
    respond_to do |format|
      format.html
      format.xml {head :ok}
    end
  end

  def clear_all
    Userpref.destroy_all if RAILS_ENV == "cucumber" || RAILS_ENV == "test"

    respond_to do |format|
      format.html
      format.xml {head :ok}
    end
  end

  protected

  def authorize
    authenticate_or_request_with_http_basic do |username, password|
      true
    end
  end

  private
  def normalize_params
    if params[:white_list][:username].split("@").size == 1
      params[:white_list][:username] = "@#{params[:white_list][:username]}"
    end

    if params[:white_list][:value].split("@").size == 1
      params[:white_list][:value] = "@#{params[:white_list][:value]}"
    end
  end
end
