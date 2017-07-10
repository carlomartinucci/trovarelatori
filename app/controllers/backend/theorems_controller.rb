class Backend::TheoremsController < Backend::BaseController
  before_action :set_theorem, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /theorems
  # GET /theorems.json
  def index
    @theorems = Theorem.includes(:claim, argument: [:theorems, :theme], consequences: :claim, reasons: :claim)

    # @theorems_grouped_by_argument = Theorem.includes(:claim, :argument).group_by(&:argument)
    # @new_theorem = Theorem.new
  end

  # GET /theorems/1
  # GET /theorems/1.json
  def show
    # @new_theorem = Theorem.new argument_id: @theorem.argument_id
  end

  # GET /theorems/new
  def new
    @theorem = Theorem.new
  end

  # GET /theorems/1/edit
  def edit
  end

  # POST /theorems
  # POST /theorems.json
  def create
    @theorem = Theorem.new(theorem_params.merge({user_id: current_user.id}))
    consequence_id = params[:consequence_id]
    reason_id = params[:reason_id]
    redirect_path = request.referer || [:backend, @theorem]

    respond_to do |format|
      if @theorem.save
        if consequence_id.present?
          Connection.create(reason_id: @theorem.id, consequence_id: consequence_id)
        elsif reason_id.present?
          Connection.create(reason_id: reason_id, consequence_id: @theorem.id)
        end
        format.html { redirect_to redirect_path, notice: 'Theorem was successfully created.' }
        format.json { render :show, status: :created, location: @theorem }
        format.js {
          @argument = @theorem.argument
        }
      else
        format.html { index; render :index }
        format.json { render json: @theorem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /theorems/1
  # PATCH/PUT /theorems/1.json
  def update
    redirect_path = request.referer || edit_backend_theorem_path(@theorem)
    respond_to do |format|
      if @theorem.update(theorem_params)
        format.html { redirect_to redirect_path, notice: 'Theorem was successfully updated.' }
        format.json { render :show, status: :ok, location: @theorem }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @theorem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /theorems/1
  # DELETE /theorems/1.json
  def destroy
    redirect_path = request.referer || backend_theorems_url
    
    @theorem.destroy
    respond_to do |format|
      format.html { redirect_to redirect_path, notice: 'Theorem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theorem
      @theorem = Theorem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theorem_params
      params.require(:theorem).permit(:argument_id, :claim_id)
    end

end
