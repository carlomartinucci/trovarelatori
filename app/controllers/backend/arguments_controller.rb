class Backend::ArgumentsController < Backend::BaseController
  before_action :set_argument, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /arguments
  # GET /arguments.json
  def index
    @arguments = Argument.all
  end

  # GET /arguments/1
  # GET /arguments/1.json
  def show
  end

  # GET /arguments/new
  def new
    @argument = Argument.new
  end

  # GET /arguments/1/edit
  def edit
  end

  # POST /arguments
  # POST /arguments.json
  def create
    redirect_path = request.referer || backend_arguments_path
    @argument = Argument.new(argument_params.merge({user_id: current_user.id}))

    respond_to do |format|
      if @argument.save
        format.html { redirect_to redirect_path, notice: 'Argument was successfully created.' }
        format.json { render :show, status: :created, location: @argument }
      else
        format.html { render :new }
        format.json { render json: @argument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /arguments/1
  # PATCH/PUT /arguments/1.json
  def update
    redirect_path = request.referer || edit_backend_argument_path(@argument)
    respond_to do |format|
      if @argument.update(argument_params)
        format.html { redirect_to redirect_path, notice: 'Argument was successfully updated.' }
        format.json { render :show, status: :ok, location: @argument }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @argument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arguments/1
  # DELETE /arguments/1.json
  def destroy
    redirect_path = request.referer || backend_arguments_url
    @argument.destroy
    respond_to do |format|
      format.html { redirect_to redirect_path, notice: 'Argument was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_argument
      @argument = Argument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def argument_params
      params.require(:argument).permit(:name, :theme_id)
    end
end
