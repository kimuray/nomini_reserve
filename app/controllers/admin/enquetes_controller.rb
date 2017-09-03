class Admin::EnquetesController < AdminController
  before_action :set_enquete, only: [:show, :edit, :update, :destroy]

  def index
    @enquetes = Enquete.includes(reservation: [:user, :shop]).page(params[:page])
  end

  def show
  end

  def new
    @enquete = Enquete.new
  end

  def edit
  end

  def create
    @enquete = Enquete.new(enquete_params)

    if @enquete.save
      redirect_to admin_enquete_url(@enquete), notice: 'Enquete was successfully created.'
    else
      render :new
    end
  end

  def update
    if @enquete.update(enquete_params)
      redirect_to admin_enquete_url(@enquete), notice: 'Enquete was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @enquete.destroy
    redirect_to admin_enquetes_url, notice: 'Enquete was successfully destroyed.'
  end

  private
  
  def set_enquete
    @enquete = Enquete.find(params[:id])
  end

  def enquete_params
    params.fetch(:enquete, {}).permit(:reservation_id, :answer_date)
  end
end
