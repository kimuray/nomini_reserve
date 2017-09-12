class Admin::EnqueteItemsController < AdminController
  before_action :set_enquete_item, only: [:show, :edit, :update, :destroy]

  def index
    @enquete_items = EnqueteItem.page(params[:page])
  end

  def show
  end

  def new
    @enquete_item = EnqueteItem.new
    10.times { @enquete_item.enquete_selections.build }
  end

  def edit
  end

  def create
    @enquete_item = EnqueteItem.new(enquete_item_params)

    if @enquete_item.save
      redirect_to admin_enquete_item_url(@enquete_item), notice: 'Enquete item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @enquete_item.update(enquete_item_params)
      redirect_to admin_enquete_item_url(@enquete_item), notice: 'Enquete item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @enquete_item.destroy
    redirect_to admin_enquete_items_url, notice: 'Enquete item was successfully destroyed.'
  end

  private
 
  def set_enquete_item
    @enquete_item = EnqueteItem.find(params[:id])
  end

  def enquete_item_params
    params.fetch(:enquete_item, {}).permit(
      :content, :answer_type, :invalid_flg,
      enquete_selections_attributes: [:id, :content, :answer_value]
    )
  end
end
