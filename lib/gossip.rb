# frozen_string_literal:true

class Gossip
  attr_accessor :author, :content, :comments

  def initialize(author, content, comments = [])
    @author = author
    @content = content
    @comments = comments
  end

  def save
    CSV.open('./db/gossip.csv', 'ab') do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    gossip_array = []
    CSV.read('db/gossip.csv').each do |csv|
      csv.length > 2 ? comments = csv[2...csv.length] : comments = []
      gossip_array << Gossip.new(csv[0], csv[1], comments)
    end
    gossip_array
  end

  def self.find(id)
    self.all[id]
  end

  def self.update(id, gossip_author, gossip_content)
    gossips = CSV.read('db/gossip.csv')
    gossips[id][0] = gossip_author if gossip_author != ''
    gossips[id][1] = gossip_content if gossip_content != ''
    CSV.open('db/gossip.csv', 'w') do |csv|
      gossips.each{|gossip| csv << gossip}
    end
  end

  def self.add_comment(id, comment)
    gossips = CSV.read('db/gossip.csv')
    gossips[id] << comment if comment != ''
    CSV.open('db/gossip.csv', 'w') do |csv|
      gossips.each{|gossip| csv << gossip}
    end
  end
end
