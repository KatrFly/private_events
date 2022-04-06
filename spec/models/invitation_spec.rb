require 'rails_helper'

RSpec.describe Invitation, :type => :model do
  describe '#create_or_delete_attendance_if_necessary' do
    it 'creates an attendance when an invitation is accepted' do
      invitation = create(:invitation)
      invitation.update(invitation_status: "accepted")

      attendance = Attendance.find_by(user: invitation.user, event: invitation.event)

      expect(attendance).to be_truthy
    end

    it 'does nothing when an invitation is declined and there is no attendance yet' do
      invitation = create(:invitation)
      invitation.update(invitation_status: "declined")

      attendance = Attendance.find_by(user: invitation.user, event: invitation.event)

      expect(attendance).to be_falsy
    end

    it 'destroys an attendance when one exists and an invitation is declined' do
      invitation = create(:invitation)
      invitation.update(invitation_status: "declined")

      attendance = Attendance.find_by(user: invitation.user, event: invitation.event)

      expect(attendance).to be_falsy
    end
  end
end