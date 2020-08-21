module GroupsHelper
  def check_member
    @group.member_groups.approved.pluck(:user_id)
          .include?(current_user.id) || @group.user.eql?(current_user)
  end
end
