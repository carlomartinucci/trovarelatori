class Backend::ClaimsController < Backend::BaseController
  before_action :set_claim, only: [:show, :edit, :update, :destroy]

  authorize_resource
  
  # GET /claims
  # GET /claims.json
  def index
    @claims = Claim.includes(:user)
  end

  # GET /claims/1
  # GET /claims/1.json
  def show
  end

  # GET /claims/new
  def new
    @claim = Claim.new
  end

  # GET /claims/1/edit
  def edit
  end

  # POST /claims
  # POST /claims.json
  def create
    @claim = Claim.new(claim_params.merge({user_id: current_user.id}))

    respond_to do |format|
      if @claim.save
        format.html { redirect_to backend_claims_path, notice: 'Claim was successfully created.' }
        format.json { render :show, status: :created, location: @claim }
      else
        format.html { render :new }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claims/1
  # PATCH/PUT /claims/1.json
  def update
    respond_to do |format|
      if @claim.update(claim_params)
        format.html { redirect_to @claim, notice: 'Claim was successfully updated.' }
        format.json { render :show, status: :ok, location: @claim }
      else
        format.html { render :edit }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claims/1
  # DELETE /claims/1.json
  def destroy
    respond_to do |format|
      if @claim.theorems.empty? && @claim.destroy
        format.html { redirect_to backend_claims_path, notice: 'Claim was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to backend_claims_path, notice: 'Cannot destroy with theorems present.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim
      @claim = Claim.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_params
      params.require(:claim).permit(:value)
    end

end
