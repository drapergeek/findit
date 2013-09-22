require 'spec_helper'

describe Ticket do
  describe '.unresolved' do
    it 'returns tickets without a status of resolved' do
      resolved = create(:ticket, status: 'Resolved')
      open = create(:ticket, status: 'Open')
      new = create(:ticket, status: 'New')

      unresolved_tickets = Ticket.unresolved

      expect(unresolved_tickets).to match_array([open, new])
    end
  end

  describe '.for_area' do
    it 'will only return tickets for that area' do
      area = create(:area)
      ticket_in_area = create(:ticket, area: area)
      ticket_outside_area = create(:ticket)

      expect(Ticket.for_area(area)).to eq([ticket_in_area])
    end
  end
end
