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
end
