class Api::V1::InvitationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_user, only: [:create]
  before_action :find_device, only: [:create]
  before_action :find_invitation_token, only: [:join_by_token]

  def create
  	invitation = Invitation.where(user_id: @user.id, device_id: @device.id, invitation_limit: Invitation::MAX_LIMIT).first
  	if invitation
  	  invitation.update_attribute(:invitation_expired_at, Time.now + Invitation::MAX_DAYS_EXPIRED * 24 * 60 * 60)
  	else
  	  invitation = Invitation.new(user_id: @user.id, device_id: @device.id)
  	  invitation.invitation_token = SecureRandom.hex[0..11] 
  	  invitation.invitation_expired_at = Time.now + Invitation::MAX_DAYS_EXPIRED * 24 * 60 * 60
  	  invitation.save if invitation.valid?
  	end
  	respond_to do |format|
      format.json do
        render json: { status: 1, message: "ok", data: {invitation_token: invitation.invitation_token} }
      end
    end
  end

  def join_by_token
  	respond_to do |format|
  	  format.json do
	  	if Time.now > @invitation.invitation_expired_at || @invitation.invitation_limit == 0
	      render json: { status: 0, message: "邀请码已过期" }
	    else
	      #todo
	      render json: { status: 1, message: "ok", data: {} }
	    end
	  end
    end
  end

private
  def invitation_token
  	@invitation = Invitation.find_by(invitation_token: params[:invitation_token])
  end

  def find_user
  	@user = User.find_by(open_id: params[:openid])
  end

  def find_device
  	@device = Device.joins(:user_devices).where(:user_devices => { user_id: @user.id }, :devices => { id: params[:device_id] }).first
  end
end