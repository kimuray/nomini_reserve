class Admin::SubscriptionsController < AdminController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy, :cancel, :restart]

  def index
    @subscriptions = Subscription.page(params[:page])
  end

  def show
  end
  
  def new
    @subscription = Subscription.new
  end

  def edit
  end

  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      redirect_to admin_subscription_url(@subscription), notice: 'subscription was successfully created.'
    else
      render :new
    end
  end

  def update
    if @subscription.update(subscription_params)
      redirect_to @subscription, notice: 'subscription was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @subscription.destroy
    redirect_to admin_subscriptions_url, notice: 'subscription was successfully destroyed.'
  end

  def cancel
    @subscription.cancel!
    redirect_to admin_subscription_url(@subscription), notice: '課金を停止しました'
  end

  def restart
    @subscription.active!
    redirect_to admin_subscription_url(@subscription), notice: '課金を再開しました'
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_id, :status, :customer_id)
  end
end
