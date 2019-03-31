require 'message'
require 'database_helpers'

describe Message do
  describe '.all' do
    it 'returns all the messages in reverse chronological order' do
      Message.post(username: 'riya', message:'Happy Easter')
      Message.post(username: 'riya', message: 'Summer Vibes')
      time = Time.new.strftime('%F %k:%M:00')
      peep = Message.post(username: 'riya', message: 'Merry Christmas')
      messages = Message.all

      expect(messages.length).to eq 3
      expect(messages.first).to be_a Message
      expect(messages.first.id).to eq peep.id
      expect(messages.first.username).to eq 'riya'
      expect(messages.first.message).to eq 'Merry Christmas'
      expect(messages.first.time).to eq time
    end
  end

  describe '.post' do
    it 'should post a message on the feed' do
      peep = Message.post(username: 'riya', message: "Happy Easter")
      persisted_data = persisted_data(id: peep.id)

      expect(peep).to be_a Message
      expect(peep.id).to eq persisted_data['id']
      expect(peep.username).to eq 'riya'
      expect(peep.message).to eq 'Happy Easter'
    end
  end
end
