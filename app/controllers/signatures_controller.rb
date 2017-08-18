class SignaturesController < ApplicationController
  before_action :set_user
  before_action :set_signature, only: [:show, :edit, :update, :destroy]
  skip_before_action :basic_auth, only: [:new, :create] unless Rails.env.development?

  def index
    @signatures = @user.signatures
  end

  def show
  end

  def new
    @signature = @user.signatures.new
    render layout: false
  end

  def edit
  end

  def create
    @signature = @user.signatures.new(signature_params)
    if @signature.save
      head :created
    else
      render :new
    end
  end

  def update
    if @signature.update(signature_params)
      redirect_to [@user, @signature], notice: 'Signature was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @signature.destroy
    redirect_to user_signatures_url(@user), notice: 'Signature was successfully destroyed.'
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_signature
    @signature = @user.signatures.find(params[:id])
  end

  def signature_params
    params.require(:signature).permit(:image, :name)
  end
end
