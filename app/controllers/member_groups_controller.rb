class MemberGroupsController < ApplicationController
  before_action :find_group
  before_action :find_member, only: %i(update destroy)
  before_action :load_member_waiting, only: %i(index update destroy)

  def index
    @member_groups = @group.member_groups.approved.includes(:user)
                           .page(params[:page]).per Settings.per_member
  end

  def create
    @member_group = current_user.member_groups
                                .build group_id: @group.id,
                                       status: MemberGroup.statuses[:waiting]
    return unless @member_group.save

    flash[:alert] = t "success"
    render @group
  end

  def edit; end

  def update
    return unless check_page_owner

    @member.approved!
    respond_to :js
  end

  def destroy
    @member.destroy
    respond_to :js
  end

  private

  def find_group
    @group = Group.find_by id: params[:group_id]
    return if @group

    flash[:danger] = t "not_find_group"
    redirect_to root_patg
  end

  def check_page_owner
    current_user.eql? @group.user
  end

  def find_member
    @member = @group.member_groups.find_by id: params[:id]
    return if @member

    flash[:danger] = t "not_find_member"
    redirect_to root_path
  end

  def load_member_waiting
    @member_groups_waitings = @group.member_groups.waiting.includes(:user)
                                    .page(params[:page]).per Settings.per_member
  end
end
